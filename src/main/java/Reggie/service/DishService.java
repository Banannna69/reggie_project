package Reggie.service;

import Reggie.dto.DishDto;
import Reggie.entity.Dish;
import com.baomidou.mybatisplus.extension.service.IService;

public interface DishService extends IService<Dish> {

    //新增菜品，同时插入对应的口味数据。操作两张表:dish dish_flavor
    public void saveWithFlavor(DishDto dishDto);

    //根据id查询菜品及口味信息
    public DishDto getByIdWithFlavor(Long id);

    void updateWithFlavor(DishDto dishDto);
}
