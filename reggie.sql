/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80031 (8.0.31)
 Source Host           : localhost:3306
 Source Schema         : reggie

 Target Server Type    : MySQL
 Target Server Version : 80031 (8.0.31)
 File Encoding         : 65001

 Date: 17/01/2023 13:06:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address_book
-- ----------------------------
DROP TABLE IF EXISTS `address_book`;
CREATE TABLE `address_book` (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `consignee` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '收货人',
  `sex` tinyint NOT NULL COMMENT '性别 0 女 1 男',
  `phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '手机号',
  `province_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '省级区划编号',
  `province_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '省级名称',
  `city_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '市级区划编号',
  `city_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '市级名称',
  `district_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '区级区划编号',
  `district_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '区级名称',
  `detail` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '详细地址',
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '标签',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认 0 否 1是',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint DEFAULT NULL COMMENT '创建人',
  `update_user` bigint DEFAULT NULL COMMENT '修改人',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=COMPACT COMMENT='地址管理';

-- ----------------------------
-- Records of address_book
-- ----------------------------
BEGIN;
INSERT INTO `address_book` (`id`, `user_id`, `consignee`, `sex`, `phone`, `province_code`, `province_name`, `city_code`, `city_name`, `district_code`, `district_name`, `detail`, `label`, `is_default`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613738851104280577, 1613578165057236993, '张三', 1, 'admin@admin.com', NULL, NULL, NULL, NULL, NULL, NULL, '北京中关村', '公司', 0, '2023-01-13 11:24:59', '2023-01-13 11:27:03', NULL, NULL, 0);
INSERT INTO `address_book` (`id`, `user_id`, `consignee`, `sex`, `phone`, `province_code`, `province_name`, `city_code`, `city_name`, `district_code`, `district_name`, `detail`, `label`, `is_default`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613862940041113601, 1613578165057236993, '张三', 1, 'admin@admin.com', NULL, NULL, NULL, NULL, NULL, NULL, '陕西西安', '家', 0, '2023-01-13 19:38:04', '2023-01-13 19:38:08', 1613578165057236993, 1613578165057236993, 0);
INSERT INTO `address_book` (`id`, `user_id`, `consignee`, `sex`, `phone`, `province_code`, `province_name`, `city_code`, `city_name`, `district_code`, `district_name`, `detail`, `label`, `is_default`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613864862106079234, 1613578165057236993, 'admin', 1, 'admin@admin.com', NULL, NULL, NULL, NULL, NULL, NULL, '中国北京中关村', '公司', 1, '2023-01-13 19:45:42', '2023-01-13 19:47:11', 1, 1613578165057236993, 0);
COMMIT;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` bigint NOT NULL COMMENT '主键',
  `type` int DEFAULT NULL COMMENT '类型   1 菜品分类 2 套餐分类',
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '分类名称',
  `sort` int NOT NULL DEFAULT '0' COMMENT '顺序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_category_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=COMPACT COMMENT='菜品及套餐分类';

-- ----------------------------
-- Records of category
-- ----------------------------
BEGIN;
INSERT INTO `category` (`id`, `type`, `name`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES (1397844263642378242, 1, '湘菜', 1, '2021-05-27 09:16:58', '2021-07-15 20:25:23', 1, 1);
INSERT INTO `category` (`id`, `type`, `name`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES (1397844303408574465, 1, '川菜', 2, '2021-05-27 09:17:07', '2021-06-02 14:27:22', 1, 1);
INSERT INTO `category` (`id`, `type`, `name`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES (1397844391040167938, 1, '粤菜', 3, '2021-05-27 09:17:28', '2021-07-09 14:37:13', 1, 1);
INSERT INTO `category` (`id`, `type`, `name`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES (1413341197421846529, 1, '饮品', 11, '2021-07-09 11:36:15', '2021-07-09 14:39:15', 1, 1);
INSERT INTO `category` (`id`, `type`, `name`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES (1413342269393674242, 2, '商务套餐', 5, '2021-07-09 11:40:30', '2021-07-09 14:43:45', 1, 1);
INSERT INTO `category` (`id`, `type`, `name`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES (1413384954989060097, 1, '主食', 12, '2021-07-09 14:30:07', '2021-07-09 14:39:19', 1, 1);
INSERT INTO `category` (`id`, `type`, `name`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES (1413386191767674881, 2, '儿童套餐', 6, '2021-07-09 14:35:02', '2021-07-09 14:39:05', 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for dish
-- ----------------------------
DROP TABLE IF EXISTS `dish`;
CREATE TABLE `dish` (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '菜品名称',
  `category_id` bigint NOT NULL COMMENT '菜品分类id',
  `price` decimal(10,2) DEFAULT NULL COMMENT '菜品价格',
  `code` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '商品码',
  `image` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '图片',
  `description` varchar(400) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '描述信息',
  `status` int NOT NULL DEFAULT '1' COMMENT '0 停售 1 起售',
  `sort` int NOT NULL DEFAULT '0' COMMENT '顺序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_dish_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=COMPACT COMMENT='菜品管理';

-- ----------------------------
-- Records of dish
-- ----------------------------
BEGIN;
INSERT INTO `dish` (`id`, `name`, `category_id`, `price`, `code`, `image`, `description`, `status`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1397851668262465537, '口味蛇', 1397844263642378242, 12800.00, '1234567812345678', '19302d16-a9a9-4283-b070-e0a482c2fe09.jpeg', '爬行界的扛把子，东兴-口味蛇，让你欲罢不能', 1, 0, '2021-05-27 09:46:23', '2023-01-11 13:35:12', 1, 1, 0);
INSERT INTO `dish` (`id`, `name`, `category_id`, `price`, `code`, `image`, `description`, `status`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1397852391150759938, '辣子鸡丁', 1397844303408574465, 8800.00, '2346812468', 'b8a2f3e2-c584-4908-8584-7c7a0f590327.jpg', '辣子鸡丁，辣子鸡丁，永远的魂', 1, 0, '2021-05-27 09:49:16', '2023-01-11 13:38:22', 1, 1, 0);
INSERT INTO `dish` (`id`, `name`, `category_id`, `price`, `code`, `image`, `description`, `status`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1397853183287013378, '麻辣兔头', 1397844303408574465, 19800.00, '123456787654321', 'd6d71d97-fb4e-40aa-a65c-4edcf11e5cda.jpg', '麻辣兔头的详细制作，麻辣鲜香，色泽红润，回味悠长', 1, 0, '2021-05-27 09:52:24', '2023-01-11 13:38:12', 1, 1, 0);
INSERT INTO `dish` (`id`, `name`, `category_id`, `price`, `code`, `image`, `description`, `status`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1397853709101740034, '蒜泥白肉', 1397844303408574465, 9800.00, '1234321234321', '5f089624-ae25-4d1d-9a5c-32ab1a82eee6.jpeg', '多么的有食欲啊', 1, 0, '2021-05-27 09:54:30', '2023-01-11 13:35:57', 1, 1, 0);
INSERT INTO `dish` (`id`, `name`, `category_id`, `price`, `code`, `image`, `description`, `status`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1397853890262118402, '鱼香肉丝', 1397844303408574465, 3800.00, '1234212321234', '3012ea54-fbbc-405a-874d-64a9253af9d3.jpg', '鱼香肉丝简直就是我们童年回忆的一道经典菜，上学的时候点个鱼香肉丝盖饭坐在宿舍床上看着肥皂剧，绝了！现在完美复刻一下上学的时候感觉', 1, 0, '2021-05-27 09:55:13', '2023-01-11 13:35:19', 1, 1, 0);
INSERT INTO `dish` (`id`, `name`, `category_id`, `price`, `code`, `image`, `description`, `status`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1397854652581064706, '麻辣水煮鱼', 1397844303408574465, 14800.00, '2345312·345321', '8682277a-8eb8-47e7-a6e0-60577f28f56a.jpg', '鱼片是买的切好的鱼片，放几个虾，增加味道', 1, 0, '2021-05-27 09:58:15', '2023-01-11 13:36:07', 1, 1, 0);
INSERT INTO `dish` (`id`, `name`, `category_id`, `price`, `code`, `image`, `description`, `status`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1397854865672679425, '鱼香炒鸡蛋', 1397844303408574465, 2800.00, '23456431·23456', '924b703c-dd98-4354-acb0-a1e8d978ed07.jpeg', '鱼香菜也是川味的特色。里面没有鱼却鱼香味', 1, 0, '2021-05-27 09:59:06', '2023-01-11 13:36:30', 1, 1, 0);
INSERT INTO `dish` (`id`, `name`, `category_id`, `price`, `code`, `image`, `description`, `status`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1397860242057375745, '脆皮烧鹅', 1397844391040167938, 12800.00, '123456786543213456', '30fb1953-41b4-4455-8ec3-84bf730c18e8.jpeg', '“广东烤鸭美而香，却胜烧鹅说古冈（今新会），燕瘦环肥各佳妙，君休偏重便宜坊”，可见烧鹅与烧鸭在粤菜之中已早负盛名。作为广州最普遍和最受欢迎的烧烤肉食，以它的“色泽金红，皮脆肉嫩，味香可口”的特色，在省城各大街小巷的烧卤店随处可见。', 1, 0, '2021-05-27 10:20:27', '2023-01-11 13:36:45', 1, 1, 0);
INSERT INTO `dish` (`id`, `name`, `category_id`, `price`, `code`, `image`, `description`, `status`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1397860792492666881, '烤乳猪', 1397844391040167938, 38800.00, '213456432123456', '51769c82-5513-425f-9b29-31f15da02da6.jpg', '广式烧乳猪主料是小乳猪，辅料是蒜，调料是五香粉、芝麻酱、八角粉等，本菜品主要通过将食材放入炭火中烧烤而成。烤乳猪是广州最著名的特色菜，并且是“满汉全席”中的主打菜肴之一。烤乳猪也是许多年来广东人祭祖的祭品之一，是家家都少不了的应节之物，用乳猪祭完先人后，亲戚们再聚餐食用。', 1, 0, '2021-05-27 10:22:39', '2023-01-11 13:37:49', 1, 1, 0);
INSERT INTO `dish` (`id`, `name`, `category_id`, `price`, `code`, `image`, `description`, `status`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1413342036832100354, '北冰洋', 1413341197421846529, 500.00, '', 'c3136928-af49-480e-91e9-2d08eec09e51.jpg', '', 1, 0, '2021-07-09 11:39:35', '2023-01-11 13:37:58', 1, 1, 0);
INSERT INTO `dish` (`id`, `name`, `category_id`, `price`, `code`, `image`, `description`, `status`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1413384757047271425, '王老吉', 1413341197421846529, 500.00, '', '5ebb09e7-52f5-46d3-99ff-f5a6031a0847.png', '主食米饭', 1, 0, '2021-07-09 14:29:20', '2023-01-11 13:35:26', 1, 1, 0);
INSERT INTO `dish` (`id`, `name`, `category_id`, `price`, `code`, `image`, `description`, `status`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1413385247889891330, '米饭', 1413384954989060097, 200.00, '', '8a68d2e1-babc-4230-9e51-f27a92fdd6e9.jpg', '', 1, 0, '2021-07-09 14:31:17', '2023-01-11 13:35:37', 1, 1, 0);
INSERT INTO `dish` (`id`, `name`, `category_id`, `price`, `code`, `image`, `description`, `status`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1612410499605020674, '宫保鸡丁', 1397844303408574465, 2000.00, '', '476ff128-86cf-4ddc-8217-f8a67173a4a1.jpg', '', 1, 0, '2023-01-09 19:26:35', '2023-01-11 13:35:45', 1, 1, 0);
COMMIT;

-- ----------------------------
-- Table structure for dish_flavor
-- ----------------------------
DROP TABLE IF EXISTS `dish_flavor`;
CREATE TABLE `dish_flavor` (
  `id` bigint NOT NULL COMMENT '主键',
  `dish_id` bigint NOT NULL COMMENT '菜品',
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '口味名称',
  `value` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '口味数据list',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=COMPACT COMMENT='菜品口味关系表';

-- ----------------------------
-- Records of dish_flavor
-- ----------------------------
BEGIN;
INSERT INTO `dish_flavor` (`id`, `dish_id`, `name`, `value`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1398092283877306370, 1398092283847946241, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-28 01:42:30', '2021-05-28 01:42:30', 1, 1, 0);
INSERT INTO `dish_flavor` (`id`, `dish_id`, `name`, `value`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1612410499739238401, 1612410499605020674, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]', '2023-01-11 13:35:45', '2023-01-11 13:35:45', 1, 1, 0);
INSERT INTO `dish_flavor` (`id`, `dish_id`, `name`, `value`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1612410499747627009, 1612410499605020674, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2023-01-11 13:35:45', '2023-01-11 13:35:45', 1, 1, 0);
INSERT INTO `dish_flavor` (`id`, `dish_id`, `name`, `value`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613047036277424130, 1397853709101740034, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]', '2023-01-11 13:35:57', '2023-01-11 13:35:57', 1, 1, 0);
INSERT INTO `dish_flavor` (`id`, `dish_id`, `name`, `value`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613047079180959745, 1397854652581064706, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2023-01-11 13:36:07', '2023-01-11 13:36:07', 1, 1, 0);
INSERT INTO `dish_flavor` (`id`, `dish_id`, `name`, `value`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613047239462092801, 1397860242057375745, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]', '2023-01-11 13:36:46', '2023-01-11 13:36:46', 1, 1, 0);
INSERT INTO `dish_flavor` (`id`, `dish_id`, `name`, `value`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613047239466287105, 1397860242057375745, '温度', '[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]', '2023-01-11 13:36:46', '2023-01-11 13:36:46', 1, 1, 0);
INSERT INTO `dish_flavor` (`id`, `dish_id`, `name`, `value`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613047506857361410, 1397860792492666881, '温度', '[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]', '2023-01-11 13:37:49', '2023-01-11 13:37:49', 1, 1, 0);
INSERT INTO `dish_flavor` (`id`, `dish_id`, `name`, `value`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613047601027874817, 1397853183287013378, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2023-01-11 13:38:12', '2023-01-11 13:38:12', 1, 1, 0);
INSERT INTO `dish_flavor` (`id`, `dish_id`, `name`, `value`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613047645814652930, 1397852391150759938, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2023-01-11 13:38:22', '2023-01-11 13:38:22', 1, 1, 0);
COMMIT;

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '姓名',
  `username` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '密码',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '身份证号',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态 0:禁用，1:正常',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1611200847016894466 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=COMPACT COMMENT='员工信息';

-- ----------------------------
-- Records of employee
-- ----------------------------
BEGIN;
INSERT INTO `employee` (`id`, `name`, `username`, `password`, `phone`, `sex`, `id_number`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES (1, '管理员', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '13812312312', '1', '110101199001010047', 1, '2021-05-06 17:20:07', '2023-01-05 16:18:17', 1, 1);
INSERT INTO `employee` (`id`, `name`, `username`, `password`, `phone`, `sex`, `id_number`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES (1610896349014859777, '张三', 'zhangsan', 'e10adc3949ba59abbe56e057f20f883e', '13388888888', '1', '111222333444555666', 1, '2023-01-05 15:09:53', '2023-01-05 15:09:53', 1, 1);
INSERT INTO `employee` (`id`, `name`, `username`, `password`, `phone`, `sex`, `id_number`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES (1610906535700049922, '李四', 'lisi', 'e10adc3949ba59abbe56e057f20f883e', '13888888888', '1', '111222333444555666', 1, '2023-01-05 15:50:22', '2023-01-05 15:50:22', 1, 1);
INSERT INTO `employee` (`id`, `name`, `username`, `password`, `phone`, `sex`, `id_number`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES (1610906637432893441, '测试账号', 'root', 'e10adc3949ba59abbe56e057f20f883e', '13888888888', '0', '111111111111111111', 1, '2023-01-05 15:50:46', '2023-01-05 18:23:02', 1, 1);
INSERT INTO `employee` (`id`, `name`, `username`, `password`, `phone`, `sex`, `id_number`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES (1610945299332833281, '张小明', 'xiaoming', 'e10adc3949ba59abbe56e057f20f883e', '13132131345', '1', '110105199804050014', 1, '2023-01-05 18:24:24', '2023-01-06 11:02:31', 1, 1);
INSERT INTO `employee` (`id`, `name`, `username`, `password`, `phone`, `sex`, `id_number`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES (1611200847016894465, '测试账号001', 'test001', 'e10adc3949ba59abbe56e057f20f883e', '13331233456', '1', '612624197708080008', 1, '2023-01-06 11:19:51', '2023-01-09 22:17:21', 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '名字',
  `image` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '图片',
  `order_id` bigint NOT NULL COMMENT '订单id',
  `dish_id` bigint DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '口味',
  `number` int NOT NULL DEFAULT '1' COMMENT '数量',
  `amount` decimal(10,2) NOT NULL COMMENT '金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=COMPACT COMMENT='订单明细表';

-- ----------------------------
-- Records of order_detail
-- ----------------------------
BEGIN;
INSERT INTO `order_detail` (`id`, `name`, `image`, `order_id`, `dish_id`, `setmeal_id`, `dish_flavor`, `number`, `amount`) VALUES (1613859484505047042, '单人套餐B', '542df774-4c89-4dab-8170-ef4cba0543db.jpeg', 1613859484408578050, NULL, 1613038891073290241, NULL, 1, 25.00);
INSERT INTO `order_detail` (`id`, `name`, `image`, `order_id`, `dish_id`, `setmeal_id`, `dish_flavor`, `number`, `amount`) VALUES (1613859484534407169, '王老吉', '5ebb09e7-52f5-46d3-99ff-f5a6031a0847.png', 1613859484408578050, 1413384757047271425, NULL, NULL, 1, 5.00);
INSERT INTO `order_detail` (`id`, `name`, `image`, `order_id`, `dish_id`, `setmeal_id`, `dish_flavor`, `number`, `amount`) VALUES (1613859484538601473, '北冰洋', 'c3136928-af49-480e-91e9-2d08eec09e51.jpg', 1613859484408578050, 1413342036832100354, NULL, NULL, 1, 5.00);
INSERT INTO `order_detail` (`id`, `name`, `image`, `order_id`, `dish_id`, `setmeal_id`, `dish_flavor`, `number`, `amount`) VALUES (1613859709852418049, '单人套餐B', '542df774-4c89-4dab-8170-ef4cba0543db.jpeg', 1613859709814669313, NULL, 1613038891073290241, NULL, 1, 25.00);
INSERT INTO `order_detail` (`id`, `name`, `image`, `order_id`, `dish_id`, `setmeal_id`, `dish_flavor`, `number`, `amount`) VALUES (1613859709856612354, '王老吉', '5ebb09e7-52f5-46d3-99ff-f5a6031a0847.png', 1613859709814669313, 1413384757047271425, NULL, NULL, 1, 5.00);
INSERT INTO `order_detail` (`id`, `name`, `image`, `order_id`, `dish_id`, `setmeal_id`, `dish_flavor`, `number`, `amount`) VALUES (1613859709860806657, '北冰洋', 'c3136928-af49-480e-91e9-2d08eec09e51.jpg', 1613859709814669313, 1413342036832100354, NULL, NULL, 1, 5.00);
INSERT INTO `order_detail` (`id`, `name`, `image`, `order_id`, `dish_id`, `setmeal_id`, `dish_flavor`, `number`, `amount`) VALUES (1613863250847428609, '口味蛇', '19302d16-a9a9-4283-b070-e0a482c2fe09.jpeg', 1613863250784514050, 1397851668262465537, NULL, NULL, 1, 128.00);
INSERT INTO `order_detail` (`id`, `name`, `image`, `order_id`, `dish_id`, `setmeal_id`, `dish_flavor`, `number`, `amount`) VALUES (1613865242571395074, '儿童套餐', '53375f66-177b-41a4-8a3f-70deb9646c58.jpg', 1613865242504286209, NULL, 1613864481640763394, NULL, 1, 50.00);
INSERT INTO `order_detail` (`id`, `name`, `image`, `order_id`, `dish_id`, `setmeal_id`, `dish_flavor`, `number`, `amount`) VALUES (1613871506474991617, '儿童套餐', '53375f66-177b-41a4-8a3f-70deb9646c58.jpg', 1613871506399494145, NULL, 1613864481640763394, NULL, 1, 50.00);
COMMIT;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` bigint NOT NULL COMMENT '主键',
  `number` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '订单号',
  `status` int NOT NULL DEFAULT '1' COMMENT '订单状态 1待付款，2待派送，3已派送，4已完成，5已取消',
  `user_id` bigint NOT NULL COMMENT '下单用户',
  `address_book_id` bigint NOT NULL COMMENT '地址id',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `checkout_time` datetime NOT NULL COMMENT '结账时间',
  `pay_method` int NOT NULL DEFAULT '1' COMMENT '支付方式 1微信,2支付宝',
  `amount` decimal(10,2) NOT NULL COMMENT '实收金额',
  `remark` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '备注',
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `consignee` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=COMPACT COMMENT='订单表';

-- ----------------------------
-- Records of orders
-- ----------------------------
BEGIN;
INSERT INTO `orders` (`id`, `number`, `status`, `user_id`, `address_book_id`, `order_time`, `checkout_time`, `pay_method`, `amount`, `remark`, `phone`, `address`, `user_name`, `consignee`) VALUES (1613859484408578050, '1613859484408578050', 4, 1613578165057236993, 1613738851104280577, '2023-01-13 19:24:20', '2023-01-13 19:24:20', 1, 35.00, '', 'admin@admin.com', '北京中关村', 'admin', '张三');
INSERT INTO `orders` (`id`, `number`, `status`, `user_id`, `address_book_id`, `order_time`, `checkout_time`, `pay_method`, `amount`, `remark`, `phone`, `address`, `user_name`, `consignee`) VALUES (1613859709814669313, '1613859709814669313', 3, 1613578165057236993, 1613738851104280577, '2023-01-13 19:25:14', '2023-01-13 19:25:14', 1, 35.00, '', 'admin@admin.com', '北京中关村', 'admin', '张三');
INSERT INTO `orders` (`id`, `number`, `status`, `user_id`, `address_book_id`, `order_time`, `checkout_time`, `pay_method`, `amount`, `remark`, `phone`, `address`, `user_name`, `consignee`) VALUES (1613863250784514050, '1613863250784514050', 2, 1613578165057236993, 1613862940041113601, '2023-01-13 19:39:18', '2023-01-13 19:39:18', 1, 128.00, '口味蛇', 'admin@admin.com', '陕西西安', 'admin', '张三');
INSERT INTO `orders` (`id`, `number`, `status`, `user_id`, `address_book_id`, `order_time`, `checkout_time`, `pay_method`, `amount`, `remark`, `phone`, `address`, `user_name`, `consignee`) VALUES (1613865242504286209, '1613865242504286209', 4, 1613578165057236993, 1613864862106079234, '2023-01-13 19:47:13', '2023-01-13 19:47:13', 1, 50.00, '', 'admin@admin.com', '中国北京中关村', 'admin', 'admin');
INSERT INTO `orders` (`id`, `number`, `status`, `user_id`, `address_book_id`, `order_time`, `checkout_time`, `pay_method`, `amount`, `remark`, `phone`, `address`, `user_name`, `consignee`) VALUES (1613871506399494145, '1613871506399494145', 2, 1613578165057236993, 1613864862106079234, '2023-01-13 20:12:06', '2023-01-13 20:12:06', 1, 50.00, '', 'admin@admin.com', '中国北京中关村', 'admin', 'admin');
COMMIT;

-- ----------------------------
-- Table structure for setmeal
-- ----------------------------
DROP TABLE IF EXISTS `setmeal`;
CREATE TABLE `setmeal` (
  `id` bigint NOT NULL COMMENT '主键',
  `category_id` bigint NOT NULL COMMENT '菜品分类id',
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '套餐名称',
  `price` decimal(10,2) NOT NULL COMMENT '套餐价格',
  `status` int DEFAULT NULL COMMENT '状态 0:停用 1:启用',
  `code` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '编码',
  `description` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '描述信息',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '图片',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_setmeal_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=COMPACT COMMENT='套餐';

-- ----------------------------
-- Records of setmeal
-- ----------------------------
BEGIN;
INSERT INTO `setmeal` (`id`, `category_id`, `name`, `price`, `status`, `code`, `description`, `image`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1612814290741448706, 1413342269393674242, '单人套餐A', 6800.00, 1, '', '辣子鸡丁单人套餐', '68eb6f8d-e4ef-4e58-a3af-1b066142e183.jpeg', '2023-01-10 22:11:06', '2023-01-11 17:15:20', 1, 1, 0);
INSERT INTO `setmeal` (`id`, `category_id`, `name`, `price`, `status`, `code`, `description`, `image`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613038891073290241, 1413342269393674242, '单人套餐B', 2500.00, 1, '', '单人套餐b', '542df774-4c89-4dab-8170-ef4cba0543db.jpeg', '2023-01-11 13:03:35', '2023-01-11 17:15:33', 1, 1, 0);
INSERT INTO `setmeal` (`id`, `category_id`, `name`, `price`, `status`, `code`, `description`, `image`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613864481640763394, 1413386191767674881, '儿童套餐', 5000.00, 1, '', '儿童套餐', '53375f66-177b-41a4-8a3f-70deb9646c58.jpg', '2023-01-13 19:44:11', '2023-01-13 19:44:11', 1, 1, 0);
COMMIT;

-- ----------------------------
-- Table structure for setmeal_dish
-- ----------------------------
DROP TABLE IF EXISTS `setmeal_dish`;
CREATE TABLE `setmeal_dish` (
  `id` bigint NOT NULL COMMENT '主键',
  `setmeal_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '套餐id ',
  `dish_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '菜品id',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '菜品名称 （冗余字段）',
  `price` decimal(10,2) DEFAULT NULL COMMENT '菜品原价（冗余字段）',
  `copies` int NOT NULL COMMENT '份数',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=COMPACT COMMENT='套餐菜品关系';

-- ----------------------------
-- Records of setmeal_dish
-- ----------------------------
BEGIN;
INSERT INTO `setmeal_dish` (`id`, `setmeal_id`, `dish_id`, `name`, `price`, `copies`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1612808475875823617, '1612808475674497025', '1397851668262465537', '口味蛇', 16800.00, 1, 0, '2023-01-10 21:48:00', '2023-01-10 21:48:00', 1, 1, 0);
INSERT INTO `setmeal_dish` (`id`, `setmeal_id`, `dish_id`, `name`, `price`, `copies`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613102247599681537, '1612814290741448706', '1397852391150759938', '辣子鸡丁', 8800.00, 1, 0, '2023-01-11 17:15:20', '2023-01-11 17:15:20', 1, 1, 0);
INSERT INTO `setmeal_dish` (`id`, `setmeal_id`, `dish_id`, `name`, `price`, `copies`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613102247616458753, '1612814290741448706', '1413384757047271425', '王老吉', 500.00, 1, 0, '2023-01-11 17:15:20', '2023-01-11 17:15:20', 1, 1, 0);
INSERT INTO `setmeal_dish` (`id`, `setmeal_id`, `dish_id`, `name`, `price`, `copies`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613102247624847361, '1612814290741448706', '1413385247889891330', '米饭', 200.00, 1, 0, '2023-01-11 17:15:20', '2023-01-11 17:15:20', 1, 1, 0);
INSERT INTO `setmeal_dish` (`id`, `setmeal_id`, `dish_id`, `name`, `price`, `copies`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613102301156749314, '1613038891073290241', '1413384757047271425', '王老吉', 500.00, 1, 0, '2023-01-11 17:15:33', '2023-01-11 17:15:33', 1, 1, 0);
INSERT INTO `setmeal_dish` (`id`, `setmeal_id`, `dish_id`, `name`, `price`, `copies`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613102301169332225, '1613038891073290241', '1413385247889891330', '米饭', 200.00, 1, 0, '2023-01-11 17:15:33', '2023-01-11 17:15:33', 1, 1, 0);
INSERT INTO `setmeal_dish` (`id`, `setmeal_id`, `dish_id`, `name`, `price`, `copies`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613102301177720834, '1613038891073290241', '1612410499605020674', '宫保鸡丁', 2000.00, 1, 0, '2023-01-11 17:15:33', '2023-01-11 17:15:33', 1, 1, 0);
INSERT INTO `setmeal_dish` (`id`, `setmeal_id`, `dish_id`, `name`, `price`, `copies`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613864481858867202, '1613864481640763394', '1612410499605020674', '宫保鸡丁', 2000.00, 1, 0, '2023-01-13 19:44:11', '2023-01-13 19:44:11', 1, 1, 0);
INSERT INTO `setmeal_dish` (`id`, `setmeal_id`, `dish_id`, `name`, `price`, `copies`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613864481867255810, '1613864481640763394', '1413342036832100354', '北冰洋', 500.00, 1, 0, '2023-01-13 19:44:11', '2023-01-13 19:44:11', 1, 1, 0);
INSERT INTO `setmeal_dish` (`id`, `setmeal_id`, `dish_id`, `name`, `price`, `copies`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613864481871450114, '1613864481640763394', '1413385247889891330', '米饭', 200.00, 1, 0, '2023-01-13 19:44:11', '2023-01-13 19:44:11', 1, 1, 0);
INSERT INTO `setmeal_dish` (`id`, `setmeal_id`, `dish_id`, `name`, `price`, `copies`, `sort`, `create_time`, `update_time`, `create_user`, `update_user`, `is_deleted`) VALUES (1613864481875644417, '1613864481640763394', '1397854865672679425', '鱼香炒鸡蛋', 2800.00, 1, 0, '2023-01-13 19:44:11', '2023-01-13 19:44:11', 1, 1, 0);
COMMIT;

-- ----------------------------
-- Table structure for shopping_cart
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart` (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '名称',
  `image` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '图片',
  `user_id` bigint NOT NULL COMMENT '主键',
  `dish_id` bigint DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '口味',
  `number` int NOT NULL DEFAULT '1' COMMENT '数量',
  `amount` decimal(10,2) NOT NULL COMMENT '金额',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=COMPACT COMMENT='购物车';

-- ----------------------------
-- Records of shopping_cart
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '姓名',
  `phone` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '身份证号',
  `avatar` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '头像',
  `status` int DEFAULT '0' COMMENT '状态 0:禁用，1:正常',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=COMPACT COMMENT='用户信息';

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`id`, `name`, `phone`, `sex`, `id_number`, `avatar`, `status`) VALUES (1613425286161952769, 'zhangsan', '528999959@qq.com', NULL, NULL, NULL, 1);
INSERT INTO `user` (`id`, `name`, `phone`, `sex`, `id_number`, `avatar`, `status`) VALUES (1613578165057236993, 'admin', 'admin@admin.com', NULL, NULL, NULL, 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
