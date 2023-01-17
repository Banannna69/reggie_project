package Reggie.service.impl;



import Reggie.common.CustomException;
import Reggie.dto.SetmealDto;
import Reggie.entity.Setmeal;
import Reggie.entity.SetmealDish;
import Reggie.mapper.SetmealMapper;
import Reggie.service.SetmealDishService;
import Reggie.service.SetmealService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Slf4j
@Transactional
public class SetMealServiceImpl extends ServiceImpl<SetmealMapper, Setmeal> implements SetmealService {

    @Autowired
    private SetmealDishService setMealDishService;
    
    



    @Override
    public void saveWithDish(SetmealDto setmealDto) {
        //保存套餐的基本信息，操作setMeal表，执行insert操作
        this.save(setmealDto);

        //拿到与套餐关联的菜品列表
        List<SetmealDish> setmealDishes = setmealDto.getSetmealDishes();
        //菜品列表里面还没赋值SetmealId，所以要遍历赋值关联的setmealDish的id
         for (SetmealDish s : setmealDishes) {
             s.setSetmealId(setmealDto.getId());
         }
        //setmealDishes.stream().map((item) -> {
        //    item.setSetmealId(setmealDto.getId());
        //    return item;
        //}).collect(Collectors.toList());

        setMealDishService.saveBatch(setmealDishes);
    }

    @Override
    @Transactional
    public void removeWithDish(List<Long> ids) {
        //查询套餐状态，确定是否可以删除
        LambdaQueryWrapper<Setmeal> queryWrap = new LambdaQueryWrapper<>();
        queryWrap.in(Setmeal ::getId,ids);
        queryWrap.eq(Setmeal ::getStatus,1 );

        int count  = this.count(queryWrap);

        //如果不能删除，抛出业务异常
        if(count > 0){
            throw new CustomException("套餐正在售卖，无法删除");
        }
        //如果可以删除。先删除套餐表中的数据  setmeal
        this.removeByIds(ids);
        //删除关系表中的数据 setmeal_dish
        //delete from setmeal_dish where setmeal_id in (1,2,3)
        LambdaQueryWrapper<SetmealDish> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.in(SetmealDish::getSetmealId,ids);
        setMealDishService.remove(lambdaQueryWrapper);
    }






}
