package Reggie.controller;


import Reggie.common.CustomException;
import Reggie.common.Result;
import Reggie.dto.DishDto;
import Reggie.dto.SetmealDto;
import Reggie.entity.Category;
import Reggie.entity.Dish;
import Reggie.entity.Setmeal;
import Reggie.entity.SetmealDish;
import Reggie.service.CategoryService;
import Reggie.service.DishService;
import Reggie.service.SetmealDishService;
import Reggie.service.SetmealService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.api.R;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 套餐管理
 */
@RestController
@RequestMapping("/setmeal")
@Slf4j
public class SetMealController {

    @Autowired
    private SetmealService setMealService;
    @Autowired
    private SetmealDishService setMealDishService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private DishService dishService;

    @PostMapping
    /**
     * 添加套餐
     * @param setMeal
     * @return
     */
    public Result<String> save(@RequestBody SetmealDto setMealDto){

        log.info("套餐信息:{}",setMealDto);
        setMealService.saveWithDish(setMealDto);
        return Result.success("新增套餐成功");

    }

    /**
     * 套餐分页查询
     * @param page
     * @param pageSize
     * @param name
     * @return
     */
    @GetMapping("/page")
    public Result<Page> page(int page, int pageSize, String name){
        //构造分页构造器对象
        Page<Setmeal> pageInfo = new Page<>(page,pageSize);
        Page<SetmealDto> dtoPage = new Page<>();


        LambdaQueryWrapper<Setmeal> queryWrapper = new LambdaQueryWrapper<>();
        //构造查询条件，根据name进行模糊查询
        queryWrapper.like(name!= null,Setmeal::getName,name);
        //添加排序条件,根据更新时间降序排列
        queryWrapper.orderByDesc(Setmeal::getUpdateTime);

        setMealService.page(pageInfo,queryWrapper);

        //对象拷贝
        BeanUtils.copyProperties(pageInfo, dtoPage,"records");
        List<Setmeal> records = pageInfo.getRecords();


        List<SetmealDto> list = records.stream().map((item) ->{
            SetmealDto setmealDto = new SetmealDto();
            //对象拷贝
            BeanUtils.copyProperties(item, setmealDto);
            //分类id
            Long id = item.getCategoryId();
            //根据分类的id查询分类的对象
            Category category = categoryService.getById(id);
            if(category != null){
                //分类名称
                String categoryName = category.getName();
                setmealDto.setCategoryName(categoryName);
            }
            return setmealDto;
        }).collect(Collectors.toList());

        dtoPage.setRecords(list);
        return Result.success(dtoPage);
    }


    /**
     * 删除套餐以及相应菜品的关联数据
     * @param ids
     * @return
     */
    @DeleteMapping
    public Result<String> delete(@RequestParam List<Long> ids){
        log.info("ids:{}", ids);
        setMealService.removeWithDish(ids);
        return Result.success("套餐删除成功");
    }

    /**
     * 更新套餐为出售
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
            Setmeal setmeal = setMealService.getById(id);
            setmeal.setStatus((1));
            //构造查询构造器对象
            LambdaQueryWrapper<Setmeal> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            lambdaQueryWrapper.eq(Setmeal::getId,id);
            if(!setMealService.update(setmeal,lambdaQueryWrapper)){
                return  Result.error("更新失败");
            }
        }
        return Result.success("更新成功");
    }

    /**
     * 更新套餐为停售
     * @param ids
     * @return
     */
    @PostMapping("/status/0")
    public Result<String> updateStatusStop(Long[] ids){
        log.info("修改状态为启售：{}",ids);
        List<Long> idList = Arrays.asList(ids);

        for(int i = 0; i < ids.length; i++){
            //获取每个Dish 对象
            Long id = ids[i];
            Setmeal setmeal = setMealService.getById(id);
            setmeal.setStatus((0));
            //构造查询构造器对象
            LambdaQueryWrapper<Setmeal> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            lambdaQueryWrapper.eq(Setmeal::getId,id);
            if(!setMealService.update(setmeal,lambdaQueryWrapper)){
                return  Result.error("更新失败");
            }
        }
        return Result.success("更新成功");
    }


    /**
     * 根据id查询套餐信息
     * @param id
     * @return
     */
    @GetMapping("/{id}")
    public Result<SetmealDto> get(@PathVariable  Long id){

        Setmeal setmeal = setMealService.getById(id);
        if(setmeal == null){
            throw new CustomException("套餐信息不存在");
        }
        SetmealDto setmealDto = new SetmealDto();
        BeanUtils.copyProperties(setmeal, setmealDto);

        //查询构造器对象
        LambdaQueryWrapper<SetmealDish> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(SetmealDish ::getSetmealId,id);
        List<SetmealDish> setmealDishes = setMealDishService.list(queryWrapper);
        setmealDto.setSetmealDishes(setmealDishes);
        return Result.success(setmealDto);
    }

    /**
     * 更新套餐
     * @param setmealDto
     * @return
     */
    @PutMapping
    public Result<Setmeal> update(@RequestBody SetmealDto setmealDto){
        log.info(setmealDto.toString());
        List<SetmealDish> setmealDishes = setmealDto.getSetmealDishes();
        Long setmealId = setmealDto.getId();

        //根据id删除setmeal_dish表中对应套餐的数据
        LambdaQueryWrapper<SetmealDish> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(SetmealDish ::getSetmealId,setmealId);
        setMealDishService.remove(queryWrapper);

        //重新添加套餐信息
        setmealDishes = setmealDishes.stream().map((item) ->{
            item.setSetmealId(setmealId);
            return item;
        }).collect(Collectors.toList());

        //更新套餐数据
        setMealService.updateById(setmealDto);
        //更新套餐对应菜品的数据
        setMealDishService.saveBatch(setmealDishes);
        return Result.success(setmealDto);
    }


    /**
     * 根据条件查询套餐数据
     * @return
     */
    @GetMapping("/list")
    public Result<List<Setmeal>> list(Setmeal setmeal){

        LambdaQueryWrapper<Setmeal> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(setmeal.getCategoryId()!=null,Setmeal::getCategoryId,setmeal.getCategoryId());
        queryWrapper.eq(setmeal.getStatus()!=null,Setmeal::getStatus,setmeal.getStatus());
        queryWrapper.orderByDesc(Setmeal::getUpdateTime);
        List<Setmeal> list = setMealService.list(queryWrapper);

        return Result.success(list);
    }


    /**
     * 根据条件获取套餐中的菜品
     * @param id
     * @return
     */
    @GetMapping("/dish/{id}")
    public Result<List<DishDto>> getdish(@PathVariable  Long id){
        LambdaQueryWrapper<SetmealDish> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(SetmealDish::getSetmealId,id);
        //获取套餐中的所有菜品
        List<SetmealDish> list = setMealDishService.list(queryWrapper);

        List<DishDto> dishDtos = list.stream().map((setmealDish) -> {
            DishDto dishDto = new DishDto();
            BeanUtils.copyProperties(setmealDish, dishDto);
            //把套餐中的菜品的基本信息填充的dto中
            Long dishId = setmealDish.getDishId();
            Dish dish = dishService.getById(dishId);
            BeanUtils.copyProperties(dish,dishDto);
            return dishDto;
        }).collect(Collectors.toList());

        return Result.success(dishDtos);
    }


}
