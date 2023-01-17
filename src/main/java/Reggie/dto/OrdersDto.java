package Reggie.dto;


import Reggie.entity.OrderDetail;
import Reggie.entity.Orders;
import lombok.Data;
import java.util.List;

@Data
public class OrdersDto extends Orders {

    private List<OrderDetail> orderDetails;
	
}
