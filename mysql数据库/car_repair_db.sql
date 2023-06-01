/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : car_repair_db

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2018-07-24 13:06:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_barber`
-- ----------------------------
DROP TABLE IF EXISTS `t_barber`;
CREATE TABLE `t_barber` (
  `barberId` int(11) NOT NULL auto_increment COMMENT '维修师id',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `barberAge` int(11) NOT NULL COMMENT '维修师年龄',
  `barberPhoto` varchar(60) NOT NULL COMMENT '维修师照片',
  `workYears` varchar(20) NOT NULL COMMENT '工作经验',
  `barberDesc` varchar(8000) NOT NULL COMMENT '维修师介绍',
  `barberMemo` varchar(800) default NULL COMMENT '维修师备注',
  PRIMARY KEY  (`barberId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_barber
-- ----------------------------
INSERT INTO `t_barber` VALUES ('1', '王帅', '男', '23', 'upload/397cd225-9405-4c53-ada9-a34a72d393b8.jpg', '2年', '<p>从业2年多了，经验丰富</p>', '工作认真负责');
INSERT INTO `t_barber` VALUES ('2', '张雪峰', '男', '28', 'upload/a54b570d-c0e9-495f-a5f8-fd21dcbb9fd3.jpg', '6年', '<p>维修店老板亲自操作，6年工作经验</p>', '测试');

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `noticeId` int(11) NOT NULL auto_increment COMMENT '公告id',
  `title` varchar(80) NOT NULL COMMENT '标题',
  `content` varchar(5000) NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`noticeId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', '汽车维修网站成立了', '<p>本店开展了很多服务项目，你可以选择你喜欢的项目，预约修理师给你服务！</p>', '2018-04-24 22:58:54');

-- ----------------------------
-- Table structure for `t_paiban`
-- ----------------------------
DROP TABLE IF EXISTS `t_paiban`;
CREATE TABLE `t_paiban` (
  `paibanId` int(11) NOT NULL auto_increment COMMENT '排班id',
  `barberObj` int(11) NOT NULL COMMENT '维修师',
  `paibanDate` varchar(20) default NULL COMMENT '排班时间',
  `workTime` varchar(30) NOT NULL COMMENT '工作时间',
  `paibanMemo` varchar(800) default NULL COMMENT '排班备注',
  PRIMARY KEY  (`paibanId`),
  KEY `barberObj` (`barberObj`),
  CONSTRAINT `t_paiban_ibfk_1` FOREIGN KEY (`barberObj`) REFERENCES `t_barber` (`barberId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_paiban
-- ----------------------------
INSERT INTO `t_paiban` VALUES ('1', '1', '2018-04-24', '上午9点-下午14:00', 'test');
INSERT INTO `t_paiban` VALUES ('2', '2', '2018-04-24', '下午13:00到18:00', '上班认真哈');

