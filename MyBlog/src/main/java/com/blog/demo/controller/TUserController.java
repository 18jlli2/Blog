package com.blog.demo.controller;


import com.blog.demo.entity.TUser;
import com.blog.demo.service.TUserService;
import com.blog.demo.utils.RespBean;
import com.blog.demo.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 关注公众号：小L星光
 * @since 2020-11-30
 */
@RestController
public class TUserController {

    @GetMapping("/hello")
    public RespBean test() {
        return RespBean.ok("hello");
    }
}
