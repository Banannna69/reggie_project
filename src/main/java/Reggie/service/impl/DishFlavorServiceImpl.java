package Reggie.service.impl;

import Reggie.entity.DishFlavor;
import Reggie.mapper.DishFlavorMapper;
import Reggie.service.DishFlavorService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class DishFlavorServiceImpl extends ServiceImpl<DishFlavorMapper, DishFlavor> implements DishFlavorService {
}
