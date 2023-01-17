package Reggie.controller;

import Reggie.common.Result;
import Reggie.entity.Category;
import Reggie.service.CategoryService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/category")
@Slf4j
public class CategoryController {
    @Autowired
    private CategoryService categoryService;

    /**
     * 新增菜品分类
     * @param category
     * @return
     */
    @PostMapping
    public Result<String> save(@RequestBody Category category){
        log.info("category:{}",category);
        categoryService.save(category);
        return Result.success("新增分类成功");
    }


    /**
     * 分页查询功能
     * @param page
     * @param pageSize
     * @return
     */
    @GetMapping("/page")
    public Result<Page> page(int page, int pageSize){
        //分页构造器
        Page<Category> pageInfo = new Page<>(page, pageSize);
        //构造条件过滤器
        LambdaQueryWrapper<Category> lambdaQueryWrap = new LambdaQueryWrapper<>();
        //添加排序条件
        lambdaQueryWrap.orderByDesc(Category ::getSort);
        //进行分页查询
        categoryService.page(pageInfo,lambdaQueryWrap);
        return Result.success(pageInfo);
    }

    /**
     * 根绝id删除分类
     * @param id
     * @return
     */
    @DeleteMapping
    public Result<String> delete(Long id){
        log.info("删除分类，id为：{}",id);
        categoryService.remove(id);
        return Result.success("分类信息删除成功");
    }

    /**
     * 根绝id修改分类信息
     * @param category
     * @return
     */
    @PutMapping
    public Result<String> update(@RequestBody Category category){
        log.info("修改分类信息: {}",category);
        categoryService.updateById(category);
        return Result.success("修改分类信息成功");
    }

    /**
     * 根据条件查询分类数据
     * @param category
     * @return
     */
    @GetMapping("/list")
    public Result<List<Category>> list(Category category) {
        //构造条件构造器
        LambdaQueryWrapper<Category> query = new LambdaQueryWrapper<Category>();
        //添加条件
        query.eq(category.getType()!=null,Category::getType,category.getType());
        //添加排序条件
        query.orderByAsc(Category::getSort).orderByDesc(Category::getUpdateTime);
        List<Category> list = categoryService.list(query);

        return Result.success(list);
    }

}
