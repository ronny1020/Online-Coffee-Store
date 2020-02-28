/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
-- PRESETS.

-- For checking purpose:(檢查用)
-- Table names: customers, admins,
-- select * from admins;
-- desc admins;
-- SELECT CUSTOMERID, COUNT(CUSTOMERID) FROM ORDERS GROUP BY CUSTOMERID;

-- 創建database:
DROP database IF EXISTS `coffee`;
create database coffee default character set utf8; -- 預設database coffee: utf8
use coffee;

-- table顧客: customer
-- 刪除已存在之重複table
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `customerID` varchar(5) NOT NULL default '',-- Primary key:流水號
  `cName` varchar(20) collate utf8_unicode_ci NOT NULL, -- 買家姓名
  `cAccount` varchar(20) NOT NULL unique, -- 買家帳號
  `cPassword` varchar(60) NOT NULL unique, -- 買家密碼: 加密後可能加長故取60
  `cSex` enum('F','M') collate utf8_unicode_ci NOT NULL, -- 買家性別
  `cBirthDate` datetime default NULL, -- 買家生日
  `cAddress` varchar(60) default NULL, -- 買家地址
  `cMobile` varchar(24) default NULL, -- 買家手機
  PRIMARY KEY  (`customerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 預設儲存引擎: InnoDB(after php5.5)

-- add dummy datas:
INSERT INTO `customers` VALUES
 ('C001','大名01','dummy01','pwd01','M','1997-01-01','my_dummy_adrs01','0900-000-001')
,('C002','大名02','dummy02','pwd02','F','1997-02-01','my_dummy_adrs02','0900-000-002')
,('C003','大名03','dummy03','pwd03','F','1997-03-01','my_dummy_adrs03','0900-000-003')
,('C004','大名04','dummy04','pwd04','F','1997-04-01','my_dummy_adrs04','0900-000-004')
,('C005','大名05','dummy05','pwd05','F','1997-05-01','my_dummy_adrs05','0900-000-005')
,('C006','大名06','dummy06','pwd06','F','1997-06-01','my_dummy_adrs06','0900-000-006')
,('C007','大名07','dummy07','pwd07','M','1997-07-01','my_dummy_adrs07','0900-000-007')
,('C008','大名08','dummy08','pwd08','M','1997-08-01','my_dummy_adrs08','0900-000-008')
,('C009','大名09','dummy09','pwd09','F','1997-09-01','my_dummy_adrs09','0900-000-009');

-- table管理員: admins
-- 刪除已存在之重複table
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins` (
  `adminID` varchar(5) NOT NULL default '',-- Primary key:流水號
  `aName` varchar(20) collate utf8_unicode_ci default NULL, -- 管理員姓名 
  `aAccount` varchar(20) NOT NULL unique, -- 管理員帳號
  `aPassword` varchar(60) NOT NULL unique, -- 管理員密碼: 加密後可能加長故取60
  `aDepartment` varchar(30) default NULL, -- 管理員部門
  `aTitle` varchar(30) default NULL, -- 管理員職稱
  PRIMARY KEY  (`adminID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 預設儲存引擎: InnoDB(after php5.5)

-- add dummy datas:
INSERT INTO `admins` VALUES
 ('A001','大名01','adm01','pwd01','部門01','部長')
,('A002','大名02','adm02','pwd02','部門02','部長')
,('A003','大名03','adm03','pwd03','部門03','部長');

-- table賣方: sellers
-- 刪除已存在之重複table
DROP TABLE IF EXISTS `sellers`;
CREATE TABLE `sellers` (
  `sellerID` varchar(5) NOT NULL default '',-- Primary key:流水號
  `sName` varchar(20) collate utf8_unicode_ci NOT NULL, -- 賣方稱謂
  `sAccount` varchar(20) NOT NULL, -- 賣方帳號
  `sPassword` varchar(60) NOT NULL, -- 賣方密碼: 加密後可能加長故取60
  `sAddress` varchar(60) default NULL, -- 賣方地址
  `sPhone` varchar(24) default NULL, -- 賣方電話
  PRIMARY KEY  (`sellerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 預設儲存引擎: InnoDB(after php5.5)

-- add dummy datas:
INSERT INTO `sellers` VALUES
 ('S001','會社01','sel01ler','pwd01','my_dummy_adrs01','(99)0000-0001')
,('S002','會社02','sel02ler','pwd02','my_dummy_adrs02','(99)0000-0002')
,('S003','會社03','sel03ler','pwd03','my_dummy_adrs03','(99)0000-0003')
,('S004','會社04','sel04ler','pwd04','my_dummy_adrs04','(99)0000-0004')
,('S005','會社05','sel05ler','pwd05','my_dummy_adrs05','(99)0000-0005');

-- table訂單: orders
-- 刪除已存在之重複table
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `orderID` varchar(5) NOT NULL default '',-- Primary key:流水號
  `customerID` varchar(5) NOT NULL default '',-- Primary key:流水號(買家)
  `OrderDate` datetime default NULL, -- 下單日期:
  PRIMARY KEY  (`orderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 預設儲存引擎: InnoDB(after php5.5)

-- add dummy datas:
INSERT INTO `orders` VALUES
 ('R001','C001','2019-02-18')
,('R002','C001','2019-01-18')
,('R003','C001','2019-12-18')
,('R004','C005','2019-12-08')
,('R005','C003','2019-11-11')
,('R006','C002','2020-02-02')
,('R007','C002','2020-02-02')
,('R008','C009','2020-02-07')
,('R009','C003','2020-02-11')
,('R010','C009','2020-02-15');

-- table訂單詳細: order details
-- 刪除已存在之重複table
DROP TABLE IF EXISTS `order details`;
CREATE TABLE `order details` (
  `orderID` varchar(5) NOT NULL default '',-- Primary key:流水號(訂單)
  `productID` varchar(5) NOT NULL default '',-- Primary key:流水號(商品)
  `Quantity` smallint(6) NOT NULL default '0',-- 數量
  `Discount` float NOT NULL default '0'-- 折扣
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 預設儲存引擎: InnoDB(after php5.5)

-- add dummy datas:
INSERT INTO `order details` VALUES
 ('R001','P005',2,0.75)
,('R002','P005',3,0.75)
,('R003','P005',2,0.85)
,('R004','P005',5,0.95)
,('R005','P003',10,0.5)
,('R006','P002',20,0.5)
,('R007','P002',1,0.8)
,('R008','P001',1,0.9)
,('R009','P003',3,1)
,('R010','P004',3,1);

-- table商品: products
-- 刪除已存在之重複table
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `productID` varchar(5) NOT NULL default '', -- Primary key:流水號(商品)
  `ProductName` varchar(40) NOT NULL default '',-- 商品名
  `sellerID` varchar(5) NOT NULL default '',-- Primary key:流水號(賣方)
  `UnitPrice` decimal(19,4) default NULL, -- 單價
  `UnitsInStock` smallint(6) default NULL -- 庫存數量
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- add dummy datas:
INSERT INTO `products` VALUES
 ('P001','好貨01','S005',100,20)
,('P002','好貨02','S004',200,5)
,('P003','好貨03','S003',1000,10)
,('P004','好貨04','S002',500,10)
,('P005','好貨05','S001',400,100);

-- PRESETS.
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;