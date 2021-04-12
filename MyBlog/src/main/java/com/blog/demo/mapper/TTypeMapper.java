package com.blog.demo.mapper;

import com.blog.demo.entity.TType;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.blog.demo.utils.RespBean;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author 关注公众号：小L星光
 * @since 2020-11-30
 */
@Mapper
public interface TTypeMapper extends BaseMapper<TType> {

    List<TType> getAllType();

}
