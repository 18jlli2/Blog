package com.blog.demo.mapper;

import com.blog.demo.entity.TType;
import com.blog.demo.entity.TUser;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;



/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author 关注公众号：小L星光
 * @since 2020-11-30
 */
@Mapper
public interface TUserMapper extends BaseMapper<TUser> {
   TUser loadUserByUsername(String username);


}
