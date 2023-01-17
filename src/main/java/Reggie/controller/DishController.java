package Reggie.controller;

import Reggie.common.Result;
import Reggie.dto.DishDto;
import Reggie.entity.Category;
import Reggie.entity.Dish;
import Reggie.entity.DishFlavor;
import Reggie.service.CategoryService;
import Reggie.service.DishFlavorService;
import Reggie.service.DishService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.extern.slf4j.Slf4j;
import lombok.val;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/dish")
@Slf4j
public class DishController {
    @Autowired
    private DishService dishService;

    @Autowired
    private DishFlavorService dishFlavorService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private RedisTemplate redisTemplate;

    /**
     * 新增菜品
     * @param dishDto
     * @return
     */
    @PostMapping
    public Result<String> save(@RequestBody  DishDto dishDto){
        log.info(dishDto.toString());

        dishService.saveWithFlavor(dishDto);
       return Result.success("新增菜品成功");
    }


    /**
     * 菜品信息分页查询
     * @param page
     * @param pageSize
     * @param name
     * @return
     */
    @GetMapping("/page")
    public Result<Page> page(int page,int pageSize, String name){


        //构造分页构造器对象
        Page<Dish> pageInfo = new Page<>(page,pageSize);
        Page<DishDto> dishDtoPage = new Page<>();



        //构造条件构造器
        LambdaQueryWrapper<Dish> queryWrapper = new LambdaQueryWrapper<>();

        //添加过滤条件
        queryWrapper.like(name!=null,Dish::getName,name);

        //添加排序条件
        queryWrapper.orderByDesc(Dish::getUpdateTime);

        //执行分页查询
        dishService.page(pageInfo,queryWrapper);

        //对象拷贝
        BeanUtils.copyProperties(pageInfo,dishDtoPage,"records");

        List<Dish> records =  pageInfo.getRecords();

        List<DishDto> list = records.stream().map((item) -> {
            DishDto dishDto = new DishDto();

            BeanUtils.copyProperties(item,dishDto);
            //分类id
            Long categoryId = item.getCategoryId();
            //根据Id查询分类对象
            Category category = categoryService.getById(categoryId);
            String categoryName = category.getName();
            dishDto.setCategoryName(categoryName);
            return dishDto;

        }).collect(Collectors.toList());

        dishDtoPage.setRecords(list);


        return Result.success(dishDtoPage);
    }


    /**
     * 根据id查询菜品及对应的口味信息
     * @param id
     * @return
     */
    @GetMapping("/{id}")
    public Result<DishDto> get(@PathVariable  Long id){
        DishDto dishDto = dishService.getByIdWithFlavor(id);
        return Result.success(dishDto);
    }


    @PutMapping
    public Result<String> update(@RequestBody  DishDto dishDto){
        log.info(dishDto.toString());

        dishService.updateWithFlavor(dishDto);
        return Result.success("新增菜品成功");
    }

    /**
     * 更新菜品为停售
     * @param ids
     * @return
     */
    @PostMapping("/status/0")
    public Result<String> updateStatusStop(Long[] ids){
        log.info("修改状态为停售：{}",ids);
        List<Long> idList = Arrays.asList(ids);

        for(int i = 0; i < ids.length; i++){
            //获取每个Dish 对象
            Long id = ids[i];
            Dish dish = dishService.getById(id);
            dish.setStatus((0));
            //构造查询构造器对象
            LambdaQueryWrapper<Dish> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            lambdaQueryWrapper.eq(Dish::getId,id);
            if(!dishService.update(dish,lambdaQueryWrapper)){
                return  Result.error("更新失败");
            }
        }
        return Result.success("更新成功");

    }