-- ----------------------------
-- Table structure for `t_serviceitem`
-- ----------------------------
DROP TABLE IF EXISTS `t_serviceitem`;
CREATE TABLE `t_serviceitem` (
  `itemId` int(11) NOT NULL auto_increment COMMENT '项目id',
  `itemName` varchar(60) NOT NULL COMMENT '项目名称',
  `itemPhoto` varchar(60) NOT NULL default '' COMMENT '项目图片',
  `itemType` varchar(20) NOT NULL COMMENT '项目类型',
  `itemDesc` varchar(8000) NOT NULL COMMENT '项目介绍',
  `itemPrice` varchar(20) NOT NULL COMMENT '项目价格',
  `addTime` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_serviceitem
-- ----------------------------
INSERT INTO `t_serviceitem` VALUES ('1', '汽车美容套餐', 'upload/b7524d54-cf4e-46ea-93c9-b5e672305e9a.jpg', '常规维修项目', '<p>给汽车做spa</p>', '10', '2018-04-24 22:57:20');
INSERT INTO `t_serviceitem` VALUES ('2', '汽车保养', 'upload/d3fbc46c-a074-4400-a0d4-76a2880f4e09.jpg', '活动促销项目', '<p>汽车内部清理</p><p><br/></p>', '68', '2018-04-24 22:57:25');

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(30) NOT NULL COMMENT 'user_name',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) default NULL COMMENT '家庭地址',
  `regTime` varchar(20) default NULL COMMENT '注册时间',
  PRIMARY KEY  (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('user1', '123', '李明艳', '女', '2018-03-21', 'upload/c960848f-ec69-4c94-81ac-431d9593902b.jpg', '13589834234', 'mingyan@163.com', '四川成都红星路13号', '2018-04-24 22:57:01');
INSERT INTO `t_userinfo` VALUES ('user2', '123', '张小倩', '女', '2018-04-05', 'upload/b5f0dee7-a0ca-4da8-8d05-65a3b0604cb8.jpg', '13980805241', 'xiaoqian@163.com', '四川德阳市人民南路10号', '2018-04-24 22:57:06');

-- ----------------------------
-- Table structure for `t_userorder`
-- ----------------------------
DROP TABLE IF EXISTS `t_userorder`;
CREATE TABLE `t_userorder` (
  `orderId` int(11) NOT NULL auto_increment COMMENT '预约id',
  `barberObj` int(11) NOT NULL COMMENT '预约维修师',
  `serviceItemObj` int(11) NOT NULL COMMENT '服务项目',
  `orderDate` varchar(20) default NULL COMMENT '预约服务日期',
  `orderTime` varchar(30) NOT NULL COMMENT '预约时间',
  `userObj` varchar(30) NOT NULL COMMENT '预约用户',
  `addTime` varchar(20) default NULL COMMENT '提交时间',
  `orderMemo` varchar(800) default NULL COMMENT '订单备注',
  `shzt` varchar(20) NOT NULL COMMENT '审核状态',
  `replyContent` varchar(800) default NULL COMMENT '管理回复',
  PRIMARY KEY  (`orderId`),
  KEY `barberObj` (`barberObj`),
  KEY `serviceItemObj` (`serviceItemObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_userorder_ibfk_1` FOREIGN KEY (`barberObj`) REFERENCES `t_barber` (`barberId`),
  CONSTRAINT `t_userorder_ibfk_2` FOREIGN KEY (`serviceItemObj`) REFERENCES `t_serviceitem` (`itemId`),
  CONSTRAINT `t_userorder_ibfk_3` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userorder
-- ----------------------------
INSERT INTO `t_userorder` VALUES ('1', '1', '1', '2018-04-24', '下午2点', 'user1', '2018-04-24 22:57:34', '我下午来做汽车美容', '审核通过', '你按时来嘛');
INSERT INTO `t_userorder` VALUES ('4', '1', '1', '2018-04-24', '上午9点', 'user2', '2018-04-24 22:57:48', '我弟弟要来做汽车美容', '待审核', '--');
INSERT INTO `t_userorder` VALUES ('5', '2', '2', '2018-04-24', '下午2点半', 'user2', '2018-04-24 22:57:54', '我准备来做汽车维修，修理师有时间吗？', '审核通过', '有时间你按时来');

-- ----------------------------
-- Table structure for `t_xiaofei`
-- ----------------------------
DROP TABLE IF EXISTS `t_xiaofei`;
CREATE TABLE `t_xiaofei` (
  `xiaofeiId` int(11) NOT NULL auto_increment COMMENT '消费id',
  `serviceItemObj` int(11) NOT NULL COMMENT '消费项目',
  `xiaofeiMoney` float NOT NULL COMMENT '消费金额',
  `userObj` varchar(30) NOT NULL COMMENT '消费用户',
  `xiaofeiTime` varchar(20) default NULL COMMENT '消费时间',
  `barberObj` int(11) NOT NULL COMMENT '服务维修师',
  `xiaofeiMemo` varchar(800) default NULL COMMENT '消费备注',
  PRIMARY KEY  (`xiaofeiId`),
  KEY `serviceItemObj` (`serviceItemObj`),
  KEY `userObj` (`userObj`),
  KEY `barberObj` (`barberObj`),
  CONSTRAINT `t_xiaofei_ibfk_1` FOREIGN KEY (`serviceItemObj`) REFERENCES `t_serviceitem` (`itemId`),
  CONSTRAINT `t_xiaofei_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`),
  CONSTRAINT `t_xiaofei_ibfk_3` FOREIGN KEY (`barberObj`) REFERENCES `t_barber` (`barberId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_xiaofei
-- ----------------------------
INSERT INTO `t_xiaofei` VALUES ('1', '1', '10', 'user1', '2018-04-24 22:58:07', '1', 'test');
INSERT INTO `t_xiaofei` VALUES ('3', '2', '68', 'user2', '2018-04-24 22:58:13', '2', '客户染发');
