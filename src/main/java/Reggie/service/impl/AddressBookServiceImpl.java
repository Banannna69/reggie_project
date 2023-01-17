package Reggie.service.impl;

import Reggie.entity.AddressBook;
import Reggie.mapper.AddressBookMapper;
import Reggie.service.AddressBookService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class AddressBookServiceImpl extends ServiceImpl<AddressBookMapper, AddressBook> implements AddressBookService {
}
