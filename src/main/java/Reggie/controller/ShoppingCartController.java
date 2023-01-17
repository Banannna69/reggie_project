package Reggie.controller;

import Reggie.common.BaseContext;
import Reggie.common.Result;
import Reggie.entity.ShoppingCart;
import Reggie.service.ShoppingCartService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@Slf4j
@RequestMapping("/shoppingCart")
public class ShoppingCartController {
    @Autowired
    private ShoppingCartService shoppingCartService;

    /**
     * 添加购物车
     * @param shoppingCart
     * @return
     */
    @PostMapping("/add")
    public Result<ShoppingCart> add(@RequestBody ShoppingCart shoppingCart, HttpSession session) {
        log.info("购物车数据：{}", shoppingCart);
        //获取当前用户id
        //Long currentId = BaseContext.getCurrentId();
        Long currentId = (Long)session.getAttribute("userId");
        log.info("用户id:{}",currentId);
        //设置当前用户id
        shoppingCart.setUserId(currentId);

        //查询当前菜品或套餐是否在购物车中
        Long dishId = shoppingCart.getDishId();
        //条件构造器
        LambdaQueryWrapper<ShoppingCart> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ShoppingCart ::getUserId,currentId );
        //判断添加的是菜品还是套餐
        if (dishId != null) {
            queryWrapper.eq(ShoppingCart::getDishId, dishId);
        } else {
            queryWrapper.eq(ShoppingCart::getSetmealId, shoppingCart.getSetmealId());
        }

        //查询当前菜品或者套餐是否在购物车中
        //select * from shopping_cart where user_id = ? and dish_id/setmeal_id = ?
        ShoppingCart cartServiceOne = shoppingCartService.getOne(queryWrapper);

        if (cartServiceOne != null) {
            //如果已存在就在当前的数量上加1
            Integer number = cartServiceOne.getNumber();
            cartServiceOne.setNumber(number + 1);
            shoppingCartService.updateById(cartServiceOne);
        } else {
            shoppingCart.setNumber(1);
            shoppingCart.setCreateTime(LocalDateTime.now());
            //如果不存在，则添加到购物车，数量默认为1
            shoppingCartService.save(shoppingCart);
            //这里是为了统一结果，最后都返回cartServiceOne会比较方便
            cartServiceOne = shoppingCart;
        }
        return Result.success(cartServiceOne);

    }

    @GetMapping("/list")
    public Result<List<ShoppingCart>> list(HttpSession session) {
        log.info("查看购物车");
        Long userId = (Long)session.getAttribute("userId");
        log.info("userId: " + userId);
        LambdaQueryWrapper<ShoppingCart> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ShoppingCart::getUserId, userId);
        queryWrapper.orderByDesc(ShoppingCart ::getCreateTime );
        List<ShoppingCart> shoppingCarts = shoppingCartService.list(queryWrapper);
        return Result.success(shoppingCarts);
    }

    @DeleteMapping("/clean")
    public Result<String> clean() {
        LambdaQueryWrapper<ShoppingCart> queryWrapper = new LambdaQueryWrapper<>();
        Long userId = BaseContext.getCurrentId();
        queryWrapper.eq(userId != null, ShoppingCart::getUserId, userId);
        shoppingCartService.remove(queryWrapper);
        return Result.success("成功清空购物车");
    }

    @PostMapping("/sub")
    public Result<ShoppingCart> sub(@RequestBody ShoppingCart shoppingCart, HttpSession session) {
        log.info("购物车数据：{}", shoppingCart);

        Long dishId = shoppingCart.getDishId();
        log.info("dishId:{}", dishId);

        Long setmealId = shoppingCart.getSetmealId();
        log.info("setmealId:{}", setmealId);

        Long currentId = (Long)session.getAttribute("userId");
        log.info("用户id:{}",currentId);

        LambdaQueryWrapper<ShoppingCart> lambdaQueryWrapper = new LambdaQueryWrapper<>();

        if(dishId != null){
            // 此时为dish 需判断数量， 为1 直接删除
            lambdaQueryWrapper.eq(ShoppingCart::getDishId,dishId);
            lambdaQueryWrapper.eq(ShoppingCart::getUserId,currentId);
            ShoppingCart one = shoppingCartService.getOne(lambdaQueryWrapper);
            Integer number = one.getNumber();
            number -= 1;
            one.setNumber(number);
            shoppingCartService.updateById(one);
            if(number <= 0){
                shoppingCartService.remove(lambdaQueryWrapper);
            }
            return Result.success(one);
        }

        if (setmealId != null) {
            //通过setmealId查询购物车套餐数据
            lambdaQueryWrapper.eq(ShoppingCart::getSetmealId, setmealId);
            ShoppingCart setmealCart = shoppingCartService.getOne(lambdaQueryWrapper);
            //将查出来的数据的数量-1
            setmealCart.setNumber(setmealCart.getNumber() - 1);
            Integer currentNum = setmealCart.getNumber();
            //然后判断
            if (currentNum > 0) {
                //大于0则更新
                shoppingCartService.updateById(setmealCart);
            } else if (currentNum == 0) {
                //等于0则删除
                shoppingCartService.removeById(setmealCart.getId());
            }
            return Result.success(setmealCart);
        }

        return Result.error("操作异常");
    }


}
