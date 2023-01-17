package Reggie.service.impl;

import Reggie.service.SendMailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;


@Service
public class SendMailServiceImpl implements SendMailService {
    @Autowired
    private JavaMailSender mailSender;

    //发送人
    @Value("${spring.mail.username}")
    private String from;

    @Value("${spring.mail.nickname}")
    private String nickname;
    //标题
    private String subject = "登录验证码";

    @Override
    public void sendMail(String to) {
        String code = achieveCode();
        //正文
        String context = "尊敬的用户:你好!\n注册验证码为:" + code + "(有效期为一分钟,请勿告知他人)";
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(nickname+'<'+from+'>');
        message.setTo(to);
        message.setSubject(subject);
        message.setText(context);
        mailSender.send(message);
    }
    @Override
    public void sendMail(String to, String code) {
        String context = "尊敬的用户:你好!\n注册验证码为:" + code + "(有效期为一分钟,请勿告知他人)";
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(nickname+'<'+from+'>');
        message.setTo(to);
        message.setSubject(subject);
        message.setText(context);
        mailSender.send(message);
    }

    @Override
    public  String achieveCode() {  //由于数字 1 、 0 和字母 O 、l 有时分不清楚，所以，没有数字 1 、 0
        String[] beforeShuffle = new String[]{"2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F",
                "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a",
                "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v",
                "w", "x", "y", "z"};
        List<String> list = Arrays.asList(beforeShuffle);//将数组转换为集合
        Collections.shuffle(list);  //打乱集合顺序
        StringBuilder sb = new StringBuilder();
        for (String s : list) {
            sb.append(s); //将集合转化为字符串
        }
        return sb.substring(3, 8).toUpperCase();
    }
}


