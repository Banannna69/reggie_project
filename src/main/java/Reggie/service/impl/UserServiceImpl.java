package Reggie.service.impl;

import Reggie.entity.User;
import Reggie.mapper.UserMapper;
import Reggie.service.UserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {
}
