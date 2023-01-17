package Reggie.service;

import Reggie.entity.Orders;
import com.baomidou.mybatisplus.extension.service.IService;

import javax.servlet.http.HttpSession;

public interface OrderService extends IService<Orders> {

    void submit(Orders orders, HttpSession session);
}
