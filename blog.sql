/*
 Navicat Premium Data Transfer
 Source Server         : localhost本地
 Source Server Type    : MySQL
 Source Server Version : 50719
 Source Host           : localhost:3306
 Source Schema         : blog
 Target Server Type    : MySQL
 Target Server Version : 50719
 File Encoding         : 65001
 Date: 09/03/2021 00:09:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_blog
-- ----------------------------
DROP TABLE IF EXISTS `t_blog`;
CREATE TABLE `t_blog`  (
  `id` bigint(20) NOT NULL COMMENT '博客id',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `first_picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '首图地址',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '博客内容',
  `flag` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '原创',
  `published` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否公开',
  `appreciation` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否开启赞赏',
  `commentabled` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否开启评论',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '\r\n创建时间',
  `recommend` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否可以回复',
  `share_statement` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否已发布',
  `update_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `views` int(11) NULL DEFAULT 0 COMMENT '浏览量',
  `type_id` bigint(20) NULL DEFAULT NULL COMMENT '分类id',
  `type_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '分类名称',
  `user_id` bigint(20) NULL DEFAULT 1 COMMENT '用户id',
  `comment_count` bigint(20) NULL DEFAULT NULL COMMENT '评论次数',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK292449gwg5yf7ocdlmswv9w4j`(`type_id`) USING BTREE,
  INDEX `FK8ky5rrsxh01nkhctmo7d48p82`(`user_id`) USING BTREE,
  CONSTRAINT `FK8ky5rrsxh01nkhctmo7d48p82` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for t_blog_tags
-- ----------------------------
DROP TABLE IF EXISTS `t_blog_tags`;
CREATE TABLE `t_blog_tags`  (
  `blogs_id` bigint(20) NOT NULL COMMENT '博客id',
  `tags_id` bigint(20) NOT NULL COMMENT '标签id',
  INDEX `FK5feau0gb4lq47fdb03uboswm8`(`tags_id`) USING BTREE,
  INDEX `FKh4pacwjwofrugxa9hpwaxg6mr`(`blogs_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_blog_tags
-- ----------------------------
INSERT INTO `t_blog_tags` VALUES (1349746223141113858, 1349746439126798338);
INSERT INTO `t_blog_tags` VALUES (1350003826215661569, 1350009490803556354);
INSERT INTO `t_blog_tags` VALUES (1350016254991171585, 1349746439126798338);
INSERT INTO `t_blog_tags` VALUES (1350017257060728834, 1350017258792976385);
INSERT INTO `t_blog_tags` VALUES (1350017862483345409, 1350017864416919553);
INSERT INTO `t_blog_tags` VALUES (1350053816522887170, 1350053816560635905);
INSERT INTO `t_blog_tags` VALUES (1350053816522887170, 1350053816858431490);

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `admin_comment` bit(1) NULL DEFAULT b'0' COMMENT '是否为管理员评论',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '评论内容',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '昵称',
  `blog_id` bigint(20) NULL DEFAULT NULL COMMENT '博客id',
  `parent_comment_id` bigint(20) NULL DEFAULT NULL COMMENT '父评论id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKke3uogd04j4jx316m1p51e05u`(`blog_id`) USING BTREE,
  INDEX `FK4jj284r3pb7japogvo6h72q95`(`parent_comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES (5, b'1', 'http://47.113.92.137:8888/upload/io/img/2020/4/11/1586535025470.jpg', '111', '2020-11-23 21:11:41', '2553378438@qq.com', '0:0:0:0:0:0:0:1', 'admin222', 4, -1);


-- ----------------------------
-- Table structure for t_contact
-- ----------------------------
DROP TABLE IF EXISTS `t_contact`;
CREATE TABLE `t_contact`  (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `pay_by_wechat` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '微信支付二维码',
  `pay_by_zhi` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '支付宝二维码',
  `qq` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT 'qq账号',
  `wechat` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '微信号',
  `wechat_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '微信二维码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_contact
-- ----------------------------
INSERT INTO `t_contact` VALUES (1, '1556187290@qq.com', 'http://47.113.92.137:8888/upload/io/img/2020/4/6/1586161248887.png', 'http://47.113.92.137:8888/upload/io/img/2020/4/6/1586161235821.jpg', '1556187290', 'weixin', 'http://47.113.92.137:8888/upload/io/img/2020/4/6/1586161319792.jpg');

-- ----------------------------
-- Table structure for t_links
-- ----------------------------
DROP TABLE IF EXISTS `t_links`;
CREATE TABLE `t_links`  (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `blog_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '博客地址',
  `blog_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '博客名称',
  `picture_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '首图',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_links
-- ----------------------------
INSERT INTO `t_links` VALUES (1, 'https://blog.csdn.net/m0_45234510?spm=1011.2124.3001.5343', 'x-dragon8899', 'https://img0.baidu.com/it/u=1028479771,2944343576&fm=26&fmt=auto&gp=0.jpg', '2021-02-26 20:46:59');
INSERT INTO `t_links` VALUES (1365292219942064129, 'http://localhost:8080/#/admin/linksblog', '哈哈12345', 'https://img0.baidu.com/it/u=2070453827,1163403148&fm=26&fmt=auto&gp=0.jpg', '2021-02-26 22:21:35');

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role`  (
  `id` bigint(10) NOT NULL COMMENT '角色id',
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名',
  `nameZh` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色中文名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES (1, 'admin', '管理员');

-- ----------------------------
-- Table structure for t_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag`  (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `color` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '颜色',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_tag
-- ----------------------------
INSERT INTO `t_tag` VALUES (1349746439126798338, NULL, 'vue');
INSERT INTO `t_tag` VALUES (1350009490803556354, NULL, 'mybatis');
INSERT INTO `t_tag` VALUES (1350017258792976385, NULL, 'redis');
INSERT INTO `t_tag` VALUES (1350017864416919553, NULL, 'jpa');
INSERT INTO `t_tag` VALUES (1350053816560635905, NULL, 'war');
INSERT INTO `t_tag` VALUES (1350053816858431490, NULL, 'jar');
INSERT INTO `t_tag` VALUES (1365288930756268033, NULL, '哈哈');

-- ----------------------------
-- Table structure for t_traffic
-- ----------------------------
DROP TABLE IF EXISTS `t_traffic`;
CREATE TABLE `t_traffic`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT 'ip地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_traffic
-- ----------------------------
INSERT INTO `t_traffic` VALUES (1, '2020-11-23 21:10:51', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (2, '2020-11-23 21:12:12', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (3, '2020-11-23 21:12:18', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (4, '2020-11-23 21:18:18', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (5, '2020-11-23 21:48:50', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (6, '2020-11-23 21:57:55', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (7, '2020-11-23 22:01:05', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (8, '2020-11-23 22:07:12', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (9, '2020-11-23 22:07:41', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (10, '2020-11-23 22:09:42', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (11, '2020-11-23 22:14:33', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (12, '2020-11-23 22:20:40', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (13, '2020-11-23 22:21:29', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (14, '2020-11-23 22:21:34', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (15, '2020-11-23 23:31:14', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (16, '2020-11-23 23:35:08', '127.0.0.1');
INSERT INTO `t_traffic` VALUES (17, '2020-11-24 10:15:33', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (18, '2020-11-24 10:16:35', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (19, '2020-11-24 10:17:01', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (20, '2020-11-24 10:17:31', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (21, '2020-11-24 10:17:42', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (22, '2020-11-24 10:18:55', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (23, '2020-11-24 10:19:29', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (24, '2020-11-24 10:22:08', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (25, '2020-11-24 10:22:51', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (26, '2020-11-24 10:23:17', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (27, '2020-11-24 10:23:46', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (28, '2020-11-24 10:24:14', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (29, '2020-11-24 10:25:01', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (30, '2020-11-24 10:25:20', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (31, '2020-11-24 10:26:04', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (32, '2020-11-24 10:26:36', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (33, '2020-11-24 10:26:55', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (34, '2020-11-24 10:27:03', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (35, '2020-11-24 10:27:18', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (36, '2020-11-24 10:30:27', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (37, '2020-11-24 10:31:29', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (38, '2020-11-24 10:31:57', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (39, '2020-11-24 10:34:16', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (40, '2020-11-24 10:39:52', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (41, '2020-11-24 10:40:04', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (42, '2020-11-24 10:40:21', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (43, '2020-11-24 10:42:28', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (44, '2020-11-24 10:42:43', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (45, '2020-11-24 10:43:10', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (46, '2020-11-24 10:43:45', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (47, '2020-11-24 10:44:55', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (48, '2020-11-24 10:45:44', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (49, '2020-11-24 10:46:02', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (50, '2020-11-24 10:47:01', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (51, '2020-11-24 10:50:10', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (52, '2020-11-24 10:51:12', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (53, '2020-11-24 10:51:27', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (54, '2020-11-24 10:56:35', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (55, '2020-11-24 10:58:12', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (56, '2020-11-24 10:59:37', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (57, '2020-11-24 10:59:52', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (58, '2020-11-24 11:00:10', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (59, '2020-11-24 11:01:01', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (60, '2020-11-24 11:22:25', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (61, '2020-11-24 11:22:34', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (62, '2020-11-24 11:24:46', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (63, '2020-11-24 11:36:48', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (64, '2020-11-24 11:42:33', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (65, '2020-11-24 11:43:45', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (66, '2020-11-24 11:45:24', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (67, '2020-11-24 11:50:02', '0:0:0:0:0:0:0:1');
INSERT INTO `t_traffic` VALUES (68, '2020-11-24 12:00:18', '0:0:0:0:0:0:0:1');

-- ----------------------------
-- Table structure for t_type
-- ----------------------------
DROP TABLE IF EXISTS `t_type`;
CREATE TABLE `t_type`  (
  `id` bigint(20) NOT NULL COMMENT '分类id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '分类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_type
-- ----------------------------
INSERT INTO `t_type` VALUES (1350003757823340545, 'springboot');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` bigint(20) NOT NULL COMMENT '用户id',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '昵称',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `type` int(11) NULL DEFAULT NULL COMMENT '角色',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1028479771,2944343576&fm=26&gp=0.jpg', '2020-05-19 15:30:23', '1556187290@qq.com', 'admin222', '$2a$10$ySG2lkvjFHY5O0./CPIE1OI8VJsuKYEzOYzqIa7AJR6sEgSzUFOAm', 1, '2020-11-24 12:22:09', 'admin');

-- ----------------------------
-- Table structure for t_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role`  (
  `id` int(11) NOT NULL COMMENT '用户角色id',
  `uid` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `rid` int(11) NULL DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
INSERT INTO `t_user_role` VALUES (1, 1, 1);

SET FOREIGN_KEY_CHECKS = 1;