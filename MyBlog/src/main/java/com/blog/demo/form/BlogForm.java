package com.blog.demo.form;

import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.blog.demo.entity.TType;
import com.blog.demo.service.TTypeService;
import com.blog.demo.utils.RespBean;
import com.sun.jndi.cosnaming.CNCtx;

import java.util.HashMap;
import java.util.List;

/**
 * 表单校验
 */
public class BlogForm {
    public static RespBean check(HashMap<String,Object> params) {
        String title = (String) params.get("title");
        String description = (String) params.get("description");
        String first_picture = (String) params.get("first_picture");
        String content = (String) params.get("content");
        List<String> tags = (List) params.get("tags");
        Long type_id = Long.parseLong((String) params.get("type_id").toString());
        String type_name=(String) params.get("type_name");
        String flag = (String) params.get("flag");
//        Boolean published = (Boolean) params.get("published");
        RespBean info = new RespBean();
        if (StringUtils.isEmpty(title)) {
            info.setStatus(500);
        }else if (StringUtils.isEmpty(description)) {
            info.setStatus(500);
        }else if (StringUtils.isEmpty(first_picture)) {
            info.setStatus(500);
        }else if (StringUtils.isEmpty(content)) {
            info.setStatus(500);
        }else if (tags.size() == 0) {
            info.setStatus(500);
        }else if (type_id == 0) {
            info.setStatus(500);
        }else if(type_name == null){
            info.setStatus(500);
        }else if (StringUtils.isEmpty(flag)) {
            info.setStatus(500);
        }else {
            info.setStatus(200);
        }
        return info;
    }

    public static RespBean checkTemporaryBlog(HashMap<String,Object> params) {
        String title = (String) params.get("title");
        String description = (String) params.get("description");
        String first_picture = (String) params.get("first_picture");
        String content = (String) params.get("content");
        RespBean info = new RespBean();
        if (StringUtils.isEmpty(title)) {
            info.setStatus(500);
        }else if (StringUtils.isEmpty(description)) {
            info.setStatus(500);
        }else if (StringUtils.isEmpty(first_picture)) {
            info.setStatus(500);
        }else if (StringUtils.isEmpty(content)) {
            info.setStatus(500);
        }
        return info;
    }
}
