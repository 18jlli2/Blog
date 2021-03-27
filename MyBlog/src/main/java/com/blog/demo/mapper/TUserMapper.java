package com.blog.demo.mapper;

import com.blog.demo.entity.TUser;

public interface TUserMapper {
    TUser loadUserByUsername(String username);
}
