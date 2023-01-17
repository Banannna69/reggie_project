package Reggie.filter;

import Reggie.common.BaseContext;
import Reggie.common.Result;
import com.alibaba.fastjson.JSON;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.AntPathMatcher;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 检查用户是否登陆
 */
@WebFilter(filterName = "loginCheckFilter",urlPatterns = "/*")
@Slf4j
public class LoginCheckFilter implements Filter {
    //路径匹配器
    public static final AntPathMatcher PATH_PATTERN = new AntPathMatcher();

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest)servletRequest;
        HttpServletResponse response = (HttpServletResponse)servletResponse;

        //1.获取本次请求的URI
        String requestURI = request.getRequestURI();

        log.info("拦截到的请求：{}",requestURI);

        String[] urls = new String[]{
                "/employee/login",
                "/employee/logout",
                "/backend/**",
                "/front/**",
                "/common/**",
                //对用户登陆操作放行
                "/user/login",
                "/user/sendMsg",
                "/test/**"
        };

        //2.判断本次请求是否需要处理
        boolean check = check(urls,requestURI);

        //3.如果不需要处理，则直接放行
        if(check){
            log.info("本次请求不需要处理：{}",requestURI);
            filterChain.doFilter(request,response);
            return;
        }

        //4.判断登陆状态，如果已登陆，则直接放行
        if(request.getSession().getAttribute("employee") != null){
            log.info("后端用户已登录，用户id为：{}",request.getSession().getAttribute("employee"));
            //获取线程id
            long id = Thread.currentThread().getId();
            log.info("doFilter 线程id为: {}",id);
            //根据session获取之前存的id值
            Long empId = (Long) request.getSession().getAttribute("employee");
            BaseContext.setCurrentId(empId);
            //if(request.getSession().getAttribute("userId")!=null){
            //    return;
            //}
            filterChain.doFilter(request, response);
            return;
        }

        log.info("userId:{}", request.getSession().getAttribute("userId").toString());
        //判断前端用户是否登录
        if(request.getSession().getAttribute("userId") != null){
            log.info("用户已登录，用户id为：{}",request.getSession().getAttribute("userId"));
            Long userid = (Long) request.getSession().getAttribute("userId");
            BaseContext.setCurrentId(userid);
            filterChain.doFilter(request,response);
            return;
        }

        log.info("用户未登录");
        //5.如果未登陆则返回未登陆结果，通过输出流的方式向客户端页面相应数据
        response.getWriter().write(JSON.toJSONString(Result.error("NOTLOGIN")));
    }

    /**
     * 路径匹配，检查本次请求是否需要方放行
     * @param requestURI
     * @param urls
     * @return
     */
    public boolean check(String[] urls, String requestURI){
        for(String url : urls){
            boolean match = PATH_PATTERN.match(url,requestURI);
            if(match){
                return true;
            }
        }
        return false;
    }
}
