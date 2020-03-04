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
  `cBirthDate` date default NULL, -- 買家生日
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

-- table顧客: crams
-- 刪除已存在之重複table
DROP TABLE IF EXISTS `crams`;
CREATE TABLE `crams` (
  `cramID` varchar(5) NOT NULL default '',-- 流水號
  `customerID` varchar(5) NOT NULL default '',-- Primary key:流水號(買家)
  `cDate` date default NULL, -- 客訴日期
  `cramContent` varchar(300) default NULL, -- 客訴內容
  `cChecked` enum('Y','N') collate utf8_unicode_ci NOT NULL, -- 已處理與否
  PRIMARY KEY  (`cramID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 預設儲存引擎: InnoDB(after php5.5)

-- add dummy datas:
INSERT INTO `crams` VALUES
 ('CR001','C002','2019-02-18','客訴客訴客訴客訴客訴客訴','Y')
,('CR002','C003','2019-03-13','客訴客訴客訴客訴客訴客訴','Y')
,('CR003','C001','2019-02-22','客訴客訴客訴客訴客訴客訴','Y')
,('CR004','C002','2019-05-11','客訴客訴客訴客訴客訴客訴','N')
,('CR005','C009','2019-08-18','客訴客訴客訴客訴客訴客訴','N')
,('CR006','C002','2019-09-01','客訴客訴客訴客訴客訴客訴','N')
,('CR007','C005','2019-02-18','客訴客訴客訴客訴客訴客訴','N')
,('CR008','C003','2019-12-30','客訴客訴客訴客訴客訴客訴','Y')
,('CR009','C004','2019-12-30','客訴客訴客訴客訴客訴客訴','Y');

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
  `sMail` varchar(60) default NULL, -- 賣方信箱
  `sCountry` varchar(20) default NULL, -- 賣方國家
  PRIMARY KEY  (`sellerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 預設儲存引擎: InnoDB(after php5.5)

-- add dummy datas:
INSERT INTO `sellers` VALUES
 ('S001','星巴克','sel01ler','pwd01','my_dummy_adrs01','(99)0000-0001','s001@gmail.com','美國')
,('S002','露易莎咖啡','sel02ler','pwd02','my_dummy_adrs02','(99)0000-0002','s002@gmail.com','台灣')
,('S003','伯朗咖啡','sel03ler','pwd03','my_dummy_adrs03','(99)0000-0003','s003@gmail.com','台灣')
,('S004','上島咖啡','sel04ler','pwd04','my_dummy_adrs04','(99)0000-0004','s004@gmail.com','日本')
,('S005','小樽咖啡','sel05ler','pwd05','my_dummy_adrs05','(99)0000-0005','s005@gmail.com','日本')
,('S006','資策會咖啡','1234','1234','my_dummy_adrs06','(99)0000-0006','s006@gmail.com','台灣');

DROP TABLE IF EXISTS `infomations`;
CREATE TABLE `infomations` (
  `infoID` varchar(10) NOT NULL default '',-- Primary key:流水號
  `infoName` varchar(20) collate utf8_unicode_ci NOT NULL, -- 活動名稱
  `infoDescrip` varchar(250) NOT NULL, -- 資訊描述
  `sellerID` varchar(5) NOT NULL, -- 賣方編碼
  
  PRIMARY KEY  (`infoID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 預設儲存引擎: InnoDB(after php5.5)

-- add dummy datas:
INSERT INTO `infomations` VALUES
 ('I001','咖啡節','星巴克公司為慶祝咖啡節來臨，全館曼特寧買2送1','S001')
,('I002','新品上市','露易莎咖啡特調瑪奇朵將於3月6日準時開賣','S002')
,('I003','休館通知','為防治武漢肺炎擴散，伯朗咖啡敦南店將於4月7日至4月9日進行消毒作業暫停營業','S003')
,('I004','新品上市','上島咖啡深焙咖啡豆將於3月6日準時開賣','S004')
,('I005','講座通知','小樽咖啡將於4月7日於國家圖書館舉行咖啡產地講座','S005')
,('I006','夥伴招募','星巴克公司將於6月14日舉行人才招募，歡迎有興趣的民眾加入我們的行列','S001')
,('I007','夥伴招募','露易莎咖啡將於7月24日舉行人才招募，歡迎有興趣的民眾加入我們的行列','S002')
,('I008','夥伴招募','伯朗咖啡將於7月28日舉行人才招募，歡迎有興趣的民眾加入我們的行列','S003')
,('I009','試喝會','上島咖啡深焙咖啡豆將於6月5日舉行試喝會','S004')
,('I010','講座舉辦','小樽咖啡將於8月8日於國家圖書館舉行咖啡產地講座','S005')
,('I011','試喝會','為獎勵學員辛勞學習，資策會咖啡將5月5日舉行試喝會','S006')

,('I012','新品上市','星巴克公司冰滴咖啡將於3月6日準時開賣','S001')
,('I013','休館通知','為防治武漢肺炎擴散，露易莎敦北店將於3月1日至3月3日進行消毒作業暫停營業','S003')
,('I014','新品上市','伯朗咖啡深焙咖啡豆將於3月6日準時開賣','S003')
,('I015','講座通知','星巴克公司將於6月7日於國家圖書館舉行咖啡產地講座','S001')
,('I016','儲備幹部招募','星巴克公司將於6月14日舉行幹部招募，歡迎管理人才加入本公司','S001')
,('I017','儲備幹部招募','露易莎咖啡將於6月24日舉行幹部招募，歡迎管理人才加入本公司','S002')
,('I018','儲備幹部招募','上島咖啡將於7月24日舉行幹部招募，歡迎管理人才加入本公司','S004')
,('I019','試喝會','伯朗咖啡深焙咖啡豆將於6月5日舉行試喝會','S003')
,('I020','講座舉辦','上島咖啡將於9月8日於國家圖書館舉行咖啡產地講座','S004')
,('I021','講座舉辦','資策會咖啡將於6月8日於國家圖書館舉行咖啡產地講座','S006');


DROP TABLE IF EXISTS `discounts`;
CREATE TABLE `discounts` (
  `disID` varchar(10) NOT NULL default '',-- Primary key:流水號
  `disName` varchar(20) collate utf8_unicode_ci NOT NULL, -- 折扣名稱
  `disDescrip` varchar(250) NOT NULL, -- 折扣描述
  `sellerID` varchar(5) NOT NULL, -- 賣方編碼
  `Discount` float NOT NULL, -- 折扣
  
  
  PRIMARY KEY  (`disID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 預設儲存引擎: InnoDB(after php5.5)

-- add dummy datas:
INSERT INTO `discounts` VALUES
 ('D001','曼特寧優惠','星巴克公司現時曼特寧咖啡75折','S001','0.75')
,('D002','曼特寧優惠','露易莎咖啡4月3日起曼特寧咖啡75折','S002','0.75')
,('D003','拿鐵優惠','伯朗咖啡現時拿鐵咖啡85折','S003','0.85')
,('D004','瑪奇朵優惠','上島咖啡6月6日起瑪奇朵咖啡85折','S004','0.85')
,('D005','瑪奇朵優惠','小樽咖啡現時瑪奇朵咖啡85折','S005','0.85')
,('D006','瑪奇朵優惠','露易莎咖啡4月3日起瑪奇朵咖啡75折','S002','0.75')
,('D007','瑪奇朵優惠','伯朗咖啡現時瑪奇朵咖啡85折','S003','0.85')
,('D008','拿鐵優惠','上島咖啡6月6日起拿鐵咖啡85折','S004','0.85')
,('D009','拿鐵優惠','小樽咖啡現時拿鐵咖啡85折','S005','0.85')
,('D010','曼特寧優惠','露易莎咖啡4月3日起曼特寧咖啡75折','S002','0.75')
,('D011','曼特寧優惠','伯朗咖啡現時曼特寧咖啡85折','S003','0.85')
,('D012','冰滴咖啡優惠','上島咖啡6月6日起冰滴咖啡85折','S004','0.85')
,('D013','冰滴咖啡優惠','小樽咖啡現時冰滴咖啡85折','S005','0.85')
,('D014','冰滴咖啡優惠','上島咖啡6月6日起冰滴咖啡85折','S004','0.85')
,('D015','冰摩卡優惠','小樽咖啡現時冰摩卡咖啡85折','S005','0.85')
,('D016','冰摩卡優惠','露易莎咖啡4月3日起冰摩卡咖啡75折','S002','0.75')
,('D017','冰摩卡優惠','伯朗咖啡現時冰摩卡咖啡85折','S003','0.85')
,('D018','利比瑞卡優惠','上島咖啡6月6日起利比瑞卡咖啡85折','S004','0.85')
,('D019','利比瑞卡優惠','小樽咖啡現時利比瑞卡咖啡85折','S005','0.85')
,('D020','利比瑞卡優惠','資策會咖啡現時利比瑞卡咖啡85折','S006','0.85');

-- table訂單: orders
-- 刪除已存在之重複table
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `OrderID` varchar(5) NOT NULL default '',-- Primary key:流水號
  `CustomerID` varchar(5) NOT NULL default '',-- Primary key:流水號(買家)
  `OrderDate` date default NULL, -- 下單日期:
  `ShippedDate` date default NULL, -- 運送日期:
  `ShipAddress` varchar(20), -- 運送地址:
  `ShipRegion` varchar(5), -- 運送區域:
  `ShipPostCode` varchar(10), -- 運送郵遞區號:
  `ShipCity` varchar(20), -- 運送城市:
  `ShipCountry` varchar(20), -- 運送國家:
  
  PRIMARY KEY  (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 預設儲存引擎: InnoDB(after php5.5)

-- add dummy datas:
INSERT INTO `orders` VALUES
 ('R001','C001','2019-02-18', '2019-02-20', 'A Street', 'Region A', '10455', 'A city', 'A country')
,('R002','C001','2019-01-18', '2019-02-20', 'B Street', 'Region B', '10400', 'B city', 'B country')
;

-- table訂單詳細: orders_detail
-- 刪除已存在之重複table
DROP TABLE IF EXISTS `orders_detail`;
CREATE TABLE `orders_detail` (
  `orderID` varchar(5) NOT NULL default '',-- Primary key:流水號(訂單)
  `productID` int(10) NOT NULL,-- Primary key:流水號(商品)
  `Quantity` smallint(6) NOT NULL default '0',-- 數量
  `Discount` float NOT NULL default '0'-- 折扣
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 預設儲存引擎: InnoDB(after php5.5)

-- add dummy datas:
INSERT INTO `orders_detail` VALUES
 ('R001','164413',2,0.75)
,('R002','164413',3,0.75)
,('R003','164414',2,0.85)
,('R004','164414',5,0.95)
;

-- table商品: products
-- 刪除已存在之重複table
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `productID` int(10) ZEROFILL AUTO_INCREMENT  PRIMARY KEY, -- Primary key:流水號(商品)
  `ProductName` varchar(40) NOT NULL,-- 商品名
  `sellerID` varchar(5) NOT NULL,-- Primary key:流水號(賣方)
  `CategoryID` int(10) NOT NULL,
  `UnitPrice` int(10) NOT NULL, -- 單價
  `UnitsInStock` int(6), -- 庫存數量
  `add_time` DATETIME,
  `specification` MEDIUMTEXT,
  `description` MEDIUMTEXT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `products` AUTO_INCREMENT=164413;
CREATE INDEX idx_sellerID ON `products` (`sellerID`);


INSERT INTO `coffee`.`products` (`ProductName`, `sellerID`, `CategoryID`, `UnitPrice`, `UnitsInStock`, `add_time`, `specification`, `description`) VALUES 
('好貨01', 'S001', 1, 20, 10, '2020-02-28', 'GOOD', 'GOOD'),
('好貨02', 'S002', 2, 23, 12, '2020-02-28', 'GOOD', 'GOOD'),
('好貨03', 'S003', 3, 20, 3, '2020-02-28', 'GOOD', 'GOOD'),
('好貨04', 'S004', 4, 22, 15, '2020-02-28', 'GOOD', 'GOOD'),
('好貨05', 'S005', 5, 21, 4, '2020-02-28', 'GOOD', 'GOOD');


CREATE TABLE `category` (
  `categoryID` int(5)  AUTO_INCREMENT  PRIMARY KEY, -- Primary key:流水號(商品)
  `categoryName` varchar(40) NOT NULL,-- 名
  `category description` MEDIUMTEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO coffee.category (categoryName, `category description`) VALUES 
('咖啡豆', 'GOOD'),-- 1
('即溶咖啡', 'GOOD'),-- 2
('咖啡膠囊', 'GOOD'),-- 3
('濾掛包', 'GOOD'),-- 4
('濾紙', 'GOOD'),-- 5
('烘培機', 'GOOD'),-- 6
('磨豆機', 'GOOD'),-- 7
('咖啡機', 'GOOD');-- 8

CREATE TABLE coffee.products_tagMap (
  tagmapID int(10)  AUTO_INCREMENT  PRIMARY KEY, -- Primary key:流水號
  productID int(10) ZEROFILL NOT NULL,
  tagID int(5)  NOT NULL, 
  CONSTRAINT tag UNIQUE (productID,tagID)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

INSERT INTO coffee.products_tagMap (productID, tagID) VALUES 
(0000164414, 1),(0000164415, 2),(0000164416, 1),(0000164413,3);

CREATE TABLE coffee.products_tags (
  tagID int(5)  AUTO_INCREMENT  PRIMARY KEY, -- Primary key:流水號
  tagName varchar(10) NOT NULL UNIQUE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

INSERT INTO coffee.products_tags (tagName) VALUES 
("低因咖啡"),("半脫因咖啡"),("現磨咖啡"),("黑咖啡"),("速溶咖啡"),("手沖咖啡"),("冷萃咖啡"),("冰滴咖啡"),("法式滴濾咖啡"),("掛耳包"),
("招牌咖啡"),("拿鐵咖啡"),("卡布奇諾"),("美式咖啡"),("摩卡咖啡"),("瑪奇朵"),("焦糖瑪奇朵"),("可塔朵"),("醇藝白/馥芮白/平白咖啡"),
("歐蕾咖啡"),("半拿鐵/布雷衛咖啡"),("阿芙佳朵"),("密斯朵咖啡"),("濃縮康寶藍"),("濃縮咖啡瑪奇朵"),("意式濃縮"),("澳式咖啡"),("冰薄荷咖啡"),
("果味卡布奇諾"),("薰衣草卡布奇諾"),("香草卡布奇諾"),("菠蘿冰美式"),("芒果冰美式咖啡"),("蜜桃冰美式咖啡"),("香蕉冰美式"),("冰摩卡"),
("冰水果咖啡"),("法國香草咖啡"),("漂浮冰咖啡"),("巧克力冰咖啡"),("玫瑰夫人咖啡"),("墨西哥冰咖啡"),("瑞士冰咖啡"),("皇家咖啡"),("君度咖啡"),
("愛爾咖啡"),("薑汁咖啡"),("貴婦人咖啡"),("椰香咖啡"),("星冰樂"),("氣致冷萃"),("冰檸耶加"),("泰舒茶"),("抹茶拿鐵"),("伯爵紅茶"),
("冰搖檸檬茶"),("經典熱巧克力"),("超大杯"),("大杯"),("中杯"),("小杯"),("全脂牛奶"),("低脂牛奶"),("脫脂牛奶"),("豆奶"),("半牛奶半奶油/奶"),
("蛋奶"),("有機牛奶"),("椰奶"),("杏仁奶"),("糖漿香草"),("無糖香草"),("巧克力"),("焦糖"),("太妃堅果糖漿"),("杏仁"),("榛果"),("無糖榛果"),
("覆盆子"),("薄荷"),("肉桂"),("香草精"),("巧克力粉"),("鮮奶油"),("阿拉比卡"),("羅布斯塔"),("利比瑞卡"),("波旁"),("卡杜拉"),
("帝比卡"),("蒙多諾沃"),("卡圖文"),("馬拉戈日皮"),("瑰夏"),("怕卡斯"),("薇拉·薩爾奇"),("帕卡馬拉"),("肯特"),("咖啡帶"),("巴西"),("哥倫比亞"),
("哥斯大黎加"),("衣索比亞"),("瓜地馬拉"),("印度尼西亞"),("肯亞"),("巴拿馬"),("坦尚尼亞"),("雲南"),("葉門"),("咖啡豆單品"),("綜合"),("爪哇"),
("耶加雪菲"),("肯亞特極"),("曼特寧"),("曼巴咖啡"),("碳燒咖啡"),("巴西咖啡"),("哥倫比亞咖啡"),("夏威夷可娜咖啡"),
("藍山咖啡"),("極品藍山咖啡"),("貓屎咖啡"),("精品咖啡"),("商品咖啡"),("咖啡樹"),("咖啡櫻桃"),("咖啡生豆"),("脫皮"),("摘果"),("發酵"),
("瑕疵豆"),("銀皮"),("咖啡豆"),("蜜處理法"),("日曬處理法"),("水處理法"),("季風處理法"),("去果皮日曬處理法"),("批次"),("咖啡器具摩卡壺"),
("法壓壺"),("愛樂壓"),("蛋糕杯"),("滴濾杯"),("美式濾泡壺"),("虹吸式咖啡壺"),("越南壺"),("比利時皇家咖啡壺/平衡式塞風壺"),("土耳其咖啡壺"),
("美式滴漏咖啡壺"),("那不勒斯壺"),("咖啡細口壺"),("咖啡機"),("咖啡壺"),("咖啡機（壺）"),("咖啡磨豆機"),("濾紙"),("粉層膨脹"),("水粉比例"),
("沖煮時間"),("克麗瑪/咖啡油脂"),("杯測"),("品嘗"),("咖啡機意式咖啡機"),("半自動機型"),("自動機型"),("營業商用機型"),("消費者機型"),
("氣壓"),("鍋爐"),("沖煮頭"),("壓粉錘"),("填壓"),("沖煮把手"),("粉碗"),("蒸汽管"),("噴嘴"),("控制面板"),("拉花缸"),("打奶"),("咖啡拉花"),
("蒸奶"),("奶泡"),("咖啡因"),("咖啡渣"),("咖啡粉餅"),("研磨"),("萃取"),("沖煮"),("咖啡濃度"),("磨盤式/鋸齒式磨豆機"),
("刀盤/刀片式磨豆機"),("粗研磨"),("烘焙工坊"),("烘焙師"),("咖啡師"),("咖啡烘焙機"),("鼓式/滾筒式烘焙機"),("浮風床式烘焙機"),("切線式烘焙機"),
("球式離心力烘焙機"),("烘焙咖啡豆/熟豆"),("極淺烘焙"),("肉桂色烘焙"),("中度烘焙"),("中高度烘焙"),("都市烘焙"),("深都市烘焙"),("法式烘焙"),
("意式烘焙"),("重焙"),("深焙"),("咖啡風味描述平順"),("深度"),("風味"),("醇度"),("酸度"),("苦味"),("甘度"),("香氣"),("乾淨"),("平衡"),
("清淡"),("鹹味"),("泥土的芳香"),("獨特性"),("芳醇"),("溫和的"),("柔潤的"),("香辛"),("發酸"),("濃郁的"),("狂野的"),("葡萄酒味兒"),("黃油味"),
("乳脂狀"),("厚重"),("輕"),("稠"),("薄"),("水味");


-- PRESETS.
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;