package Reggie.mapper;

import Reggie.entity.Orders;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface OrdersMapper extends BaseMapper<Orders> {
}
