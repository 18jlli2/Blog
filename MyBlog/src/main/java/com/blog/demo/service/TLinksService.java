package com.blog.demo.service;

import com.blog.demo.entity.TLinks;
import com.baomidou.mybatisplus.extension.service.IService;
import com.blog.demo.utils.RespBean;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 关注公众号：小L星光
 * @since 2020-11-30
 */
public interface TLinksService extends IService<TLinks> {

    RespBean pageLinks(Long current, Long size);

    RespBean getLinksByName(String name);

    RespBean updateLink(TLinks tLinks);

    RespBean deleteLinkById(Long id);

    RespBean getLinksById(Long id);
}
