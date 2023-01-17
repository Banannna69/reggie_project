package Reggie.service.impl;

import Reggie.common.CustomException;
import Reggie.entity.Category;
import Reggie.entity.Dish;
import Reggie.entity.Setmeal;
import Reggie.mapper.CategoryMapper;
import Reggie.service.CategoryService;
import Reggie.service.DishService;
import Reggie.service.SetmealService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category> implements CategoryService {
    @Autowired
    private DishService dishService;

    @Autowired
    private SetmealService setMealService;

    /**
     * 根据id删除分类，在删除之前进行判断
     * @param id
     */
    @Override
    public void remove(Long id) {
        //查询当前分类是否关联菜品，如果已经关联，则抛出异常
        LambdaQueryWrapper<Dish> dishLambdaQueryWrapper = new LambdaQueryWrapper<Dish>();
        //添加查询条件,根据分类id进行查询
        dishLambdaQueryWrapper.eq(Dish::getCategoryId,id);
        int dishCount = dishService.count(dishLambdaQueryWrapper);
        if(dishCount > 0){
            //已经关联菜品，抛出业务异常
            throw new CustomException("当前分类关联了菜品，不能删除");

        }

        //查询当前分类是否关联套餐，如果已经关联，则抛出异常
        LambdaQueryWrapper<Setmeal> setMealLambdaQueryWrapper = new LambdaQueryWrapper<Setmeal>();
        //添加查询条件,根据分类id进行查询
        setMealLambdaQueryWrapper.eq(Setmeal::getCategoryId,id);
        int setMealCount = dishService.count(dishLambdaQueryWrapper);
        if(setMealCount > 0){
            //已经关联套餐，抛出业务异常
            throw new CustomException("当前分类关联了套餐，不能删除");
        }

        //正常删除分类
        super.removeById(id);


    }
}
