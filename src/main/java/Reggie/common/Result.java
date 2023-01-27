package Reggie.common;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

@Data
@ApiModel("返回结果")
public class Result<T> implements Serializable {
    @ApiModelProperty("编码")
    private Integer code;

    @ApiModelProperty("错误信息")
    private String msg;

    @ApiModelProperty("数据")
    private T data;

    @ApiModelProperty("动态数据")
    private Map map = new HashMap();

    //这里提供了几个静态方法来返回一个Result对象
    //之前是直接用构造器的set方法也可以实现同样的功能
    //不过此种方式的复用性更高
    public static <T> Result<T> success(T obj){
        Result<T> r = new Result<>();
        r.setCode(1);
        r.setData(obj);
        return r;
    }

    public static <T> Result<T> error(String msg){
        Result<T> r = new Result<>();
        r.setCode(0);
        r.setMsg(msg);
        return r;
    }

    public Result<T> add(String key,String value){
        this.map.put(key,value);
        return this;
    }
}