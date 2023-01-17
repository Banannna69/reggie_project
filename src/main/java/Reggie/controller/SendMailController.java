package Reggie.controller;


import Reggie.entity.User;
import Reggie.service.SendMailService;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/send")
@Slf4j
public class SendMailController {

    @Autowired
    private SendMailService sendMailService;

    /**
     * 邮件发送测试
     * @throws Exception
     */
   @GetMapping("{email}")
    public void testSendMail(@PathVariable String email) {
        log.info("向{}发送邮件",email);
        sendMailService.sendMail(email);
    }

    /**
     * 发送验证码
     * @param user
     */
    @PostMapping
    public void testSendMailPost(@RequestBody User user) {
        log.info("向{}发送发送验证码",user.getPhone());
        //生成验证码
        String code = sendMailService.achieveCode();

        //发送验证码
        //sendMailService.sendMail(user.getPhone(),code);

        //将验证码保存到session
    }

}