    /**
     * 更新菜品为出售
     * @param ids
     * @return
     */
    @PostMapping("/status/1")
    public Result<String> updateStatusStart(Long[] ids){
        log.info("修改状态为启售：{}",ids);
        List<Long> idList = Arrays.asList(ids);

        for(int i = 0; i < ids.length; i++){
            //获取每个Dish 对象
            Long id = ids[i];
            Dish dish = dishService.getById(id);
            dish.setStatus((1));
            //构造查询构造器对象
            LambdaQueryWrapper<Dish> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            lambdaQueryWrapper.eq(Dish::getId,id);
            if(!dishService.update(dish,lambdaQueryWrapper)){
                return  Result.error("更新失败");
            }
        }
        return Result.success("更新成功");
    }

    @DeleteMapping
    public Result<String> delete(Long[] ids){
        //逻辑删除
        log.info("根据id删除菜品：{}",ids);
        List<Long> idList = Arrays.asList(ids);

        //根据id删除对应的口味对象
        for(int i = 0; i < ids.length; i++){
            //获取每个Dish对象
            Long id = ids[i];
            LambdaQueryWrapper<DishFlavor> queryWrapper = new LambdaQueryWrapper<>();
            queryWrapper.eq(DishFlavor::getDishId,id);
            //删除菜品对应的口味记录
            dishFlavorService.remove(queryWrapper);
        }
        //删除菜品
        if(!dishService.removeByIds(idList)){
            return Result.success("删除菜品失败");
        }

        return Result.success("删除菜品成功");
    }

    /**
     * 根据条件查询对应的菜品数据
     * @param dish
     * @return
     */
    //@GetMapping("/list")
    //public Result<List<Dish>> list(Dish dish){
    //
    //    LambdaQueryWrapper<Dish> queryWrapper = new LambdaQueryWrapper<>();
    //    queryWrapper.eq(dish.getCategoryId() != null,Dish::getCategoryId,dish.getCategoryId());
    //    //查询状态为1的菜品，表示启售
    //    queryWrapper.eq(Dish::getStatus,1);
    //    //添加排序条件
    //    queryWrapper.orderByAsc(Dish::getSort).orderByDesc(Dish::getUpdateTime);
    //
    //    List<Dish> list = dishService.list(queryWrapper);
    //
    //    return Result.success(list);
    //}



    @GetMapping("/list")
    public Result<List<DishDto>> list(Dish dish){
        List<DishDto> dishDtoList = null;

        String key = "dish_" + dish.getCategoryId()+"_"+dish.getStatus();
        //先从redis中获取缓存数据
        dishDtoList = (List<DishDto>)redisTemplate.opsForValue().get(key);

        if(dishDtoList != null){
            //如果存在，直接返回，无需查询数据库
            return Result.success(dishDtoList);
        }



        LambdaQueryWrapper<Dish> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(dish.getCategoryId() != null,Dish::getCategoryId,dish.getCategoryId());
        //查询状态为1的菜品，表示启售
        queryWrapper.eq(Dish::getStatus,1);
        //添加排序条件
        queryWrapper.orderByAsc(Dish::getSort).orderByDesc(Dish::getUpdateTime);

        List<Dish> list = dishService.list(queryWrapper);


        dishDtoList = list.stream().map((item) -> {
            DishDto dishDto = new DishDto();

            BeanUtils.copyProperties(item,dishDto);
            //分类id
            Long categoryId = item.getCategoryId();
            //根据Id查询分类对象
            Category category = categoryService.getById(categoryId);
            if(category != null){
                String categoryName = category.getName();
                dishDto.setCategoryName(categoryName);
            }
            //当前菜品的id
            Long dishId = item.getId();

            LambdaQueryWrapper<DishFlavor> queryWrapper2 = new LambdaQueryWrapper<>();
            queryWrapper2.eq(DishFlavor ::getDishId,dishId);
            //SQL:select * from dish_flavor where dish_id = ?
            List<DishFlavor> dishFlavorList = dishFlavorService.list(queryWrapper2);
            dishDto.setFlavors(dishFlavorList);

            return dishDto;

        }).collect(Collectors.toList());

        //如果不存在，查询数据库，将查询到的菜品数据缓存到redis
        redisTemplate.opsForValue().set(key,dishDtoList,60, TimeUnit.MINUTES);

        return Result.success(dishDtoList);
    }




}
