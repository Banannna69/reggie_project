package Reggie.service.impl;

import Reggie.entity.SetmealDish;
import Reggie.mapper.SetMealDishMapper;
import Reggie.service.SetmealDishService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Set;

@Service
@Slf4j
public class SetMealDishServiceImpl extends ServiceImpl<SetMealDishMapper, SetmealDish> implements SetmealDishService {
}
