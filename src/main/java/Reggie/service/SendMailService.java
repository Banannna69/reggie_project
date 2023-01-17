package Reggie.service;


public interface SendMailService  {
    /**
     * 发送邮件
     * @param to
     */
    void sendMail(String to);

    void sendMail(String to,String code);

    /**
     * 获取验证码
     * @return
     */
    String achieveCode();
}
