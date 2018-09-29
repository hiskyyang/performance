/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50520
Source Host           : localhost:3306
Source Database       : performance

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2018-09-29 14:45:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `code`
-- ----------------------------
DROP TABLE IF EXISTS `code`;
CREATE TABLE `code` (
  `codeId` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `value` varchar(50) DEFAULT NULL,
  `sequence` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`codeId`)
) ENGINE=InnoDB AUTO_INCREMENT=12977 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of code
-- ----------------------------
INSERT INTO `code` VALUES ('1', 'team', '1', 'accounts', '1');
INSERT INTO `code` VALUES ('2', 'team', '2', 'activity', '2');
INSERT INTO `code` VALUES ('3', 'team', '3', 'api', '3');
INSERT INTO `code` VALUES ('4', 'team', '4', 'integration', '4');
INSERT INTO `code` VALUES ('5', 'team', '5', 'portfolio', '5');
INSERT INTO `code` VALUES ('6', 'team', '6', 'react', '6');
INSERT INTO `code` VALUES ('7', 'team', '7', 'cogency', '7');
INSERT INTO `code` VALUES ('8', 'level', '2', '成员', '1');
INSERT INTO `code` VALUES ('9', 'level', '1', '组长', '2');
INSERT INTO `code` VALUES ('10', 'level', '0', '部门负责人', '3');
INSERT INTO `code` VALUES ('11', 'examStatus', '0', '开放', '0');
INSERT INTO `code` VALUES ('12', 'examStatus', '1', '关闭', '1');

-- ----------------------------
-- Table structure for `exam`
-- ----------------------------
DROP TABLE IF EXISTS `exam`;
CREATE TABLE `exam` (
  `examId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `startTime` date DEFAULT NULL,
  `endTime` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `createdTime` timestamp NULL DEFAULT NULL,
  `modifiedTime` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`examId`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of exam
-- ----------------------------
INSERT INTO `exam` VALUES ('38', 'BSG-2019-绩效考核', '2018-09-12', '2018-09-13', '0', '2018-09-26 17:42:50', '2018-09-26 17:42:50');

-- ----------------------------
-- Table structure for `measure`
-- ----------------------------
DROP TABLE IF EXISTS `measure`;
CREATE TABLE `measure` (
  `measureId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `weight` int(11) NOT NULL,
  `examId` int(11) NOT NULL,
  `createdTime` timestamp NULL DEFAULT NULL,
  `modifiedTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`measureId`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of measure
-- ----------------------------
INSERT INTO `measure` VALUES ('48', '完成情况', '', '70', '38', '2018-09-26 17:43:01', '2018-09-28 17:05:57');
INSERT INTO `measure` VALUES ('49', '工作效率', '', '20', '38', '2018-09-26 17:43:09', '2018-09-28 17:11:55');
INSERT INTO `measure` VALUES ('52', 'hisky', '', '10', '38', '2018-09-28 17:11:42', '2018-09-28 17:11:42');

-- ----------------------------
-- Table structure for `performance`
-- ----------------------------
DROP TABLE IF EXISTS `performance`;
CREATE TABLE `performance` (
  `performanceId` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `level` varchar(100) DEFAULT NULL,
  `team` varchar(100) DEFAULT NULL,
  `examId` int(11) DEFAULT NULL,
  `measureId` int(11) DEFAULT NULL,
  `measureName` varchar(100) DEFAULT NULL,
  `measureWeight` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `createdUserId` int(11) DEFAULT NULL,
  `createdTime` timestamp NULL DEFAULT NULL,
  `modifiedTime` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`performanceId`)
) ENGINE=InnoDB AUTO_INCREMENT=1672 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of performance
-- ----------------------------
INSERT INTO `performance` VALUES ('1660', '19', 'abby', '组长', 'cogency', '38', '48', '完成情况', '70', '90', '18', '2018-09-28 17:11:46', '2018-09-28 17:13:35');
INSERT INTO `performance` VALUES ('1661', '19', 'abby', '组长', 'cogency', '38', '49', '工作效率', '10', '90', '18', '2018-09-28 17:11:46', '2018-09-28 17:13:35');
INSERT INTO `performance` VALUES ('1662', '19', 'abby', '组长', 'cogency', '38', '52', 'hisky', '10', '90', '18', '2018-09-28 17:11:46', '2018-09-28 17:13:35');
INSERT INTO `performance` VALUES ('1663', '32', 'ben', '成员', 'cogency', '38', '48', '完成情况', '70', '80', '18', '2018-09-28 17:11:46', '2018-09-28 17:13:45');
INSERT INTO `performance` VALUES ('1664', '32', 'ben', '成员', 'cogency', '38', '49', '工作效率', '10', '80', '18', '2018-09-28 17:11:46', '2018-09-28 17:13:45');
INSERT INTO `performance` VALUES ('1665', '32', 'ben', '成员', 'cogency', '38', '52', 'hisky', '10', '80', '18', '2018-09-28 17:11:46', '2018-09-28 17:13:45');
INSERT INTO `performance` VALUES ('1666', '18', 'hisky', '部门负责人', 'cogency', '38', '48', '完成情况', '70', null, '32', '2018-09-28 17:14:05', '2018-09-28 17:14:05');
INSERT INTO `performance` VALUES ('1667', '18', 'hisky', '部门负责人', 'cogency', '38', '49', '工作效率', '20', null, '32', '2018-09-28 17:14:05', '2018-09-28 17:14:05');
INSERT INTO `performance` VALUES ('1668', '18', 'hisky', '部门负责人', 'cogency', '38', '52', 'hisky', '10', null, '32', '2018-09-28 17:14:05', '2018-09-28 17:14:05');
INSERT INTO `performance` VALUES ('1669', '19', 'abby', '组长', 'cogency', '38', '48', '完成情况', '70', '90', '32', '2018-09-28 17:14:05', '2018-09-29 14:09:23');
INSERT INTO `performance` VALUES ('1670', '19', 'abby', '组长', 'cogency', '38', '49', '工作效率', '20', '90', '32', '2018-09-28 17:14:05', '2018-09-29 14:09:23');
INSERT INTO `performance` VALUES ('1671', '19', 'abby', '组长', 'cogency', '38', '52', 'hisky', '10', '90', '32', '2018-09-28 17:14:05', '2018-09-29 14:09:23');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `team` varchar(50) DEFAULT NULL,
  `level` varchar(50) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `firstLog` tinyint(4) DEFAULT NULL,
  `createdTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modifiedTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('18', 'hisky', '123456', '7', '0', '0', '0', '2018-09-21 14:20:10', '2018-09-21 14:20:29');
INSERT INTO `user` VALUES ('19', 'abby', '123456', '7', '1', '1', '0', '2018-09-21 13:58:20', '2018-09-21 11:35:49');
INSERT INTO `user` VALUES ('32', 'ben', '123456', '7', '2', '1', '0', '2018-09-26 17:34:13', '2018-09-26 17:34:25');
