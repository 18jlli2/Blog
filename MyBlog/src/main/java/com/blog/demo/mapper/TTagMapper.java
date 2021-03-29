package com.blog.demo.mapper;

import com.blog.demo.entity.TTag;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author 关注公众号：小L星光
 * @since 2020-11-30
 */
public interface TTagMapper extends BaseMapper<TTag> {

    List<TTag> getAllTag();
}
