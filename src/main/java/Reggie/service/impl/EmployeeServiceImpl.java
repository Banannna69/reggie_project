package Reggie.service.impl;

import Reggie.entity.Employee;
import Reggie.mapper.EmployeeMapper;
import Reggie.service.EmployeeService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class EmployeeServiceImpl extends ServiceImpl<EmployeeMapper, Employee> implements EmployeeService {

}
