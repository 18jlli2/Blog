package com.blog.demo.controller;

import com.blog.demo.service.TUserService;

import com.blog.demo.utils.RespBean;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/t-user")
public class TUserController {
    @GetMapping("/hello")
    public RespBean test() {
        return RespBean.ok("hello");
    }
}
