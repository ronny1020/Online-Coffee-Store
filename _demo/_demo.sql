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
  `cEmail` varchar(20) NOT NULL unique, -- 買家電郵
  `cPassword` varchar(100) NOT NULL unique, -- 買家密碼: 加密後可能加長故取60
  `cSex` enum('F','M') collate utf8_unicode_ci NOT NULL, -- 買家性別
  `cBirthDate` date default NULL, -- 買家生日
  `cAddress` varchar(60) default NULL, -- 買家地址
  `cMobile` varchar(24) default NULL, -- 買家手機
  PRIMARY KEY  (`customerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 預設儲存引擎: InnoDB(after php5.5)

-- add dummy datas:
INSERT INTO `customers` VALUES
('C001', '吳16', 'Q3E7T2bDDK', 'H6CuyhBaGi@gmail.com', '$2y$10$7U5o6grWP0hfhhyyZrEPCu7wcDp78DNYU3lahDuOCGzfCxHw2F/Se', 'F', '1997-11-23', 'my_dummy_adrs86', '0900-005-007'),
('C002', '周11', 'cttYDSZvag', 'qlA3yunucJ@gmail.com', '$2y$10$NexiWuecoXOe7zICkDmCmO2BqD5yaFRc/q/oTh26.LjD3Od51u2Du', 'M', '1997-05-25', 'my_dummy_adrs29', '0900-006-007'),
('C003', '鄭87', 'Rz4NPZ12Fy', '7DSZRiEXLW@gmail.com', '$2y$10$9bVoVTajHzrzIaVqAM3vnO9G7KqvM8MvB3OYuzXrIFcphbV4b7TEO', 'M', '1997-01-14', 'my_dummy_adrs59', '0900-001-007'),
('C004', '李25', '0k02bIwQ1q', '7iaXLktydy@gmail.com', '$2y$10$DP2TXGpr3uUy6rVbevMNZOkH6aWU4zAAdbJ.ua9w/tRdLyb7l9Cve', 'M', '1997-05-01', 'my_dummy_adrs40', '0900-007-001'),
('C005', '高95', '5iNNFeLgzF', 'AA5oR16tJb@gmail.com', '$2y$10$Id0wzzDtyBXWDM6F6NDcg./mG7zLloPB1L62v8txFf3CvNHRCZabW', 'M', '1997-06-09', 'my_dummy_adrs5', '0900-009-004'),
('C006', '馬46', '5pZmd8bNEO', 'y3i64KOMc5@gmail.com', '$2y$10$CYv9hcGmWdVPC7D.guuT8uRdVcTouqGneVShPX2OVBTdWifSLZ4uy', 'M', '1997-10-02', 'my_dummy_adrs89', '0900-006-003'),
('C007', '徐14', 'IqgMOvWoe8', '7kTiuNblgz@gmail.com', '$2y$10$Q/dYBDtasQkgu8i7.21cye5vUGqc.d0ZJOE3BC3EjGVgazuZCUgwO', 'F', '1997-04-16', 'my_dummy_adrs90', '0900-001-007'),
('C008', '王11', 'phLBeWdVCp', 'Lg1CIyTQo7@gmail.com', '$2y$10$UlYwB0f7bnwpQogrmBIL1.FydkOG5U2DWcL5PYui1fVf00ywWPMfy', 'F', '1997-08-19', 'my_dummy_adrs3', '0900-003-005'),
('C009', '楊17', 'uzM5WOXHDe', '44s6h2gKk0@gmail.com', '$2y$10$qQdt18kIj.9jYwOo9Un0Du2mOPj0OhGQeKWks8bIzh1TdwJD3gjgq', 'M', '1997-11-26', 'my_dummy_adrs40', '0900-004-004'),
('C010', '鄭62', 'UiHE8ByPop', 'FKfclAV5La@gmail.com', '$2y$10$lWv.OAo7vMo9w7pqKu/V3eUJIpo7Tvxw7toP/POZFYUI4rcbakeZq', 'F', '1997-10-31', 'my_dummy_adrs38', '0900-008-006'),
('C011', '梁86', 'WMSaVDT6wv', '3cDguryOhZ@gmail.com', '$2y$10$ulQygj.ftsx6h.qU/mbZbefjJGwI2FGzkMNlBkA4VG9X0Xahz6DJm', 'M', '1997-11-15', 'my_dummy_adrs46', '0900-001-009'),
('C012', '郭93', 'B9um1wXh69', 'GEqCnsrXaK@gmail.com', '$2y$10$NoG1CzjnEL0RZJhYgD8vLO.uUZpYMsvbxVZeHv4rV6BbsCWG79ea2', 'F', '1997-12-16', 'my_dummy_adrs26', '0900-001-007'),
('C013', '朱85', 'RasySsYPyS', '0N1ut9H7i2@gmail.com', '$2y$10$Ras0eRfCw6lr0GD1ntXsCeodxg6CBa7aKM8RxiQ3m5CmVe6T24fVK', 'F', '1997-03-17', 'my_dummy_adrs88', '0900-001-006'),
('C014', '張39', '0llRdPeC2n', '7KMRgWb6Tu@gmail.com', '$2y$10$oIP0rFNUW26MQfWD/UtxFuXWM15fohzmY1zyH02KJJjVicaQ0j8T2', 'M', '1997-10-30', 'my_dummy_adrs36', '0900-009-004'),
('C015', '胡63', 'kf6k4fAXpg', 'm3YTH9giuk@gmail.com', '$2y$10$UwuGCS/D0XlL46RtyJIKXeZQx1LmXeM395okR.7Lc4YMK1oVyCMLS', 'M', '1997-11-10', 'my_dummy_adrs25', '0900-001-002'),
('C016', '李49', 'G7DY1whZMg', 'uqGyZAbiGm@gmail.com', '$2y$10$1Tz6TwlCJVx3817Ub16py.VJmmQ8OEHieLJB9kzoFsdJ0Qkj3BKZ2', 'F', '1997-03-29', 'my_dummy_adrs28', '0900-002-003'),
('C017', '趙75', 'nQ71fYK7lg', 'r83ROZDRuW@gmail.com', '$2y$10$de.rWIqnosInb/ZgTEMX9.NtEP3qdUMcaE6x7WQC3jAa7TBUINwwW', 'F', '1997-05-09', 'my_dummy_adrs26', '0900-002-009'),
('C018', '梁62', '9oYdOTMFuO', 'gjjUz8H8Ir@gmail.com', '$2y$10$9raxu1U.RyhFo7dNZ2zCVuPAEr1E29NkhIXeVEx1pINqp.p.Ze302', 'F', '1997-06-20', 'my_dummy_adrs78', '0900-002-008'),
('C019', '孫62', 'GAPY6r16dc', 'gPJPgwqHXc@gmail.com', '$2y$10$U1X.1M4IDmX6YPZVr.NoIOhRRCMd4HWni2.Z17NrR1ZKCRB2WtNsC', 'F', '1997-07-27', 'my_dummy_adrs9', '0900-003-009'),
('C020', '楊34', 'Wt3Vou4KMH', '4LNMmTqxRx@gmail.com', '$2y$10$OQh71UeZfACOu.APie2ji.KHhE3qUexqNwpRvLcrGrOoLIw/k9az.', 'F', '1997-12-03', 'my_dummy_adrs73', '0900-003-004'),
('C021', '胡82', 'DuQmugmHuy', '4XsjRCatAW@gmail.com', '$2y$10$v3EdbUQBDO0/38olwybSLO5TP8MwysuSjAcOFG4uX8AHZubdMFybm', 'M', '1997-10-01', 'my_dummy_adrs42', '0900-006-002'),
('C022', '周62', 'ZnO3m9xa4i', 'gmmhNoQIhB@gmail.com', '$2y$10$6K1FMoAyfE7R.hgooA23ZegiSb4ykjKvayg5G/V5.ogGbEtaLvKNu', 'M', '1997-10-16', 'my_dummy_adrs52', '0900-003-007'),
('C023', '馬29', 'j3KpBsTMvN', 'S7XsqvcrB3@gmail.com', '$2y$10$HdypfVFnIVIuVep3qPkrgOmMXLLmTTIFzdF8POPIYCJXwfsSfrP2.', 'F', '1997-06-19', 'my_dummy_adrs91', '0900-002-002'),
('C024', '徐22', 'jq4iAZH9N4', 'v4AJrb9jIS@gmail.com', '$2y$10$I9jlvKK897liuzMQxOGtaOsCLFbOjlvuqpp0x4.Y/ZLHn6EawtUJK', 'M', '1997-01-11', 'my_dummy_adrs30', '0900-008-008'),
('C025', '梁25', 'bGYHL6BtYh', 'XniEaQHdJt@gmail.com', '$2y$10$Sv.eQqK5Tshi0Ah8wemCNu3Fn3ibkX8QarBiGM6bSCnjn1Q1CP96O', 'M', '1997-05-30', 'my_dummy_adrs59', '0900-002-001'),
('C026', '高65', 'gaZtuM6Cfw', 'cXiB7XjIOI@gmail.com', '$2y$10$p7uMRvuBIC6olymvDSRGo.4xgJdzI9CWX54SpgSQsvt32RQ1NDwla', 'M', '1997-08-28', 'my_dummy_adrs38', '0900-009-002'),
('C027', '林37', '8F6xKn1fbk', 'bgdRSm9PC7@gmail.com', '$2y$10$FtCc/mEcacCBDsUfChJLrOnBKGwQnTgbrVa6p631ZS3MT1r2nwjXi', 'M', '1997-06-28', 'my_dummy_adrs85', '0900-004-003'),
('C028', '胡15', 'qx4ot38nnO', 'ELVDtDVTai@gmail.com', '$2y$10$Ig8hKYXjyeTtAnFssjeC7O86PJUJo6anVpo7xpBv9zCEbR8K3deOK', 'F', '1997-08-21', 'my_dummy_adrs49', '0900-001-002'),
('C029', '謝71', 'FSKIPk9oci', 'g5Bf21NFLG@gmail.com', '$2y$10$wd3KiSdezVbZ48sXo36gcOOYgN6PSG9abvs3f3BuiyeLVDIrU91mK', 'F', '1997-08-30', 'my_dummy_adrs18', '0900-008-002'),
('C030', '楊45', 'IasiJlBt9t', 'e4BTYGv9oh@gmail.com', '$2y$10$cy//fy40N8o4vcVJEGsMD.8sFIzMPI/U21wBxxwueXD9CCh97RL1y', 'F', '1997-02-20', 'my_dummy_adrs73', '0900-009-005'),
('C031', '周77', '0TXdag2kFQ', 'qSE2igRRFV@gmail.com', '$2y$10$9zp0sy.HsUJPCSKdtprFn.eBZuKfb4ty8qc15Aw6itBF6r2luDoWS', 'M', '1997-01-19', 'my_dummy_adrs28', '0900-003-005'),
('C032', '趙99', 'LXOHe6hnzd', 'TfK6P8jzBk@gmail.com', '$2y$10$O89IiXvh1.NS79NPtwwgheKolFFPCw2yVVVdpGU9fnhWChqOIpx1W', 'M', '1997-03-12', 'my_dummy_adrs80', '0900-006-001'),
('C033', '朱58', 'oXTYs1cHAc', 'MLbOwdiAOq@gmail.com', '$2y$10$5W1edJ.COehtNMRvJYVXMOTym5eIV4HYntjyZ6vtGuwd4AQ9jyVhu', 'F', '1997-12-10', 'my_dummy_adrs71', '0900-004-009'),
('C034', '梁43', 'A2dLy9cVZy', 'bhIZfu2BhO@gmail.com', '$2y$10$4LYx9VdcugCZp0HaA1ewEu24mnlz0nTU.f.RbZ7vZaQ0Uma1/IjtO', 'M', '1997-09-06', 'my_dummy_adrs59', '0900-001-008'),
('C035', '趙55', 'pGKRfPp53B', 'Hx4wkXFnO9@gmail.com', '$2y$10$PeS2V99/Y.ZCh8kSwa.jzeAg.ZDdtFnk01ilWtRn8zIBrb3ORrgAW', 'M', '1997-12-13', 'my_dummy_adrs18', '0900-008-001'),
('C036', '楊78', 'anvIONxvsE', '17YQCB05re@gmail.com', '$2y$10$FkNqF8eZwh80ubL5NGo4meoEPFMFLFsUXNKPLncj6jC19d.LjkXBy', 'M', '1997-01-17', 'my_dummy_adrs28', '0900-006-004'),
('C037', '胡45', 'ecihdkk6j3', 'kz6LOZwuaJ@gmail.com', '$2y$10$y39VTmnZKzOtlbd0StppDeRTUCIEBtEodQZBm4qDQ1eRYmFAUinzm', 'F', '1997-02-16', 'my_dummy_adrs59', '0900-009-004'),
('C038', '胡18', 'wC2sF7RkZ3', '2sgqzAXR4x@gmail.com', '$2y$10$Ko8vLokDIsYM2uTRFZanEuNfFYoVTau0kBpSxP/Bp/Nozd3/Q32da', 'F', '1997-07-24', 'my_dummy_adrs70', '0900-009-002'),
('C039', '林47', 'yFyGRD1pyC', 'zvK4gueAl8@gmail.com', '$2y$10$scGjyPXnrdizP8q8Yj3oNezUaonfWYX5NkjziBOZVxurW05T1.5aW', 'M', '1997-12-11', 'my_dummy_adrs74', '0900-007-004'),
('C040', '劉58', 'XrixIxM6HN', 'Biiog6xJGa@gmail.com', '$2y$10$DMDf.VVa8Dz0AlhT.IWaI.gP2OiS.Zr1YIAcUIve4aiVE3QszTQsS', 'M', '1997-05-14', 'my_dummy_adrs92', '0900-001-003'),
('C041', '張84', 'xq4gZYBPth', 'Vv8E1NSOCY@gmail.com', '$2y$10$gh604zCGGv.1okl7wpdwK.J9Q/hW.XMxqBr.4VVgO2fs68DPImnVG', 'M', '1997-12-13', 'my_dummy_adrs19', '0900-001-006'),
('C042', '鄭69', 'RAzdZEUdEv', 'ok1oihuyvm@gmail.com', '$2y$10$6NvbWt0jJGPyS5aIWKq1ke4pKzedfMZRuiIYSo9fZjDu.p53Ua9Vy', 'F', '1997-10-23', 'my_dummy_adrs37', '0900-006-003'),
('C043', '胡11', 'vkkg3rXnyR', 'di2267QpXn@gmail.com', '$2y$10$Zzh.Z27hY4LxFPZmndt53eNNC8nfyJrOCIMo300CZdQwJLv5dRhJq', 'F', '1997-04-01', 'my_dummy_adrs2', '0900-009-005'),
('C044', '高13', 'yB0VODx9LW', 'Ocvs8ixxWo@gmail.com', '$2y$10$vQ63RxZn8Pcv0zFgE7DLx.//jnM5V2HjWfm8fCjq.NqTpvF8vj7Ty', 'M', '1997-12-20', 'my_dummy_adrs63', '0900-009-007'),
('C045', '劉86', 'eTCmqljRGk', 'A9OVH22pTg@gmail.com', '$2y$10$jHTNBhwzFUHWyS7gZVuNDOhmqNOxDode8EuQfbvYq2PbkrRaLWYLm', 'M', '1997-01-22', 'my_dummy_adrs43', '0900-007-005'),
('C046', '楊96', 'i8wcR83Wcs', 'mh0vOfoCEK@gmail.com', '$2y$10$aMphVj5Duala.brPgCElQeL83JmjZDl05SQaa2UFNyEFFQvKK7BqS', 'M', '1997-06-13', 'my_dummy_adrs69', '0900-008-009'),
('C047', '馬53', 'D31fPQgpdT', 'IXd1I8QjHt@gmail.com', '$2y$10$R7E5PgX/jdg1VOb65uOSO.fNiFBP//nd9APQ8QIwg7/mwcK9tdx7a', 'F', '1997-09-24', 'my_dummy_adrs70', '0900-002-003'),
('C048', '陳41', 'aXmKuYckfo', 'GI90nsMiKo@gmail.com', '$2y$10$x15gZ7MnDJRovuZrz/xD0uSGo7SF86sfQyY0xcqX6czmCB5aiXm/m', 'F', '1997-09-22', 'my_dummy_adrs37', '0900-002-009'),
('C049', '林22', 'vWj7iOhvLa', 'MURp4bi3T4@gmail.com', '$2y$10$7IQ9k8oDWchoWPibkd3ncemzVXdZbPygOPFQA4rm.yTV7rS59jk5q', 'F', '1997-03-25', 'my_dummy_adrs5', '0900-003-003'),
('C050', '陳74', 'A5RP2kCfny', 'FB8JRI8Hym@gmail.com', '$2y$10$vEXlr5XPuaBQQv/Rqb16l.Y/WTcfOmtQAr/pzzaZpvvRPdc8t1fE2', 'M', '1997-01-18', 'my_dummy_adrs98', '0900-005-001'),
('C051', '胡89', 'cKHPl8pXgs', 'DbsUtE6OcR@gmail.com', '$2y$10$NL0IB/RJY544zCzv5XY2OOmVFNwHNOUbLus.NBL2KMFXoDrDzPXj6', 'F', '0000-00-00', 'my_dummy_adrs72', '0900-001-003'),
('C052', '馬79', 'MkO7bkIZA0', 'LpL6lc8PT2@gmail.com', '$2y$10$KdHbS9Zsb./5ogVhjKLS/OZL.UjADLxjcZhatEE.BdAydNcqAPgF6', 'M', '1997-08-07', 'my_dummy_adrs64', '0900-009-002'),
('C053', '孫16', 'us1sxgAAk2', 'qRBU5bi4m2@gmail.com', '$2y$10$Ul6mcE5Hs6VJyqPidcIs1OwlSPuGl3eVVisiKMyQUuYT28qC3aPo6', 'M', '1997-09-14', 'my_dummy_adrs18', '0900-004-001'),
('C054', '何22', '2V6priR2mf', 'pUImEldaXG@gmail.com', '$2y$10$NYMuXTxiK4DOerjAZ9zMpu.lNjSlwUK3nYcogaD3cSArCN3JUlGiq', 'F', '1997-01-16', 'my_dummy_adrs76', '0900-002-002'),
('C055', '張11', 'lP9bMgF3Nu', 'm1vZJaIB7F@gmail.com', '$2y$10$ZdMeuO/lK6sBKK4lHlIkU.qXokBbRbnSzR5XL2bV5QO8PfdNvN0Pi', 'F', '1997-11-15', 'my_dummy_adrs76', '0900-009-003'),
('C056', '孫76', 'VPdH4a45js', 'h2jarqJE3U@gmail.com', '$2y$10$3Ed6nch6PA7RjgOMYAOt3e0rvyJUHQNSZjq4ELbzcIP69mBayzzFe', 'F', '1997-02-04', 'my_dummy_adrs2', '0900-009-007'),
('C057', '何44', 'zNBMwOGShI', '4Noc3cmLT5@gmail.com', '$2y$10$/35Id9NnOef2nkSx5B5H8u9uhQRfkcpkqr8Cbk.RAPAVjdHxbruvu', 'F', '1997-09-28', 'my_dummy_adrs55', '0900-009-003'),
('C058', '鄭56', 'e27CcfmnnA', '9J3sND6Jr6@gmail.com', '$2y$10$SnFe5xGewLSay4YZFZU5Z.K46J2awb048psYZ98wGcMGJsZl8pMlO', 'M', '1997-11-08', 'my_dummy_adrs94', '0900-001-009'),
('C059', '楊73', 'XJq5piwALx', 'K8bM160Jpv@gmail.com', '$2y$10$2DZfKX41yam4y/vnFJj7m.aymdZhRdtEom70qeG5X.oI/dBNDYa7W', 'M', '1997-11-15', 'my_dummy_adrs20', '0900-009-004'),
('C060', '張14', '5SpQfI0pnT', 'xu8KbsjiEw@gmail.com', '$2y$10$kk086FrqmHF7g63tJwH9sOvizj7hPoAxS3b.bh6fYqoivBMUjwBMC', 'F', '1997-06-05', 'my_dummy_adrs60', '0900-006-002'),
('C061', '徐72', 'vrIVNw3BgJ', '2JQO2sjkCs@gmail.com', '$2y$10$fJ5kUujfR8w/q1gHtkP4c..6oKgQD9OzMI1JzOFOubHmK1aP35/vG', 'F', '1997-05-09', 'my_dummy_adrs4', '0900-001-001'),
('C062', '高88', 'rFieLhKWLe', 'IW42Lo7mAJ@gmail.com', '$2y$10$LUwZDyUSEzN.12g5/WjlkOunTDaxdroZiWADvyozGELe92byV/yMi', 'M', '1997-04-05', 'my_dummy_adrs59', '0900-005-009'),
('C063', '周75', 'c3X70Ei9kA', 'o3oNh4U2fz@gmail.com', '$2y$10$hIstPcAOs0IqLaqtzBJqK.ZLgUqnQ8ndiroQIdOA3GkgiA28TB7dy', 'M', '0000-00-00', 'my_dummy_adrs56', '0900-008-008'),
('C064', '孫45', 'uJJrZxW09j', 'lpITBK4QxA@gmail.com', '$2y$10$MMInOL1bX2jJfP9klLT37ebvwoB0a838Q7eRqSX/IqJCB6xgbaAie', 'M', '1997-05-17', 'my_dummy_adrs29', '0900-006-006'),
('C065', '謝73', 'GMphFmSaM8', 'oA4Irxf8z4@gmail.com', '$2y$10$sia5TKeao2IyvRIkY3E5XO0oapxtROVJVoep01IilejgNKpdGli0y', 'M', '1997-06-15', 'my_dummy_adrs82', '0900-006-003'),
('C066', '周27', 'EA65Df2Ptn', 'x88Znl6YP5@gmail.com', '$2y$10$oReWSg0wmaMcA.YahoRP9u6dvDqr2LP5/ZvqifT2PzEkqw2fSjPai', 'F', '1997-01-14', 'my_dummy_adrs44', '0900-006-007'),
('C067', '高36', '8ondZlUGZN', 'eDKxRHZ8aL@gmail.com', '$2y$10$XN286E2HOZ6DxTbOodfK/eu//.cJa39tywpw9lRHG4wzDFTtuulhO', 'M', '1997-03-04', 'my_dummy_adrs22', '0900-009-009'),
('C068', '梁93', 'fszo8bH894', 'SQrraIOgU3@gmail.com', '$2y$10$LmrDGXzb6WYhpL3E/CF..uEdczi/N/utf0NG5My4RdShotMdG0A2S', 'M', '1997-01-02', 'my_dummy_adrs82', '0900-003-008'),
('C069', '羅32', 'OWP0ILuWh6', 'RMlHXOml1h@gmail.com', '$2y$10$X.jCIDT4v07ngBaBzp0wee9WO0LqzdIj4HJRhx99sHGqaS1c0A5wu', 'M', '1997-03-05', 'my_dummy_adrs10', '0900-006-007'),
('C070', '王12', 'gEHAzfmfi7', 'fmKjK9snvE@gmail.com', '$2y$10$89JOQhP5EXPic1rII7Ik/uyaCBD.uVNd0uCtw66mYvALaQrqQIV5O', 'M', '1997-09-16', 'my_dummy_adrs50', '0900-007-001'),
('C071', '陳53', 'bUNV6Lx32r', 'w9y27Lg2c7@gmail.com', '$2y$10$HOKysCzJQnZSMIQUa5U44OTwcwMKlFuwQdwH/J35wroCBcQO8Iy5q', 'F', '1997-05-12', 'my_dummy_adrs33', '0900-005-008'),
('C072', '劉48', 'SCyub4XNXi', 'GFcBTft9PV@gmail.com', '$2y$10$KEbPooq7Ur38HFVtY/suFenEybnNhX.utEbdeGZTWz9NX6p6a/Apq', 'F', '1997-05-14', 'my_dummy_adrs63', '0900-004-004'),
('C073', '周73', '2001PBsWGD', 'Gdi9q0W14L@gmail.com', '$2y$10$WgC3XdOl5kuyTfqlVRXL7OpndFYDoLUhYoxxBC48g5j0XZCOMnvJC', 'F', '1997-12-15', 'my_dummy_adrs47', '0900-007-001'),
('C074', '楊98', '4Vw8tJAtdn', 'bcvcAYAnXc@gmail.com', '$2y$10$2BkS4fvzUz9kx5XOrW.VIueaq9BSzERHstqybuUteeKFw9VWJPknK', 'M', '1997-12-04', 'my_dummy_adrs19', '0900-004-008'),
('C075', '胡85', 'brGRxvcFq7', 'DfTaluLbaH@gmail.com', '$2y$10$p42KbIBAq17uPWn4gv3Nt.imX0b9JbSg9C.9IUFQGeNb5lAwQv54a', 'M', '1997-08-23', 'my_dummy_adrs27', '0900-008-004'),
('C076', '馬21', 'HnZM42t1LU', 'qSqvyAdW02@gmail.com', '$2y$10$hGgDikLw/uOrOgRbFxDnU./rSB/wXpsdsOHUOMWFv8SzWXt7miK/i', 'F', '1997-02-21', 'my_dummy_adrs14', '0900-005-003'),
('C077', '林52', '8oClpMHFcx', 'Y5awV0VxrO@gmail.com', '$2y$10$3m/G5SB.d7XuQbWfVZ8ynuWmCVKdM0S2YD4HCpWw6jVV5kgdHwMU.', 'M', '1997-07-31', 'my_dummy_adrs62', '0900-004-005'),
('C078', '鄭92', 'BeI71IfprO', 'FoBNk8vpQZ@gmail.com', '$2y$10$Jg4pJRJ0yu8wAYKoKhDjIOHvVZzN/FcBiQbpju2Ur1z5mPh6SoYdW', 'F', '1997-07-11', 'my_dummy_adrs53', '0900-005-008'),
('C079', '馬71', 'Gt0tRvX0pi', '2DUd0wTDVj@gmail.com', '$2y$10$CVIwBBoa5CO83sFYVbJsi.WKsrL/UCK1CcVcj6u9mIAVc/sMUke3K', 'F', '1997-07-07', 'my_dummy_adrs88', '0900-004-009'),
('C080', '楊93', 'k7SmIjlYlR', 'eFOkvausAq@gmail.com', '$2y$10$9VbU25qa46VYRQNeeLn1EOBe6Vu60neyYwmOwiuTDoZwnctyXA2xK', 'M', '1997-04-02', 'my_dummy_adrs90', '0900-009-005'),
('C081', '何25', 'iPjZvKiHvL', 'zd32jC8ULZ@gmail.com', '$2y$10$lBbKbWQGkwWa1LPpmPHr5epPA27RX9Hbu/BoeR7rviGhKNQTFyrq2', 'F', '1997-07-23', 'my_dummy_adrs67', '0900-003-002'),
('C082', '何88', '4f8siO8Hk6', 'GS35Lsthfs@gmail.com', '$2y$10$2S99TmJY0ifkcEhyWutaZOSHLrfGQ2R3bnWjH10B/J8vIIn1i6IqK', 'F', '1997-05-11', 'my_dummy_adrs97', '0900-008-009'),
('C083', '胡67', '9rAYgtP0jh', 'VE9ia7elD7@gmail.com', '$2y$10$MPgbW2I/oh88sRYYoGyahOfpmWXHH2gs1NKpfR4.R5vM7KMq00ZXy', 'M', '1997-05-03', 'my_dummy_adrs11', '0900-001-009'),
('C084', '李83', 'puAIsEYaSn', 'iGS5u8RmIz@gmail.com', '$2y$10$6149fa23a9Dj9JLGjM3HN.j16..Lj2IY0AESXjN1y7P7FKlWeuBZi', 'M', '1997-01-18', 'my_dummy_adrs90', '0900-003-006'),
('C085', '羅13', 'd5to9IsZAk', 'YPeViWt5FH@gmail.com', '$2y$10$H7HWWKYhFu3VrGjUeFEYHu/./SUco.a3soV/lQRGTxVRgKWp1/Soq', 'F', '1997-06-21', 'my_dummy_adrs2', '0900-007-004'),
('C086', '陳95', 'rZv3sljIOf', 'Xf7eMXd09E@gmail.com', '$2y$10$wO86IlTsNA3aJRwJcMdUeei4tY6KL8k529LrIsT0Iby4kqH7P4zJu', 'F', '1997-06-01', 'my_dummy_adrs57', '0900-009-003'),
('C087', '馬91', 'ThpHlvDuiA', 'QWpKksA2Tl@gmail.com', '$2y$10$PRagRKtBBqZOAQS/UYLxaO6jlmSyPZ19zRKhbBC65LlYFRBHSx9uu', 'F', '1997-08-25', 'my_dummy_adrs35', '0900-009-001'),
('C088', '胡68', 'rxcEEFwatx', 'WYQU8byqDF@gmail.com', '$2y$10$4JR2gi3waG1vqx3J4x33o.SridxeYyBjuZZ8zEKfOvtXwSVCJyxPO', 'M', '1997-03-06', 'my_dummy_adrs47', '0900-002-004'),
('C089', '趙65', 'TxznBAgzru', '6eXtzBWPmH@gmail.com', '$2y$10$dpSAa.VPVhR0NZiXIyVR1eT1W2V9YzhrRlwTG4Ypq57JbiKEyE8Q2', 'F', '1997-05-08', 'my_dummy_adrs20', '0900-008-001'),
('C090', '孫16', 'ZDuVeWwDKe', 'FZk8ksi2hU@gmail.com', '$2y$10$M/9YYzKgO4GoinZZFFEBX.wF9AXxMp9Q7Lb2Y6e9Gx5V19RQ1S6PO', 'M', '1997-01-11', 'my_dummy_adrs57', '0900-007-003'),
('C091', '李74', 'kNEG3FWnPy', 'elTEzXWHoh@gmail.com', '$2y$10$ygte2DyWx5z.ycDm4UxTEOvWRFFL8KaryVWh8k1dfeMwYvED1j9Um', 'F', '1997-09-21', 'my_dummy_adrs20', '0900-002-001'),
('C092', '高82', 'tjLGIu0Ygo', 'OPoR2L3XBM@gmail.com', '$2y$10$qbNXq5/B4Yiu8piVdE14iuBTuMO.DsFEl37cKmr1JzP0.3lRY/2mi', 'F', '1997-12-25', 'my_dummy_adrs69', '0900-003-005'),
('C093', '吳94', 'WfzRatdx8E', 'nrHjotCsgT@gmail.com', '$2y$10$B2zPGuHTmQFVuaZ53wkmdugdKTJqowGNT3NinoI3MFmhTgcxJCKfC', 'F', '1997-05-26', 'my_dummy_adrs62', '0900-002-006'),
('C094', '朱35', '17EYgVqGaZ', 'dwu9E36GEa@gmail.com', '$2y$10$p3Li3IfPxeDdhWYweRM8A.5HiGNAcnZSwvPtqM81K8/y2b6Zup5sO', 'F', '1997-03-05', 'my_dummy_adrs79', '0900-004-007'),
('C095', '陳97', '3agjPvm6FB', '54GNS7wCsb@gmail.com', '$2y$10$WoMgBweAqOehGB8xIHit7Ouxl20od.R4RzH1oALvz.0oFGew9.D92', 'M', '1997-06-26', 'my_dummy_adrs45', '0900-001-006'),
('C096', '徐26', 'zya08I7CJQ', 'rypvF1mBT0@gmail.com', '$2y$10$pi.Ttj7WSCskQARJsMqKcO1FI7wnK86MOIXAdZxPy4PWOYRFkWcjm', 'F', '1997-11-02', 'my_dummy_adrs31', '0900-006-003'),
('C097', '周48', 'gIqCjDKIWP', 'TUaYdvoztY@gmail.com', '$2y$10$9mwQ9aZgWsxPn/iL2ctu7.kcehKSnnDvfiUKI3G30s4cTd5nEI3fC', 'F', '1997-03-14', 'my_dummy_adrs51', '0900-005-007'),
('C098', '羅79', 'f1jONMnUaG', 'P4fYnFfEle@gmail.com', '$2y$10$dl7O6v9LpyenPbh/.p8u6uEHEwW/3A1lyZTvqThMQ2qtcBMTzCZ8m', 'F', '1997-03-24', 'my_dummy_adrs51', '0900-005-004'),
('C099', '劉82', '636FcFsre2', 'G48BfzNvEk@gmail.com', '$2y$10$L9HgozWOAi5Sie4lrVYtbOgkVLLJo1329S3SxxIsztm2g0my8hdr6', 'F', '1997-07-01', 'my_dummy_adrs33', '0900-003-004'),
('C100', '羅39', 'aTN7Z36XKa', 'HxJbCeep0L@gmail.com', '$2y$10$z1wuRdvIz1XIPAVIR0iH1.TOY9nDlCHKznIAnVbFr/aDbXLxsGAXq', 'F', '1997-08-08', 'my_dummy_adrs88', '0900-004-002'),
('C101', '劉81', 'l4DajvXAjH', 'nLPiThR0vS@gmail.com', '$2y$10$inemnVM0.Nr8lXwHrRdnNOsQKtotY.iLjcbwuXP4Z3KkmIGgCKVGu', 'F', '1997-06-28', 'my_dummy_adrs65', '0900-004-009'),
('C102', '梁45', 'URszO3QALH', '8LUC6DxJG3@gmail.com', '$2y$10$gwcgZosY0hP7.00zsp9jVuZyOIlEjNpUmNbSWv91v9AyN4xpoz9Ba', 'M', '1997-04-28', 'my_dummy_adrs69', '0900-005-002'),
('C103', '徐98', 'IkGbFmHKFh', 'Gx7AuQMY7y@gmail.com', '$2y$10$3LFRfvK862TxHotQBdujhuzRhaudu/RhP/jDWtwWGC.V789Zw/Ofe', 'M', '1997-09-11', 'my_dummy_adrs92', '0900-004-007'),
('C104', '朱93', 'vWdu2WIMik', 'N8wTWdhcYc@gmail.com', '$2y$10$ciaVVSLVx7uWcWSHjjLFP.BJGAxHcv.uU8Z1ZNinkL9w51ApZgWru', 'M', '1997-10-20', 'my_dummy_adrs34', '0900-003-008'),
('C105', '馬26', 'mQ02auPjSB', 'zzHJLetYZQ@gmail.com', '$2y$10$yt8zupdSPsL6Ify1gC0m7.dny5HjGTDpqQZs8N.WnrZU6uHf5lMSy', 'F', '1997-04-29', 'my_dummy_adrs73', '0900-005-005'),
('C106', '李66', 'MV7kHl7gsu', 'F82ZXLxuJO@gmail.com', '$2y$10$HsTqagbgtRPJttDKiZhRSOg5a4Lt9sdYFeORL2eyxNg9I2h2s/JkO', 'M', '1997-09-08', 'my_dummy_adrs59', '0900-001-009'),
('C107', '林42', 'wfq25RRErV', '5B9f3q7JWV@gmail.com', '$2y$10$msFVIzC63PSkGHADPyjNCOmx4Y/lQTx0JztmjfTofJ0sWfzFcv1Qm', 'F', '1997-05-23', 'my_dummy_adrs67', '0900-008-004'),
('C108', '周59', 'BtYPu1U6d2', 'yl2xZVozsq@gmail.com', '$2y$10$EOAL9Wgr12wDVDoH1Gwwqu9Y3jtPIX.tx2B.0.TiUAttlvYe2238m', 'F', '1997-05-11', 'my_dummy_adrs52', '0900-005-004'),
('C109', '朱79', '96DrtdFV8u', '4lmUY5Qja1@gmail.com', '$2y$10$yaYJ1XT2N7270E/eMoMJge1NektYGXt1uglEvNYY27ZxhikrBhhny', 'M', '1997-05-22', 'my_dummy_adrs95', '0900-002-008'),
('C110', '鄭38', 'iZl7bg16qM', 'N8RZvKk8eJ@gmail.com', '$2y$10$WtZxCSAwhOKhnsMV1strGOuTj.bD80SowFZW2hCit8Q2vJ8NmK.DG', 'M', '1997-07-30', 'my_dummy_adrs58', '0900-006-009'),
('C111', '林53', '81caOuZJQu', 'U4hgcAm00n@gmail.com', '$2y$10$WrHA9Mb1mZADZRi6BYZ8b.xkFOlKZ9C8E2/MMnRLivMdm2e3rA8U2', 'F', '1997-11-20', 'my_dummy_adrs15', '0900-007-007'),
('C112', '周23', '3jxyQsyJfp', 'J0iRCXdMQ2@gmail.com', '$2y$10$RjrrxZCLzCKJSTKJoPjrkeflie28VqtW8JbU7jduIxEim.qpKHuwS', 'F', '1997-08-04', 'my_dummy_adrs36', '0900-007-001'),
('C113', '郭32', 'QqIsRTxijK', 'nMiSMSOZCt@gmail.com', '$2y$10$ayE9njczA2eoKnSnRveIL.ZBz.zhYg3gLci9SeW50uJW6Tb9/EpkS', 'M', '1997-08-21', 'my_dummy_adrs29', '0900-005-002'),
('C114', '朱78', 'J30ImByKoP', '5vssmZO5ph@gmail.com', '$2y$10$TfhArvwnXSK.pw2.6ioPt.hOw2ZR3BVjgdHsL9pCct6tkCtde9Drq', 'M', '1997-09-23', 'my_dummy_adrs94', '0900-001-005'),
('C115', '郭28', 'Urh9hRmv4N', 'arpOL7AXWe@gmail.com', '$2y$10$3dVjROb7WljKWjcnij5OmeP.RzOZxNMywAn6dsr.1VZGx02zt/822', 'F', '1997-05-04', 'my_dummy_adrs28', '0900-001-003'),
('C116', '周73', 'dwH9cPMs9t', '99CDb39GUg@gmail.com', '$2y$10$dcoW2ODLi6.Cpm1kNJRQVeHRH7Qejb4IOiVST1HifLUSL3Df1zt/W', 'M', '1997-04-17', 'my_dummy_adrs48', '0900-001-005'),
('C117', '劉93', 'p5awzT4r9H', 'c7fHQEAv2T@gmail.com', '$2y$10$NBX5fCR7ZZo9lYNrXhDppOBes8HboSUVoWVHNohSlqKUrPRvTs0Km', 'F', '0000-00-00', 'my_dummy_adrs95', '0900-008-002'),
('C118', '何44', 'hjnJ358QP8', 'RxF4fHz6ZT@gmail.com', '$2y$10$spvYkwxe9wltSx.AlZ6avu8vNjdx4nV16IxubQFujNcC/j1/zyhLa', 'M', '1997-03-24', 'my_dummy_adrs64', '0900-004-001'),
('C119', '何16', 'G6VWpZ9MXo', 'jNqNxwy475@gmail.com', '$2y$10$ukkpOI4CPq.seHbkZIfTR.u4D1IeKWB92dOQhXx1eUkzbvmF4zJVe', 'M', '1997-12-22', 'my_dummy_adrs71', '0900-008-001'),
('C120', '周31', 'DeDvI607YV', 'oSPEtPVlNT@gmail.com', '$2y$10$W6AsenXU0d47m9QYueihcuAphbOUfJky4pzWWat.tZZVQZAwBgw6.', 'F', '1997-07-08', 'my_dummy_adrs30', '0900-007-008'),
('C121', '孫77', 'J5J2wwRFMt', '4fcp2vLbGG@gmail.com', '$2y$10$YbDx8NnXDe0Cin2tVDkBiuKHFRWUOSmCHYFasxig0da.4.rzw2qD6', 'F', '0000-00-00', 'my_dummy_adrs34', '0900-008-004'),
('C122', '胡76', '9NeISxtmRZ', '7Ia8CiKYuC@gmail.com', '$2y$10$aTaT1Uwk8XlH0YcxzfrTPO/TOSIS6lobQgBJIJyAsE83zSim4otfS', 'F', '1997-10-03', 'my_dummy_adrs36', '0900-003-005'),
('C123', '周32', 'UU6hWZ9xYS', 'ftgdmhw6mD@gmail.com', '$2y$10$5PEUGzYUem1eLfyxHaXIt.AAji1FQaq/BhhBItHyBQfAwucw7ZoQa', 'F', '1997-12-09', 'my_dummy_adrs6', '0900-005-003'),
('C124', '楊86', 'aC6OXH1tou', '3Yxe9eDfRO@gmail.com', '$2y$10$2voTYLPxbcKPsALqP9DZ7.EYq1.tyIKUM5uDMrGg18neLG9A.Iljq', 'F', '1997-12-06', 'my_dummy_adrs61', '0900-006-004'),
('C125', '楊72', '0Ng5G6vbUo', 'zSrWxgUoEH@gmail.com', '$2y$10$5FZYb5Jg8U9J2s4n/yZ1ceYily81vhiwOzYT09Sx3LuPQFMTeBpvq', 'F', '1997-03-17', 'my_dummy_adrs81', '0900-009-007'),
('C126', '鄭91', 'cKT172IOTN', 'd3wxUbpxhw@gmail.com', '$2y$10$F.9LG4NOswT.VNT8K1gi8OYRE6HEinWLTBI7hxcG3k30M.udBk56W', 'M', '1997-03-08', 'my_dummy_adrs94', '0900-004-009'),
('C127', '張16', 'huwLICftqM', 'Mq09ww5IDs@gmail.com', '$2y$10$uReRy937aepuWqJ/nOo.leKG5lbJReApJYmFVlwefRF0.0Cp59vjO', 'M', '1997-09-23', 'my_dummy_adrs51', '0900-007-009'),
('C128', '羅12', 'CpgVc0DVrU', '8QBkLvfPaw@gmail.com', '$2y$10$xFeD.3xDass9bvVinQkYoOmf4uY7W2Qy6OkJknvFxS/1c9rTOJLUi', 'M', '1997-07-31', 'my_dummy_adrs70', '0900-008-005'),
('C129', '楊31', 'dCoybnAmWz', 'IcfueIRJfD@gmail.com', '$2y$10$FMn9.F95ApHt72sI7UJ9B.0I.0MDGa8E8g3LRtkyayCozCPs1qTm.', 'M', '1997-10-15', 'my_dummy_adrs95', '0900-008-003'),
('C130', '高39', 'xCc0cqUKjy', 'WCamFMc3QX@gmail.com', '$2y$10$QZXhHPiFz8E5Hmnjf.zraeTEzGLKSTAfqX.X3cFoh7V3aDM/3P3s6', 'F', '1997-01-06', 'my_dummy_adrs73', '0900-008-007'),
('C131', '朱99', 'dSFHYTT8dn', 'QFL8qjWgKJ@gmail.com', '$2y$10$6fsZvGRrn92hIxwTwrmB3u6mhFBnFydzLysKOh0Tem6MUOrIjX/8i', 'F', '1997-10-19', 'my_dummy_adrs91', '0900-005-004'),
('C132', '吳73', 'd0UzwRjuIj', 'pfgv0jb95e@gmail.com', '$2y$10$GG12lujFZlsEIyS2k69aD.uz9vpOY4H34yxbnFQyGd4YQBcKMTtYy', 'M', '1997-08-24', 'my_dummy_adrs71', '0900-008-009'),
('C133', '朱45', 'FFWhyHnuqD', 'wU18wHjDM8@gmail.com', '$2y$10$3VhScZRGp.pEHlW0gw2dxeoHTydvPZGbPY1emTDt6kFad740y5AJe', 'M', '1997-07-17', 'my_dummy_adrs20', '0900-003-006'),
('C134', '梁95', 'Ry2Q02VLQ9', 'gUfCo96I8i@gmail.com', '$2y$10$pxYopyJQNbV5MXLlzt677.qVdKmxO.ik57A0TA4QEXjG5/UgAgF1y', 'M', '1997-06-26', 'my_dummy_adrs38', '0900-006-009'),
('C135', '謝58', 'zsKjW0kHMy', 'BVuEqztntO@gmail.com', '$2y$10$7v/Xc6dQkfWpgTMMKEQAkufDzsk81xDyWmbkddtnj8Q8znV5T31s2', 'F', '1997-04-15', 'my_dummy_adrs54', '0900-004-001'),
('C136', '何92', 'YsQjuRYkIy', 'y3JIyhrG7Z@gmail.com', '$2y$10$hkhzxbXDUP1wQAw3Ph3IW.wK58d/zSXwHGsx/6a8R0FABuQ4gQH2q', 'F', '1997-08-12', 'my_dummy_adrs15', '0900-006-007'),
('C137', '張85', 'ZgLwWJP9Av', 'asdICFl1TX@gmail.com', '$2y$10$ZGyx73lDc7qR2gPs7r5dKOMb.8osy60XQ5/pcpsVsmNiIDvIt524.', 'M', '1997-10-22', 'my_dummy_adrs21', '0900-003-007'),
('C138', '吳16', 'veGbtUfobd', '6fK0ZfP8n2@gmail.com', '$2y$10$rGef5nVfLqosQ/u7ja4CUuf8mKHrwOz9/shdHwHWusXR9TpzDeiki', 'F', '1997-10-20', 'my_dummy_adrs82', '0900-009-005'),
('C139', '周57', 'N4LdumCR2u', 'nClSp8sUVH@gmail.com', '$2y$10$/0G.yXP0/YbZzHtS54ccB.WkY2nEMoLlx3loXNnCvwAiblkX0xMyW', 'M', '1997-09-10', 'my_dummy_adrs15', '0900-007-006'),
('C140', '胡82', 'NqZ8Le3X12', '9wZoMlgkCz@gmail.com', '$2y$10$qHQt3tlqYfIeWkbpLGgxiu14GC.KcNf/Xu3CEkfUzLOM6uY0fQUHO', 'M', '1997-07-09', 'my_dummy_adrs38', '0900-006-003'),
('C141', '馬26', 'aTwTtMPclI', 'wsHKQPINxj@gmail.com', '$2y$10$WlRJbZ9N6mIf.ygJC2CyK.2O7WAZ0tZBr.BaJ0GtdVOFmQ/v.sVpa', 'M', '1997-12-14', 'my_dummy_adrs64', '0900-005-001'),
('C142', '吳43', '8YKNvw3jf8', 'FGHs89k5Dk@gmail.com', '$2y$10$qO7rj30g3u9WPBRDjPCiQ.4hn/QH9Om8his49g10nsk/gkl.x3Bpi', 'M', '1997-06-20', 'my_dummy_adrs39', '0900-003-009'),
('C143', '周91', 'aXaudZY4u2', 'C7N4LAAw85@gmail.com', '$2y$10$icDlh3vp3TVT07UpMOQ7ru2iFNW6.ExvBXaat5Sk0UHgdHyhzdPjy', 'F', '1997-04-04', 'my_dummy_adrs90', '0900-005-003'),
('C144', '吳27', 'X6xaSdQHBe', 'DH4WMwKwuu@gmail.com', '$2y$10$0747vWgPOgOnhzKjEz04CehpUFxoapSqLf3aKOj9hctcH29T3dMqW', 'F', '1997-12-27', 'my_dummy_adrs96', '0900-006-004'),
('C145', '林81', 'PfnOLGAmoL', 'cm9k9EJ9Zo@gmail.com', '$2y$10$maUOBxkqRWFcGZCC9ZdvuOXYaBC5ePfgbFHagvGVLrs/IpYWFqdr.', 'F', '1997-04-15', 'my_dummy_adrs28', '0900-004-009'),
('C146', '周78', 'cjEqQATZdf', '6YHf6CQAFn@gmail.com', '$2y$10$CZvvKDn1rYIE3.CcC0wucu/ogOZc2iYQn6kJyNVAhIAWBUlhLQSFq', 'M', '1997-03-25', 'my_dummy_adrs93', '0900-007-001'),
('C147', '朱58', 'cg8PE7lR6f', 'h5BgLeVmeW@gmail.com', '$2y$10$bbIGDldRvkp2VaB4csr9uuJfvWmgZe/MEGTygcuHNFMe0PiHfnlVe', 'F', '1997-02-24', 'my_dummy_adrs22', '0900-004-008'),
('C148', '孫35', 'cH2tUMY5ib', 'zKwX7sQQOW@gmail.com', '$2y$10$VvK45G7zkHg9bMD/MkK8weTv9Ep9lUXwGfOAfwv/ZAgmWiZPZ9AAa', 'F', '1997-12-26', 'my_dummy_adrs41', '0900-008-008'),
('C149', '郭22', 'yUHGJySuKu', 'xwbkjYFnLK@gmail.com', '$2y$10$6C7ZIwRRzih0orVdDPqqduG9dPcd1ongY1I1xYkE4FL5BTFIjDxVe', 'M', '1997-10-26', 'my_dummy_adrs36', '0900-003-005'),
('C150', '郭74', 'HkPpYmE0oi', 'Vsh0NBgQm8@gmail.com', '$2y$10$aDJf4UhVRZ1KYWnWZ8Xf/OyRfuCnLxTXWXcOb0pdAoKs1Jca.C5CW', 'M', '1997-03-02', 'my_dummy_adrs22', '0900-006-009'),
('C151', '趙35', 'sd1SZqzkJ0', '4HKskWPlvC@gmail.com', '$2y$10$H.YhfkfG/4WbBg9KwL3NuukqPsgpRtWPbyLXn02M1MfzPYsNodDQy', 'F', '1997-02-20', 'my_dummy_adrs30', '0900-001-001'),
('C152', '羅81', 'eJuFagCnwn', 'hYqRefyyeC@gmail.com', '$2y$10$MPmBjMiVaIleBewyutSrlORDG4IM9cRnR/uPn2Rr3mbdqe3p9StAu', 'M', '1997-01-07', 'my_dummy_adrs69', '0900-007-001'),
('C153', '王62', '0tWFzuVuaa', 'WeV1yGXanB@gmail.com', '$2y$10$zxnZTmkgk62xbLWoe/f45O8ahm6cYoN/bt5pPGwkevHSlEXqdbz36', 'M', '1997-02-16', 'my_dummy_adrs23', '0900-005-002'),
('C154', '徐16', 'qBzMi6kw9a', 'XbfoNOuPIj@gmail.com', '$2y$10$f5fsc7BCvC6Etq39RML2geh1sLieWcv72X/5dS0MK0CeG1FBSbBIu', 'F', '1997-03-07', 'my_dummy_adrs38', '0900-001-009'),
('C155', '謝44', 'wxnh4p5r9y', 'HAUS4yRmka@gmail.com', '$2y$10$5A.RQzRpvA2QfMf8GlpMDOylKFe0oD5QirFEmwIurZiYqn6NttMRm', 'M', '1997-11-27', 'my_dummy_adrs55', '0900-008-009'),
('C156', '王96', 'x8fA4gXvkO', 'y1FO1lotHQ@gmail.com', '$2y$10$vNb2KzYPH1gcTt8vgbNLN.ZG4OxCYNk5yKO3QUAO5ywuMSJuw8mSS', 'M', '1997-03-28', 'my_dummy_adrs36', '0900-006-002'),
('C157', '馬91', 'nOi0mPnvBB', 'eb2o39r5fT@gmail.com', '$2y$10$KisZIBpLC0a41I6GUjvCGuodYLaL6fWsZyBatMNTe8dQrPVnAmkBm', 'F', '1997-01-29', 'my_dummy_adrs63', '0900-007-009'),
('C158', '馬21', 'Fx0G4z2r8j', '3SPbxNPSIT@gmail.com', '$2y$10$vN9/oi.tNpDPUnUUjI3eO.KssS2USBjbddb/7mBGHBLqJaWj3N6ei', 'F', '1997-07-04', 'my_dummy_adrs58', '0900-007-004'),
('C159', '梁36', '9XqlwnGTtV', 'GknR7jVHTa@gmail.com', '$2y$10$LqRS91YBhWJLnDHGn4DAKOzBJ9PtzrYqnFMSEnjFPkOp0MPSrM6qm', 'M', '1997-01-16', 'my_dummy_adrs13', '0900-001-002'),
('C160', '王48', 'tMFuQn35aX', 'KSJkC4CBiP@gmail.com', '$2y$10$Oe6a0KhJGuXwbi8/ML3HZueXzv75T0eZciyLoVho8t6aYEXsm2XpS', 'F', '1997-11-24', 'my_dummy_adrs99', '0900-007-006'),
('C161', '高28', 'WoeV2W6uPt', 'vuzuJmJu5y@gmail.com', '$2y$10$v7bu21QfUPtZWuTZubhQAOVBtG2KCgkGBM3yuDuabG9EE7yw6NvsC', 'F', '1997-12-19', 'my_dummy_adrs74', '0900-005-003'),
('C162', '李75', '6NcDENrdqq', 'NjTMOUFo1U@gmail.com', '$2y$10$v6zaEi99nYF0LkqpL.u2zeI407wQ2W/a0C/ZUwjPihtRQSwyYHVbi', 'M', '1997-12-24', 'my_dummy_adrs83', '0900-004-004'),
('C163', '林84', 'iCu0Gmjotp', 'XjVnH1wpQR@gmail.com', '$2y$10$0BJiYcm2UOYMdbiitMJ/MuepxCd02KcOSwQS45nax0YkuXgghtokm', 'M', '1997-05-06', 'my_dummy_adrs42', '0900-001-006'),
('C164', '陳86', 'uc1Ar9V9Cr', 'JAo2452QsL@gmail.com', '$2y$10$KJtY9qO9.S4l0SQEkzERyeIeHYOzF131Ys8bY2xH2woGRwrdGxNTa', 'M', '1997-06-23', 'my_dummy_adrs66', '0900-005-009'),
('C165', '孫29', 'bJ2u0qJPpP', 'B48PvlpQkd@gmail.com', '$2y$10$cSMB38wEFaEQgSyWgVp3O.NOCP4i2xjdjjXHnf9yyKyM2tX7X4/fO', 'M', '1997-04-07', 'my_dummy_adrs39', '0900-009-009'),
('C166', '劉61', 'fyChlJZvRz', 'J67RjDYtxa@gmail.com', '$2y$10$qGessG5kvJu6mY7wZ8w17etNtYsKhGnSeiaBembxwDyPFcmqgeDjm', 'M', '1997-11-12', 'my_dummy_adrs73', '0900-003-002'),
('C167', '謝83', 'GBF018Pbs6', 'nrFyeC0t9g@gmail.com', '$2y$10$00gk6j9Z8ym3rfXIXsRL5.TVq5I3lcA1B1SvdILYAJaoFiGYu8fGi', 'M', '1997-06-07', 'my_dummy_adrs59', '0900-005-005'),
('C168', '徐78', 'ogogevQn5U', 'B284Uinmvp@gmail.com', '$2y$10$8hYccqDTzQNAwdKYpUjYKe.IZMlVFeJEyIpgHBsNsYbFOBwz3c1Mu', 'F', '1997-11-01', 'my_dummy_adrs26', '0900-004-001'),
('C169', '周36', 'SfYlHm9Sct', 'CrTakzRxN7@gmail.com', '$2y$10$W4dvFvMk/3ic.5ZbWcEOsO6p.nzdi.0NzZyVgMveoOjGXPwN0Efg2', 'M', '1997-03-28', 'my_dummy_adrs8', '0900-003-001'),
('C170', '周59', 'XLO2lZjRr0', 'ZGFfCUY0Va@gmail.com', '$2y$10$YP9CtR47sZQenffc080GNOcYUppV.qylbu4ay3l6vBqXvyjQiOuH.', 'M', '1997-08-04', 'my_dummy_adrs45', '0900-006-006'),
('C171', '梁58', 'rqf5NxuGCh', 'HaUWoIvPDz@gmail.com', '$2y$10$ULhatBxWSx5kl0914JP4jOfY3nqeko.qaLo0xBgFP.pgyJ5.jv7ty', 'M', '1997-10-27', 'my_dummy_adrs81', '0900-009-008'),
('C172', '陳19', 'vPxdsTVJEF', 'FvRNs3y26D@gmail.com', '$2y$10$ovhOBAAjlawQtqCeVQyUme6mNExt1bPT2Uaf..4PdEIBEvljut3K.', 'F', '1997-10-13', 'my_dummy_adrs89', '0900-004-009'),
('C173', '張11', 'j8A2z2BTSe', 'PXZpKYfuXY@gmail.com', '$2y$10$uoRVRWHLT7nIu15vgh.RNOhD9wBjRw9W2/4j.ycJT1R5xybhryzSK', 'F', '1997-12-11', 'my_dummy_adrs20', '0900-008-004'),
('C174', '周98', 'wFk8aFmwxI', '1O1WTli2D9@gmail.com', '$2y$10$5FRejSv9sk8MCPDFRkkUxuIlDQ4AVSOpCd9q0qbT4xjiernJJkjdy', 'F', '1997-04-19', 'my_dummy_adrs82', '0900-007-009'),
('C175', '張25', 'Eidz4KzCoR', 'nLpim4nUky@gmail.com', '$2y$10$pKuMSL4k/dMgOru7M7GLLeGJlGajngIxohjMkmbYLd8BbnI/f3Jie', 'M', '1997-06-29', 'my_dummy_adrs80', '0900-005-002'),
('C176', '朱81', '2cmkGOoTGx', 'NWII8Kut3x@gmail.com', '$2y$10$fewS38uLsx5R31c9UKUNI.HvqDg4ScZk4RmU5xMfwj0c3FXlx3sCK', 'F', '1997-04-18', 'my_dummy_adrs37', '0900-006-003'),
('C177', '梁53', 'JS3OdHei68', 'aN986Eik35@gmail.com', '$2y$10$Vg3jkFPxGNroR/dJhIqRUeaAMbojy9kY7GkeBnrGCjir/oaou3R2G', 'M', '1997-10-22', 'my_dummy_adrs72', '0900-002-008'),
('C178', '徐38', 'nUEZGr9rKS', 'LeWevHO5eI@gmail.com', '$2y$10$7BP7v3vAA48LY4dc82/J1.y5ewLFObxU9EB2tSto1U4mpDgs2jmBS', 'F', '1997-03-24', 'my_dummy_adrs42', '0900-005-005'),
('C179', '馬81', 'ZCO4Y0kByP', 'TqIjyCmUa2@gmail.com', '$2y$10$4lq2A82z3.3AoCHiwKkiC.3JAM0MINp87GU9bs.Owyo5YG7vKJ5pC', 'M', '1997-05-19', 'my_dummy_adrs39', '0900-003-007'),
('C180', '林96', '8V6HOPv0gk', 'oqdV5Ejz9B@gmail.com', '$2y$10$9aXSlPUvVlu7QPrwl3d5P.0khUobJ9y.ARylXstpQpu/qKixzgn72', 'M', '1997-05-22', 'my_dummy_adrs89', '0900-004-003'),
('C181', '羅72', 'JjhstdpE34', 'jbNplJSNFw@gmail.com', '$2y$10$i8QpzUoMjoRVTQZqYlEgP.23Np7qXCaQMYfPh/.QOhyZKhBFCr/zq', 'M', '1997-03-13', 'my_dummy_adrs4', '0900-002-009'),
('C182', '高59', 'FOCUYGZum3', 'lLwhXELH6J@gmail.com', '$2y$10$fNeOPO2p8BDSW52tP5Xgf.7wbwK735eA3J0ZLA2VBHt4zsgFfjURa', 'M', '1997-09-17', 'my_dummy_adrs92', '0900-006-001'),
('C183', '何63', '5JYLIQsh14', 'vBBJeerQJE@gmail.com', '$2y$10$lbSkHrFcYHQDSsVkax3OkeoT6qWD4HiydgqnJDQcpxwBJIHsXgmM.', 'M', '1997-12-25', 'my_dummy_adrs85', '0900-009-001'),
('C184', '高66', 'q7cB2kdB0z', 'C3Zgy4MHeq@gmail.com', '$2y$10$c9aBmGoo7qgt.z7MM7zkHeZjJogrsimMFv46XSjbnPcry40PTDygu', 'M', '1997-06-23', 'my_dummy_adrs20', '0900-005-008'),
('C185', '徐38', '67s8r2puBy', '8LrIl97cZ6@gmail.com', '$2y$10$0X1tif6vhGIw/pzWT9TMf.0y5/Nuh.g1DOBGoVVmarDgOmTDkKQx2', 'M', '1997-09-11', 'my_dummy_adrs77', '0900-002-007'),
('C186', '劉37', 'vCaQXcduKL', 'a0JqWKyCxZ@gmail.com', '$2y$10$u8VprKN.Z.GruBdgvdq9UOhMifV17ZFX/rSP2HIF069YzMwqVG0D6', 'M', '1997-09-09', 'my_dummy_adrs25', '0900-009-005'),
('C187', '馬37', '1R4oFwrdkD', '8UL1UWTHQo@gmail.com', '$2y$10$IYYDyJI0IGBdDtWRAoYHhuyMpvepRx/JNhWw77UVGU2Rc4sN9ri8O', 'M', '1997-07-09', 'my_dummy_adrs79', '0900-007-009'),
('C188', '鄭91', 'sdjkgKr8zg', 'S5XgGtLzff@gmail.com', '$2y$10$6TZTY3JoK3WEucAr7kzW7ujLn.gFUaGNqCwmwpQeS1sS9JGt/.vKK', 'M', '1997-04-10', 'my_dummy_adrs33', '0900-001-005'),
('C189', '胡83', '62hLn2z4Tr', 'cNOWYGyR4P@gmail.com', '$2y$10$2Np6.tZoXsJcb.esic5mPOsKPc5UkNkzEH84bivCe1aUxQqUyGDx2', 'F', '1997-10-14', 'my_dummy_adrs84', '0900-002-004'),
('C190', '馬87', '3yrm2i6gsD', 'YhIDK8ob08@gmail.com', '$2y$10$H72SwLnCWVsMZdFc4h6n2O4Kb7B9Lpjl1CIhfH/yO41B1f4NvtJXu', 'M', '1997-02-04', 'my_dummy_adrs84', '0900-003-002'),
('C191', '吳32', 'MBVyxnWNXd', '16oJy2I4C0@gmail.com', '$2y$10$tVVi7Z1DbQJ6oYYgTdzg6.ENX.H.Yn3OUHAP.8UVk/IdbBBY8ydSq', 'M', '1997-03-25', 'my_dummy_adrs21', '0900-007-006'),
('C192', '羅15', '311Gci7zPP', 'xP4h9DfFwM@gmail.com', '$2y$10$KJfoh3Sq14PB8eBpmPEf3uruj02Y98gB3.QwFrkBp71vtSyMjwG26', 'M', '1997-05-30', 'my_dummy_adrs84', '0900-006-005'),
('C193', '吳32', 'dz3q2mbqGP', 'FhU1PHbTDz@gmail.com', '$2y$10$du//kef.ldLg8tf5ofYNgeKghJ/icPHz9jr8DTcpr5WryKUMGirVq', 'F', '1997-12-16', 'my_dummy_adrs36', '0900-008-007'),
('C194', '高82', 'Wa1tspeEDq', 'sNKAsjFoI8@gmail.com', '$2y$10$8P5QkotP3uY3HXN/FiMo4OW4k2ny8Yv81HGoM9AYjvGBsSdFfXcMO', 'F', '1997-01-04', 'my_dummy_adrs15', '0900-007-007'),
('C195', '謝84', '7dCGX2C1f8', 'ujVYe2CFAt@gmail.com', '$2y$10$4dEnPfYtHCw0WdiwEiiCqOgfiZk0JT9p0ZgMPtFfaDWG.qsDkI922', 'M', '1997-01-27', 'my_dummy_adrs11', '0900-003-008'),
('C196', '楊25', 'zn4OpbNc5B', '3sVZs1qKWc@gmail.com', '$2y$10$z30C0kux4gRKbNMd8DX7OO3dvtrFQEP0nkdUPvbw2iJ/Bz1YlQTRO', 'F', '1997-03-30', 'my_dummy_adrs43', '0900-001-009'),
('C197', '胡45', 'xnFr3vLTyf', 'xP49PsgwV6@gmail.com', '$2y$10$oEZR0jyQD503sbTjrD3.CeMXWxvFDT2tYuhuR3ycDCLwF.Oyv7k0m', 'F', '1997-04-05', 'my_dummy_adrs33', '0900-008-006'),
('C198', '馬97', 'epxEXIbWqW', 'aYAyS2lQJi@gmail.com', '$2y$10$8UH46nkEfDMgGrSNDyEsl.NzmOtNkywDZG3R9Xo4H0Aaic/9kgWFm', 'M', '1997-04-08', 'my_dummy_adrs40', '0900-006-008'),
('C199', '鄭56', 'xImLJyWOdI', 'asC8ncpvuE@gmail.com', '$2y$10$.LaeHsKZlcVhSuODG8XLJesVfcjZs8pYNtxPsEM5ws.BovsU1xJne', 'F', '1997-11-14', 'my_dummy_adrs21', '0900-009-007'),
('C200', '郭14', 'a70aIsWEgw', '747QWUiEpa@gmail.com', '$2y$10$568NImG1hfTn1cTMEP34CO713PG2GnTowtulplDaTstD1COJKIUmO', 'M', '1997-09-27', 'my_dummy_adrs70', '0900-006-005');
-- add dummy datas:

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
('CR001', 'C002', '2019-02-18', '客訴客訴客訴客訴客訴客訴', 'Y'),
('CR002', 'C003', '2019-03-13', '客訴客訴客訴客訴客訴客訴', 'Y'),
('CR003', 'C001', '2019-02-22', '客訴客訴客訴客訴客訴客訴', 'Y'),
('CR004', 'C002', '2019-05-11', '客訴客訴客訴客訴客訴客訴', 'N'),
('CR005', 'C009', '2019-08-18', '客訴客訴客訴客訴客訴客訴', 'N'),
('CR006', 'C002', '2019-09-01', '客訴客訴客訴客訴客訴客訴', 'N'),
('CR007', 'C005', '2019-02-18', '客訴客訴客訴客訴客訴客訴', 'N'),
('CR008', 'C003', '2019-12-30', '客訴客訴客訴客訴客訴客訴', 'Y'),
('CR009', 'C004', '2019-12-30', '客訴客訴客訴客訴客訴客訴', 'Y'),
('CR010', 'C063', '1997-01-24', '1qoHB6YUOgSUuMyioIjdEtumg6J3m4rLtKKzl9heo8CmBm6t0vHjlKdtOljGx7QFOLKUkYtHWErVclnjA8e8oxOlYK3NOx9P7mTa', 'N'),
('CR011', 'C001', '1997-01-15', '2xx0543imj9CQv9XwmEdpno88ODJI6Du16CPyYzW6XRSIykQmnT9ccNqfp6VkkedOmjTeg8xsShmVqawxAQzv2dUc9B5fQZ9sh6N', 'Y'),
('CR012', 'C037', '1997-06-12', 'HdYgTj8u0JfkWIO9pnZpn4ZYNoPEgKalTS68nqeSKNlBbfvnIJvst5CJkTnCXMpzTExV4TC2ZCHDhRRuLq1u2DxqxOSr4wbsKYCg', 'Y'),
('CR013', 'C048', '1997-10-08', 'd5a1Lieu9oquQuR73EkqUsosWoc47drVZkN0fsluYl3JPbcuymBLfyl3raFpdcbZYPKPFhU5z6IEj6g9j2X3sb7qzXebLkq5l9j6', 'N'),
('CR014', 'C052', '1997-11-04', 'kFuu3Fdzb4EtGpYNF7GNHhSYPQfWkpimOLcr07mwXhINpdYsfxU9iTRPfip610cwjxv3fOjLab1yLZXG9najdmYSoTrbIQhxwvDA', 'Y'),
('CR015', 'C164', '1997-08-22', 'lOf4SCD1t0Y1XJ2ipHyINQSuGMGAEUMFBh6FgMyfdMlplQLHLVLxXni7RMODt97cG7qfSbVXpENrNMdMMF6k8xoJhpwkDLRXFkZ8', 'Y'),
('CR016', 'C010', '1997-09-08', 'gLMpyHQp7hQzLz5mFM6LmJiLwFJvQqrvaB69E3jo3GVpmUQIC9DkLc2RgXfVikXbnwclEiQQSeSpcBjIruLRljumdJeAcEJXzC82', 'Y'),
('CR017', 'C199', '1997-02-17', 'qdgzxxetKmIXsLxryNo2OQckRoZktBBRZY2cHW9dbnEDN5asmWXzNJyDsG2O75jEEjrSdGWkE7iJ6Oa83XiZXmgWHEaTKuSQZ0Vo', 'N'),
('CR018', 'C030', '1997-09-12', 'XES9pPxzTZ3FsSely8iYWfFyQ3iXQyBm6ZpswrD7uVLL3smHQv0cdDcUdxIN5uQ31fw4iesFEFAxNQrEl9Wuk3qTGyIrcymNqdcS', 'N'),
('CR019', 'C188', '1997-10-06', '2jDVu7AhgFPmxvEAYu5dO86LMe1mkfd7tyKhcXgmTx2zE52p2oIt8oz9FJxfFL5jGYTue178dxw5n5XsC798Eh6EilQpRg9tnQ0v', 'N'),
('CR020', 'C100', '1997-12-17', 'DZTvZWhfKdMB00eHOlAHIT62iwRDeRSVgnzTTSdTUYDkGdCeHIhCALU8BcVyijhXRSoAY5M5QQpYENYkQYsFsw4d6lOzPojmXBDE', 'N'),
('CR021', 'C097', '1997-08-20', '6UGXnDk7qI6IUO2gSfDGvvvLiNagGHYRF1pZ8USZNnCx3xMiQFiFtVgwdfFn4SGqjzv02MhSE2HdUHrTbknkBgn8nnRIfwMu9aFx', 'N'),
('CR022', 'C041', '1997-09-04', 'kutiOvNX94nDFtFENuJ6plaHtQuBTrEumwEFj22rLgiX0XbqUSquzkaiPBfSAnQD7A6Q1RgjTdTQFNGq3TJYrv2INDfeo8RSAENn', 'Y'),
('CR023', 'C029', '1997-11-02', 'xPvH2Bbr8vdwlxqHk1GEITnCCXxGXpQDzzdsti60RtIQFCSW7kATQaxtA5jbMa2H0fu1FviJ6pSJUky4gLPNHuWuAERob7jvA4v1', 'N'),
('CR024', 'C062', '1997-11-25', 'lQs5VGEaDpEbHyDvogXOQ9vXk3cUfBjNydcJKpWEuGgz1BuYu6e0qM82FTCTzPKSoFXVhBzfow9jAKKA8NUYZuqcLnsU8HE6NYJj', 'Y'),
('CR025', 'C090', '1997-07-31', 'sNp9j1Y4ZqmiPjxCKE1OMRCnSS1nRJ3sjeW0fUgRRuljZXLY7k36rQMtnZygXRRrZbIE6Gt8Wb19mJSBdKjD8eoAt7gPmpXHKt1i', 'N'),
('CR026', 'C048', '1997-09-24', 'wxVN3AvRjveMvHJ8f9rzFvwJ8VhsUqKmBSdz8i5pQMjY0IKN0Yeho1qjyq1TWUPf87sgdnbwdZKpzyaUUzDHXCiw29lZSeRdG2Ew', 'N'),
('CR027', 'C049', '1997-12-10', 'McbcmBBi0Q8rR4N9bXreypxuNuwhE92W0BOGmBbeLmTtTBW8Wuj4q6ahOwm28xb4Pk4Ad3Dl5ZJfqKdiCmDqtZekrxAIXV3p7X1Z', 'N'),
('CR028', 'C083', '1997-07-21', 'u1uasKZ3yYYQLGQFdq7MqAZYun3pQjdIl3kiy4h29ghfLsL6UWyw1Rxbif7cvSfv5pYwwte3bOg1gkHcTIpBDwrB4gvxwvYjMBKV', 'N'),
('CR029', 'C154', '1997-11-30', 'PCYeiYtqSatJIm4xk4QE6hKFA7jRJQmXVA1JY6NUXnfu8nRj53OdWEHq7sxIGLlclX3VP8PdVwzSnNLnljSFUmyW91hlhxVjUBkK', 'N'),
('CR030', 'C174', '1997-11-30', 'DnZhgNHJsJCBJNlDYlLVxR1k0Zb7I3EgqcQtkgn74cbHH4U1zscLWjN4RwQVHVbXSCd33mK2OFityndhWNF0CTMAtj6aLhyUyPUh', 'Y'),
('CR031', 'C027', '1997-02-18', '41GF1uTQMvs48M1QBHkILhxzgLIhTalEeaGSZtvBbcYGl4do7Seu0zoWd4wZW7vGh8WTJ9jeZfFyalR5XsMrov8soaR1aJe1uzhx', 'N'),
('CR032', 'C068', '1997-11-08', 'vy4h8ggiznieoOvL3opRSs4SBYXnzJQ5IEL0AtCccGiRaFHATbMlrYjsicPYh6BJXrjFOx9X637eoHZuNpRRgATH988cO4XslAhJ', 'N'),
('CR033', 'C161', '1997-09-01', 'kiEwyx2C2JoEK8xdHIOdPXZrwBVo2Lf8oisHRLxkzmfPJFh2e6nSY3n1CJluOqW65rTC4vIfVPdQjMq8kFkQG3hvU80V1isowXIy', 'N'),
('CR034', 'C033', '1997-06-29', 'KPNSHrTguxBx4LJ0tML76ZaCJ7yS4RiCNtdZYUpyYj0NgfaC1n7BfHwqWZrga0U5H4Xg4ZiiLDTJ29bAXIswCjnmJSDNK1WxVKWR', 'N'),
('CR035', 'C122', '1997-08-25', 'pPGx45gn6wZfZ5kXFzqes2SOkwMwNKoXrcXNeWIyvt818MBMZ0gYeOYwAIkCNL7YAoysKSpq8aV8lGmrK8PjjiiScItobeliabr7', 'N'),
('CR036', 'C043', '1997-01-07', 'TiQ1FfZCAZrdvqSwKppK9bcBb9huq1EjjK2sx651d7dEerDkKEj3z3oNA8APdPUR0pGruf7doqJEuBl0mKnnLqPQ1mZ0hpwiy20E', 'Y'),
('CR037', 'C114', '1997-08-28', 'Aho7UJzmfUaOA5DmFtWIkw89gMr109Lj08QzlbKzctN2sPs4VXwjomV4i2n2dtLplmjwxX8otd0osBkV0Ibh3iKczgOZHuwUUOmz', 'N'),
('CR038', 'C189', '1997-01-30', 'mALEevzKAy6P5x0xPZ6ziL7k5PQOg9zhVnCIWPWXZV3YKw5E2sQryvHnLJfUxwDcVRxuOd8EWYxUXhNLP5juK3klCdkHpg3H6Pyh', 'N'),
('CR039', 'C120', '1997-08-25', 'vSw7MImEkExlLlPl0XVX0c4NR4z5kCN1P918ENPpGjp4iJdo1sHe1zSazjLX31r613NoKHP0Wz6xUdR6F6BLhreuuT2bupkvWRot', 'N'),
('CR040', 'C020', '1997-06-06', 'UHVlVZN4kNoDPMmAWK4tY06QQfaR6K6LvW9UcRsTP5vp3YgT7pHjj307EBvfKsGr3J6vz6Cn6tzV7zNHjdzrbPzmYvULxpo0atQt', 'N'),
('CR041', 'C041', '1997-08-06', 'HxjVodkBMjC3Yn5gDqDWCtvzjsXOlbTenQ1zGM1muwrmaMPO3yzwuAARZOGORUJMbHfz3gSzTnKVUvZgsBfVAocQ1AYibqGp5k83', 'N'),
('CR042', 'C196', '1997-07-05', 'Txc55lIIewjanFvqpa9zVRM77uEGAgz08x8LWjo7ABY2Y3DYzeUuzMUjWiIWWa8zGHgVUWeyz0OakN74baS2r7LCJoTTh7jya1p5', 'Y'),
('CR043', 'C122', '1997-10-04', 'l8uVGch1NcwARzEiafWGhm7WfT5BRaiNRxZVZcvIUBECQoEpZ5oFEPju07Dcf2sQ8NpgRTAd52fGuiauGZkaViToWON46fT4ZJZb', 'N'),
('CR044', 'C026', '1997-01-20', 'JhkzmQIj5paBbgg0aGUzPLSh4DIK3rzJLjFRBLsAjRJ4wgRB1omK10XYqkQy2fQYL09MEnIdxNFke6nTSJOHHvkHCxRERcVjrQWb', 'Y'),
('CR045', 'C167', '1997-02-01', '3poujSsL0jZlqbuMwG12ACOjAJ3U5DI0LAHXILSRyttD0Mmmet2geebFc3QByynCkOuHVap8jOerfLpXgg7HqFIry7nySWVGpRSe', 'N'),
('CR046', 'C095', '1997-05-12', '9KjOiTTwZk3H8tl8qy7iDqT6IjTXbwrF0eDGoumCJEUFceTcS4zwx45GeTPsn31UD2dONfPnF4w3DYl93EEE2d28d2TQWsvhTeSc', 'N'),
('CR047', 'C097', '1997-09-26', '3lyA7I6ybK4vLx53uK8jxVaCDtsjSXdib7TEXwEdkTr5YcTAfXpaUtcpYVZC2yin1C1vikxcNJALEn0GNo5oj3bxLBVolWRQGI4C', 'N'),
('CR048', 'C037', '1997-04-03', 'T4J6LcfCK0xy5m6tsSZQzjST1v2ogAMwmPgMYUArtcgZ1XBSAWekk2J7Vub5P8Xf4v5NzaK3FqAZvWAGWjmsMHW8r7PHBnjJmi6O', 'Y'),
('CR049', 'C069', '1997-05-28', 'S9dhNrCzL6cJZ2o6rF00DqABPZGBMk2QdmkoWMQ7rLvHLiwWAvnJ1BR9MHE7DIDsB3oPOogVsOUkZmh0KUR3bBFtDlQfdcrZ1igK', 'N'),
('CR050', 'C003', '1997-12-12', 'Ph5jCwoJUuSSKOZlueuCC6r9k3lTSq3xrp3TBIYhg2Tw6YO3pt3wPI6x8oz7vESGbbs8iufD42bxRuE5Dw3UtkLiBBnE593xtZ9n', 'Y'),
('CR051', 'C001', '1997-06-02', 'fWtSUkEc6DByLvxLsQfo1K5FkMCuqhDAatdPINiAx5wcD8HV2hkJHyiXlQJuEapzchRfoCth5iH9KwqYSIEkzul3mVr0IXCO7v9f', 'N'),
('CR052', 'C068', '1997-04-26', 'SLJGl9NFwLEKmBbDaUGy6VAWcq2vT6SSSi8lzD8gZ5OfwS1nEVwvWU1KqAOMVzaiKB3f2yJCmFL6bOFOBoRRkjvpcOONiUOh3csU', 'N'),
('CR053', 'C022', '1997-04-16', 'CM9AjlvU3wT2v8djS42i1BY62mOfavWufzmxjHAK4HurFJk8PsAyTwOtb7KO4Ei4OmuW9KrQjqsHZdAvOGVtH4v0PgwfiSjsyGl5', 'Y'),
('CR054', 'C140', '1997-02-16', '7dwKRP5TTUOSwt3l6Dn5p7iUW24Phyw3zafm6AXv0FahT9v7MHAvNzXBrGtCSnwGzUoUaGIgpqBIPZK4ygfc0JZwZ1eZenrWZki8', 'Y'),
('CR055', 'C048', '1997-08-25', 'X4eCrisknmVSPng1zLog1d0qqtGdydzziuoVAiv5XYt0BUKBvKNZHPquykcEADRoAuSjPleDaX6gK0bMmkFlikk8qQmbqw66ngmB', 'N'),
('CR056', 'C095', '1997-05-13', 's5yERPzPe0xPFeFojsOYhsY0YXEgIO5l4TZ7Kke0uc2nqbFwaXt2KY9p2jHjZIB3CvknCKbPhItFkKFHvOI688PLuvhEhXa2dlXw', 'N'),
('CR057', 'C200', '1997-05-07', 'dRaEo2drlEy9Pk2nGdbxAqTAIYI0OF5CaC7hZPn7Me6xqx0LnnS2Yetg1SB9ggXIB2xQWBXoMoGN2oxCYwI8a1s2FUGoF2rdkV5a', 'N'),
('CR058', 'C187', '1997-08-17', 'IWuyYOxnzJFoPbsZjupWpiqOCVeazPSSscwZP3BObtkwXSFqoDPVV2bg2CLLPSrJyHxNfi5WvyO1q25W8KZaubViOJtEM8QIegKP', 'N'),
('CR059', 'C190', '1997-12-07', 'mF0ZVh8ZSL7qcnLwF1QV4buFh5aHF2MBLqxfIVo6SInc5zkgxMJ834x10jxpvpzcmiZ2hiuUBeHw5GaSUwMnspYLHEEoucXMX5RJ', 'N'),
('CR060', 'C160', '1997-02-22', 'UVjz2WEBjLoju01d76vssE0XDg7LZrUel9BeCGmUJvrz8uqSq4VODJsfi2hFpFwlgssHuyhXT9MRxbuGwwPP5FxX96paj1ihNbwp', 'Y'),
('CR061', 'C142', '1997-05-29', 'vphz4tUl8F6oU54TCQeADnY6nCQV0AkfjtyE6vdpodesDIUUKhWl5sOCj3rwtHaht1GvmY1a9XaKOl8F5QuPDW2mZ7CgOJKjjxz7', 'N'),
('CR062', 'C172', '1997-07-21', 'yHcwrK3zZb87rvi7r4NM0oPYE2CwXXQ5OFCqLg2YfPUkrIfgnDe3F2k7GxqgHTFIkMHIU98e6bMmT067MkN3PwYjNm3xbSQ2sLRX', 'Y'),
('CR063', 'C007', '1997-06-10', 'JHUqodqoqvx1RBAXm7qiXqGrGVZswu1RwhHqy9ZWqgrkc5s7YYdiIkQHyhw1cekEqfnQz17n0QgVBupIHySopuuW9kXlnvVe3PNB', 'N'),
('CR064', 'C075', '1997-02-01', 'iYKbjt5dIlKWGFM0T3gQ6VzRLZv4yY6wdpR9cj9ln4PTDouNlsd5UDtkPIwXfZK9KfHv6DVvBZ06sEqm7z9rGGBvulG2f94ElLdm', 'Y'),
('CR065', 'C057', '1997-01-07', 'IOYLjYXCkTRZTb4hOiMElZ24xm0X1UQRoTTsN5UeIvZnmHw14IBjeilI4jrftxaDNff9U6NxfZlLSsZll759WzWwNDeRex5sgRGM', 'N'),
('CR066', 'C164', '1997-04-06', '8rC5t1iqqb1K1ItG6T5s3etxA6M8rH5mHjhO2aM09jU3KnUdGstkAAYW4CfrB3DiACHEr1anbBMx9fDlaL2fnkK20KmHMEzyppV4', 'Y'),
('CR067', 'C024', '1997-12-24', 'bQSLpg2TtdV1u92maBmY9Z6dEoSAqsyHJ0DdL7XhXpSLdcV07pPPx3wGVKqzOCArPX0RGNcOtQ0x4mPWj4wIFMM4QZhR7QxfHY39', 'Y'),
('CR068', 'C061', '1997-06-11', '1BREHIlJEmzUqeY0D9Fygt5ncDf3vTlazEJc8A8VfZw0k4bQy00khh9ndfBRqW4Htpt4fWD6nYGHlMAXIOLEEg58z8LvYnQw1vum', 'Y'),
('CR069', 'C044', '1997-04-06', 'AHkvnjitb2BXXpsTcQPjgGxhMadVxRZmR7VccN3U7sE4PolVboAdoXde00JiHWq9sAOa9IBA8hhWoW97mrMm8gxA4RoZL2VPk5qA', 'Y'),
('CR070', 'C189', '1997-07-26', 'GquEYL9kBOx6H9DKIIgKI2h5uvwldrOZWkztht5zF4ENHXlDN0k0c2ZwKZZyGW2TQdx4U1D5iDqBY0uopMo6BC8jNMR69tiOpEn9', 'Y'),
('CR071', 'C142', '1997-10-18', 'c3zpJhB9XZwCdxCN2uyfFpVlAiVC8g3nRG9cqm5i6k1jrIa7hxnHFIUyt17XY0QtmuMryEQb16N5TEFYdtjLuOj18lRM7dAx8vv3', 'N'),
('CR072', 'C047', '1997-01-16', 'DvrjNPfGMBeg5vXmCiaShzEXlHGt292dxwBiZ4nvHIhAarelQqs4s4eFe52cYkrn59uonT5JNBEaSwVOgHvO6zcHmwt7PHSlh0FY', 'Y'),
('CR073', 'C162', '1997-08-01', 'HjC16nC5nV7IxEVlCQNHgQSQGxH3rOBirio4kMd005ITRJj0TsDyz1p7b72Vuasz0IhyanLWMx1beMfsL0XrI0pLzZ61tBSYmo23', 'Y'),
('CR074', 'C130', '1997-02-18', 'FoGtZkeP7Gk1oH1LhnlFvAjk4R9A2IcNv1HspuYrys7zgzOkPE8yymdrOxVztRXW92PvGHqKFr423HvFfbIRIWLEQW1XiYWjsWMW', 'Y'),
('CR075', 'C148', '1997-09-14', 'xvM0YOuDfYO7mMSOhRx2BvlaEDDXTCWNd2xi6Uu2RkHQBge3eTqN35ZRmaQhdYgzjsZuB1glhFDYj4pK0mK6hZw2YjDIJZx84VVG', 'Y'),
('CR076', 'C020', '1997-12-26', 'Ye7QROs7BPSUJX6gkxn1uvc32oPfr2UVaq3LD9pqwCr0TnLkINFB2Rf8WJAd8vZGIyJFYIJSOHbWJZARw5ZiyFrDJM2x8zDzULOf', 'N'),
('CR077', 'C196', '1997-08-18', 'AomLAvhVA3jN2vvsDBSO3byNoy1kFdqfcfPpaSmcn1PRPTqNUMNYfRf9rY4Pv5qOPLfhT8Z93tODLuVDMt5CwmpHzn5ifRV2jk3J', 'Y'),
('CR078', 'C074', '1997-06-11', 'mfqjcvZ36bbpcTz4Dvgu72uKR06SMRaCThrsJolu0KDjMX5To4gDpPafmUbBfz0xYZPcRfTdiZZ1cO3mjr5L8I2j5FoShsnFTINs', 'N'),
('CR079', 'C042', '1997-07-30', 'LelCIC1tkZsEq8mpAK2PduGPbF1JsgefyNG9nTuXqi7OkRV9Kheu7sdGWfAtHSCG6r0aHjqzwQTZ8xg4FAVJ85tbFcfoYk9XfSco', 'Y'),
('CR080', 'C085', '1997-09-21', 'yApXivHo8RHDAVcXvrRiYdxRk1htZBhurDvo7RwPRxw27riktDmtk0khEsZWx43TKX9lOZWXr34HIObvAEOFiPCkdpm0FTgeDiUa', 'Y'),
('CR081', 'C090', '1997-06-07', 'paw7jjNqUgOSoOowbu6cs2F42RJVIpqt8jHno9EK27lNWjb0BfRLqWOqzgGLm6Xq6sJwdqtsUv4l096Ot3GRbOHxNIegPRWYNgQF', 'N'),
('CR082', 'C110', '1997-12-08', '9sQTAYmFG8uYrlkxl7CNzVaBv9b5AMfQSd8YOj7KXAh3zVJi7CmVcYgmFGyurbpWNuGIiHYWklQ7zDax3dfAC4fKno4qPMrnYGQA', 'Y'),
('CR083', 'C196', '1997-12-17', 'k8TsGZ7ZaAy43NZAgJkcv6UteFMG7TlwbByU4J5R7AMaUOZyfep6tfUYs6MBN2BiWVB5UGhPFqBRV47uvKx6zQJ6ydlzYCwaxmTi', 'Y'),
('CR084', 'C018', '1997-05-15', 'a1Gn9il64RjS9gPa2Wxj1LkInO6TI4bhoYMvlmdvfhmI5vortDAtXA7eDFmuzBhvlIOK7JE5JNv0C70esHPjcu497d5vpR9ygqif', 'Y'),
('CR085', 'C136', '1997-09-30', 'kGw89gGti9DRPtRi6RFgz9YO4ohXtNNFd9dhKTC81uUM3F6PGSj7E4ojSoYU9dzSLIrSrLM8zPg25fikhYMWDeA2ZEgaHvOHmYe7', 'N'),
('CR086', 'C013', '1997-05-04', 'MnRTCBPXPG0QwIK2PfrZeW8YyNiGmwy3YNHKJTGMBANVzJjLGsXzg3OOA2SoXHuJjsTuVZdQQCFc5PPsVfnhOz4FwQwU8v5vnpgm', 'N'),
('CR087', 'C138', '1997-11-11', 'gf6otEkqrIRHLblB9scVMHG0uDVdwmcmCYyBrTiblhv2jAjgAdbLUtTqosMMax49bY3lvtNrHIA9xWLASBMc7tETQ0kPRtVlm0n7', 'Y'),
('CR088', 'C072', '1997-08-27', 'iSa81SmIAOZN7VNquu5jbexGDHMr5oXqTWUT75vSnRlupYvAqcdkBiGDPvUXSFiHPN87gICtz0jE2CrAyVkJxdxrkihQ0dpWGFIi', 'Y'),
('CR089', 'C159', '1997-01-21', '1joegrywv5VA7m4VH4N4Oc4ZSmSK1HMP6Pxdppptp1Y9ZHIamhcmSJDZmH2Enfdw6AmBxFxg8CSpEPhLTolc0kSsTl7xQqfP63Hx', 'N'),
('CR090', 'C185', '1997-05-19', 'HhgwdoRcss4YWw3cNwT3f9JOH8NCUM00C7m0B53cLDGXayZvLR2ehwGmmSOPzik4lUwp7GI5sRksVyuufGCvSR9kJv3NimD6ZuXK', 'N'),
('CR091', 'C065', '1997-08-18', '7ZgD10BF9dZgzZbB1bRH5I7cjk8Ym3fSpLlebxlrtv6fz5tK3wa9LJqwWRPFatP0Mf50PUnfRXRmpx7uOlt25gPJua9LSQIe23fF', 'N'),
('CR092', 'C006', '1997-08-12', '8qGHuKEFUqdIljojqujH1okHPPJLgConChQXlgd3lyBTpQAKAHXsWi6Z2no1ynEYXmFj7eOd9zp4797f1Ihz6jaFnF6TtaUEXjMT', 'Y'),
('CR093', 'C172', '1997-08-02', 'japXMsj5wBl2nHGdT4DgyFix1oPiPTmPg8K6eIXdysiSpZt0jOLxNHnePLSNrM6wh1a99EW0p2NaNvixuC0FQIUy4sFnHgA4BncC', 'N'),
('CR094', 'C156', '1997-03-16', 'yF2mHh3qdz1zQWvo8WlGSDVg0xgveR92J8pBFZzoOxv1p7tmv1UcxFOs0dHPDWiSclUi37TTHe4C4Yxp73wqOeVpIrDA77Cm1K8r', 'Y'),
('CR095', 'C062', '1997-08-22', 'pNL6CTipVfUwnCpga8J44YrWFJRYzgTmHmG7xJixeZuZTOLndJWaOkuIEuacxrkGtdof5IaOg0YSXs2PpPA2I1z6te9WmF8lVMIB', 'N'),
('CR096', 'C158', '1997-01-16', 'OT5YM6wOIzt3Apyqrhr9yiZPDbX0IH83EsVyEkchGfL1EKLKURoXUJPFSiiZSAajs6TpKgbGPeB2sSkh3ibyOYYhl03hmQB9ONPX', 'N'),
('CR097', 'C118', '1997-12-06', 'u1ULLuZFam26wm7kyQyQRKuAjB24d5Vgsd1rN9DVHhQos1WxJSV7m8AUdxnTrMrPzRbJPbzwgLKAoiBGIqTakfeqOSqzS88pwWGC', 'N'),
('CR098', 'C034', '1997-11-30', '8NQlWfObsZsZnWHPIt76U2huRmIIuyDArqxrbZkblWDnVpi2k3znrQYvlfCV4giEw8f2Idbkb0Z6XkQipSJ7p458RiqweSxia4vQ', 'Y'),
('CR099', 'C188', '1997-02-16', 'V4kLjdjF2S6wZolGBCuKk8qwipEL5dfUJUHA7i3tpOG5LtQLmdmn6sNENeQAALjXJGlko6FviRNdJARVTZgSbvMaV8yleDU8s9LE', 'Y'),
('CR100', 'C156', '1997-12-22', 'gAZQm7dmAWX8NMJi3S12Z9odu83SnQI1SsV49BTrocsBXHnWAbWOrmigIhunrzc2naYcU3BcxtjtlthLcJKVsa4hqbOzuduWPOHz', 'N'),
('CR101', 'C012', '1997-07-17', 'RXGQRczNpscZmDhnmRGu3TlF36V94KZ5stGdcTM7lFf7D2ARsEoSXAADS6uFz21yIJ6EkGqJB3VTn1wlbOXgK6rK4qOkOn6Sh5nd', 'N'),
('CR102', 'C148', '1997-10-29', 'qAtzZ9MHhkI9VmuTQpD7jlP26PEpAiLBJaeXqrELKpZ3TMqSpZuFIOMdo2w5p4sGtvMteiSWJGft1afP1834BHLn0X8dP2QJOejz', 'N'),
('CR103', 'C124', '1997-10-27', 'ZyTyiFaJ7MvfkN80xxrLkAr8XOJyhVcubtuvKFq8qXgTlMiVRWjHdqqhFvjN4VGTqsewqkfsHTwqtIVoDTuHb9rCGu4q3kIVJeMR', 'Y'),
('CR104', 'C103', '1997-09-16', 'g7GRDORMMMZxZ1CteDwdcHNu01rgui2mjQHDaBFb0qXpRDNm3fvcTEsjt3fTUJZD0zoQn3FGCjuv8fZHEwRpsk8NzGkhtlZKJxWG', 'Y'),
('CR105', 'C095', '1997-07-24', '0t8nzjA3YPpYh77j31NW6EOafjeaYn4Lt44MDVtCTPszHrzFtatcD2JD8ntJ3TsCdUlnwaQXkmZRHS5f4WfrvfAx54YAihwgliXg', 'N'),
('CR106', 'C143', '1997-05-06', 'xQVgs0EwxxblcK8dtrgOagGikhEMe1HJtHKRbV3y4XARYdESTe640a3pPAfZYjDdHKbzkMcNcuezkE3eMUL9l98mqiD2iH8z2pXq', 'Y'),
('CR107', 'C003', '1997-04-10', 'bnyoHgkLSQXzru8O3EV9b8yRVjyfprxvlZ3z9LYa5PDJx7wyYNmedVrHEvLmsB1aCwoll6q1WpJ9k3fR55GH5qmdXj4V4XZEmq5C', 'N'),
('CR108', 'C094', '1997-10-29', 'QRGa2c2Ef8cac86PnRtm07t4w0wqu7O1hHi5SJHNb6uEWA7piitED1RFkd98J2uBBqtuUoKF0vzNdw4fVkc0obRcnn9AiJb3i9bv', 'Y'),
('CR109', 'C071', '1997-04-23', 'CFUeK6Sclj56175xo1xqmHrILHq95G6m8yKPRT86a36HyJHyGSBAirZL52S15nihOYj8izQ0E7TpYeDIbMJXRExg2yAUyMY0a9tE', 'Y'),
('CR110', 'C189', '1997-07-19', 'KjcEvJLlmI2jrf6PP4qxJMSQPgm0bUq8DxAEsovOwFIvXkcbd9I3gP1UfdY4VFdLEKcxhKwkqC9utcUes92xfe1rsjZUw5nJ452H', 'N'),
('CR111', 'C149', '1997-07-28', 'akSWIzQKp9XLse7Prew7Ad9we8g4pik9eqcTvwID6lB33IoMJc3lVxTrdws4L6Xx1fVR2gDWsaKhhVexbpvHR9M8utudEMqmWnGt', 'N'),
('CR112', 'C112', '1997-11-09', 'G1fI2SCOeYlKJ37NZQYlERXdPdE0jIx146sw1XzqKpcaknA0NnLXoHFmI4IlRbp8VwfH7cP77Rrv5xwX1P6G6GsV2zPzSIzuaL4q', 'N'),
('CR113', 'C170', '1997-11-26', 'fzGxJ52w7TuSWsbUUP9QJxKlpKz7XJSjLsA5FWK2sidCwaSpo5ydVU7NNjTJ4jJ8PWoqf9hLTIsA0wwBscTfWA9uLQCOEUo8johu', 'N'),
('CR114', 'C165', '1997-11-21', 'WykHdYC5a4Ob6CmEULkP81oNcekuoG9805OL8MH34lAwJbmF7PAg8uK9I6LZxb7S8nfxb1BVZ2T5YLUwQlFbyF4nMe8NQybTS81s', 'Y'),
('CR115', 'C082', '1997-09-11', 'qrgu4Lls8kN1vSmcJSRaaKzyyHQ8776E1L5CrSscd8o3MqcoH7SGkdc8NUYHJK9pFdAuUN0PEcTZr8E541bL2CB3aLxUVTnG3h2x', 'Y'),
('CR116', 'C142', '1997-01-23', 'Fc6bcpDBcOEZXcn7dI3WDG1JAIzLn85l6qWw1mso8hMokSk7yT9BHyiPiL5NTDDqxdgQDW5ipuTZe3Na9q25fkB5Oj6WgDdJGU07', 'Y'),
('CR117', 'C152', '1997-02-27', 'S4FaOw0Bwq5lZOaMcAyGtvBc3TEGsU2oXEZjxRjVSnm86UCBj2b8oQyIuc1Npg7VVHGkVDMmXDieAktdJBcus2PmjLLtJamC9jq7', 'Y'),
('CR118', 'C142', '1997-07-25', 'vVRra68OWyEN3cMpscFMqug8cYdOKfYKzjAyaxv0SINKLumyDtrZ1b5Fph2U9Y1RSdgIhLuJS97qIojjecRTbdkN020HIlkpg6Lf', 'Y'),
('CR119', 'C012', '1997-05-20', 'oMrIxkHhwuVz7tOs0zZF0Sf1A2fAUwEQYM7BphN48PmDNITMj472KWFAfVCML6Rmetpl881icFInJYEYEiCZndCRWBQ65dOBFZI6', 'Y'),
('CR120', 'C065', '1997-09-03', 'UNHUHXUYUVve9pkrEPaRMaINweFbhhameA1iKP98ibMpgkM6i1yk5e81MhPiobJxl5DiOwkyv48MlFPSiUX1ifFj7WavR7uEHt0z', 'N'),
('CR121', 'C025', '1997-02-04', 'v1RYmT8LDWtx7b9CB4yFYwjcVlzWyLWtEKIOr25Rq5eCyQPj0wbybdZmKGCo0rNhQ5AITLf172XEykr00q3gTz3nD8IuPRKAdAXF', 'N'),
('CR122', 'C045', '1997-10-02', '2kj7u6kTCldGtgqaDUQ5kaTMomaKYLa211ZOFcsYJwZs3bauGQEwv8beqsFE2NPPXIPiXsG7QlJ9ZcK1MTEKuSiRXtWcuBB5w6NE', 'Y'),
('CR123', 'C017', '1997-09-16', 'zt0ZzLd8DcsaaLT3YRjK980az2dJU2Wx8WAz6UIjaa7vKA1tHg7msk1XXjOAzAH1IStzmNe7F9fX5gIXlUqkSj75kw5JtjeAnZnx', 'N'),
('CR124', 'C152', '1997-06-10', '3GNaDoQGGbC1SHhkCqOoXbCNi2qfiTcwx2siQelHQLLWlvZunoDDqsaAzmIkhFCZ9ThMpu3URrA1W5rpxLVHZX2muza33n1KLG3W', 'N'),
('CR125', 'C105', '1997-12-04', 'IAn8C1mWoGozpdlX4rmpUkVW5sow1tGxm2eJPOpucsB7fcGCqwlidQtOdl5bDTqpTd8ZYWVO704CcBdYasD4wWjhAOQoG0jzLC3r', 'N'),
('CR126', 'C152', '1997-04-30', 'ELqVY48KLkzrZHd70oRxdZSqB2rM0VeeyzF1eH7EAvY3zgpzD3QYx6Pax83btnTGb7wUmNwyHQb7E3ti6RbcX48tUHdbpNZEqXu6', 'Y'),
('CR127', 'C049', '1997-08-01', '7RejeiS0XpYybYZmjOJ4CQLGoCOIjvwVQeHvz77GLDJ65d1sOYjjrIh8gEy7OMNeRxGBZTAJMtjWHbcftXp1Zu1Jh8kRv5Yr1veh', 'Y'),
('CR128', 'C194', '1997-12-12', 'NQXEntR3x5SsEJkrcKqU7lhnjNfsw3T21pCTlV22OSVEVDiIlwXEmwhY8X3xFLYIRbvImHRfl8780yPNHTCVEFhsVkMP4MYFwU9v', 'Y'),
('CR129', 'C184', '1997-05-15', 'ycUZsvdfaoSHcWCDnkkjgYoRrbdXDgF7Vnn5wEhpTk9ggSxdjsUmL21b0UjVThjK4YGQi4Vux5MyzwaKj7V7GXpA8eKUaKkC8hRG', 'Y'),
('CR130', 'C058', '0000-00-00', 'mKbvEHcZy0U6VXhhbb929TGWuIGJlTCgtWPP1xaQ1zdqGk33YYmL3jMmhnFzmoB3bTmCw2603TRPx27rBKx5YyAw7yYDYDvOOhYx', 'N'),
('CR131', 'C151', '1997-09-17', 'qBEeywu0blGrZpC3Npecq3heuFrJ3m7AEoNlQFGDNldJapm9TetiZ18TZF4UWbtXhJWzQ5ksDkzyP5eKTHgVthiZLtt2xXBuVQNC', 'Y'),
('CR132', 'C028', '1997-12-23', 'sMcAXFZBGDMZDGjwTggPNdMXmZdTaYUq8M1MKjE9Hv3RUZhXNkl4KTCg7sjLwPe7QxwWga4BUdZaHvtQu1GYO4pNNlRIdzSeU4Zw', 'Y'),
('CR133', 'C166', '1997-05-06', 'ZvaDcjfB3bJUMYvYzyJviXpLJ53apNHpIpAFCJcHKS2zkfJGXqLBBNnLPPf5hzscXuKav1GRQdYNdmCQJW3ipuHOavH9PaQWa5O1', 'N'),
('CR134', 'C021', '1997-07-03', 'LYpAJGM5sSCjbXwuY6mK9mNzRLOPonQ8LCjh34WvzXmSdXXJ0qTy48Vp3KiVNBQ4qkjSVSu7xK3L9xe9Cpfs7a11M3v1TzCoimMX', 'N'),
('CR135', 'C011', '1997-06-15', 'VCpWvsL7fQsHmUhUFXIpTuoG1t8IqEzekxkHAkmgNSHhp9rsEkoEK8eQ1knM5vx7UDF5CCUohD83MCI4q1yfj0prxG9v2NneU4jg', 'Y'),
('CR136', 'C088', '1997-04-15', 'DaAvaFz9KbJK87mTaSsC4SzcsYuCaEjq8O5biybyOFx54ZQr9pBxL0F3YvIoUmMxOEa2bCj05RN04lv0vbCtXkOTPYpb0nIGD2Ol', 'Y'),
('CR137', 'C181', '1997-08-29', 'VWrZKSMjy33nwQsYUxDTncUOBlyL9tnLSHwyKBVQva2ozDpcFWuAG5VH2Xpkc9K6Xhey01OadPjaaEL4aDK5o3NRwcjUXdSuHqPv', 'N'),
('CR138', 'C074', '1997-10-13', 'Sv5ByzPaJMaTcoLAP6xRTSYLe1aFWBxCCSwfHhpDWhTR865h7bHUf9jv6rXe2Ybt9Fa5yYMhKGvMAs6M0i5qriWuOrI7uOm5lLpn', 'Y'),
('CR139', 'C052', '1997-11-02', 'byYqFLc4wweL9X8GXd3eioK26poQ3dfOGKhjHjnMi7FV9MQK6E6UaRHoQ2PoMd7RaqzuZVr9WTDGhxQpQunMaUtDUXiProeyIytR', 'Y'),
('CR140', 'C169', '1997-07-13', 'MC6FQNhBUPro6eys9NR9JWUf6elAdMT1HsdnVhQUhBmR8QM8upmItCoxAE4Opzvq1oDdWlzEjUIYsZ9PNtdcs9Vvx2PhrtdmJn3D', 'Y'),
('CR141', 'C031', '0000-00-00', 'Nd9zhSch4D9v87oKLbqqbXipNOgyvvwUYOJYlr8wJmxp3wv7dzzySdMg21zyKJhKHsbCdvg5vvlAs5m3Nkm15Aj9NKvnupdKk4qM', 'Y'),
('CR142', 'C083', '1997-01-31', '0QsxKDUJ9GldzmK91lPney5HKGUGccpaVk8jQ2ruVCQily2VMYtemBXHe93Pnk7UYkz2OhVMKcuiCKxmjXpBypb2tWC8WLezqq5Z', 'Y'),
('CR143', 'C142', '1997-06-02', 'WL5gEJjqrnMuTnrT4TVz2a6V35gZ3opUtFq5RCuleJfP2JGJaUg6EAefhe6Cd0R3l2VrMGQ5hS8YyK56n20SDzv4eeEKuN8KedKV', 'N'),
('CR144', 'C102', '1997-06-10', 'wvD8Z9t0UbT6slAPUrKnYoNkyGezxOx1IkPgJ5EJ0Xk0m3JewqHJFYrmQturVuV7QNFIGSdsYN4riR3sM6ziW67VyFVdkMIHHylX', 'N'),
('CR145', 'C179', '0000-00-00', 'NIXdwyYJqRoxd6OnNoXrJRCKw0FNJoyluXSsu1iCW9DvnYreW9dEeffpnDtRbAi1EQYEUHHY1OqCqwUab0myljXuoJuO0RW5lBZA', 'Y'),
('CR146', 'C078', '1997-11-08', 'XNvO8NWTojtqzgAXU6iL3YcBTJtud8W8CAkJvDjArLqum6ZA9aUjeoGZJCHz5yJX3ApVhvbulb8i1sMJuVvxGCUStRfJEhotDQdy', 'N'),
('CR147', 'C088', '1997-03-02', '7JyDj8FKG0NfbTf2C70MOJr4JDQnOU7k9zMo4LuQo4bBnTbIPVWAwAXaakM9413CFl38y4GKKS0IBzew193d7fbWzLzJvl9gJZFz', 'Y'),
('CR148', 'C058', '1997-11-03', '3k3lbPFNr6cIajGgYGXS1PNBhbGYmJpvDmSbck1Biv9aSnEjUjoDkjTxDeBGFB0H71dBjauQIkJvpmsRbBpCmOJsO7L5VNMkIbgS', 'Y'),
('CR149', 'C086', '1997-02-12', 'm7Df0FnKFWElRx6SnnwE21Es9ofk37jEt2ijoL1VLFSkhfpS1aGax5bzHjhX2tdfc3LNXZmX4Ys56DjfXxkSVY8pTbQiyh3T9zhP', 'Y'),
('CR150', 'C103', '1997-03-03', 'bqIelAhRX8ENzHDfARmrpelNOl949qarwap3Laf6C7cXN3DD7HrSh5UeVmzYKDrfbDki5DXBbD2PYrmhuzmy2bxvstZ3wQaM8Vr3', 'Y'),
('CR151', 'C072', '1997-12-10', 'jCrEJEHY2pNcO5dXyJ1snOv7BPOigIH61KBUrJa0R4TXFuViCQOPOMn9P4g6kXoHhIDYLwnvHwupIgGIrLpKuTUx4PTixIJknl4g', 'Y'),
('CR152', 'C043', '1997-01-12', 'iTkTAY4DZPgvqYEe6QUvZhrDpSkGT70VsCnUk4FUP3ZfXYNFUs1cPxajFzHov45G6NU8co9vbSIxMV6CsUyy6XHcYx8mkZPTSHBC', 'N'),
('CR153', 'C134', '1997-05-04', 'hwLY85bikqwXxoMDTz4Yyuw7rr2whtgQwbUyskxf4ypMurWlT4b9bx2uOM4OXM2GBB0qDiSO4CDBOry0CBezl5FJKolZ0SW7MMev', 'N'),
('CR154', 'C033', '1997-08-13', 'vTKgoMlVESrFkMF96s7er0vfy6m67zFtLEgY16G2w8sgctmyxInDndN3JpclVylq73q6VPtmZQWlUs46ttI6y6OJyZbYSbTNbLGX', 'Y'),
('CR155', 'C103', '1997-08-06', 'l8r5Eo9eAO54ntuuWCBlhGcPH3LHb20inRDUQAclPMkVOTn66NTMbKDbVzxAuma5vMErmQ2AOUJljGMf9OqagQmI2ajxhlQdCUfs', 'Y'),
('CR156', 'C079', '1997-05-31', 'gbIHs2FYDQ5lz0Ir08ojeEnMlcvVyvNa56qs5wziGYBe11MzFJhRyLaGT3f6cK9QHxaFHKBIhjXPpN49irKmS5xHVRtQNSzVtKPf', 'Y'),
('CR157', 'C050', '1997-04-26', '828ppO0V8Bmeznq1kP2ehXjbPa6T3ksSIkrFkV5Bw4B8inG1yYKOqX0j9L43MgcNucPF2fQRJJ5FOV9yyRKBcDeyD2NprvhbSaIj', 'N'),
('CR158', 'C098', '1997-07-05', 'T2pUaSAXsEkGAFnJeMCVFR2BHy3OZz3d9SOOFadRDG11DcFFiqRewJPUwwd3gRQJhCZG7K4FWixZqmlngDpaVqpLtW6XH3eZx4N4', 'Y'),
('CR159', 'C016', '1997-02-28', '8IzLRcj7ivh023kAysV0bpceclpdLDylWEx6W90yJRegMimEtPRFzqPXqS7hJwGvPjpS3K8CNKCN9QGvJae1jQ5FyEs5ZgiDPtq4', 'N'),
('CR160', 'C177', '1997-04-17', 'By2ClbhIK2I4EQOB1s0HhCACbE1D7Ygsvv50YxwpW2TekY1kAZ676n7f47O3iQzRc9U50perpZl8iHHhUnhJaw2RNpQBINomz2UK', 'Y'),
('CR161', 'C170', '1997-01-13', 'XjvWZqkzTJvijuef7vMcKn2UFdtT21eSaHQPanrZI57tsmO8nb40wrxzhqgvG5oQGptGj98Qm3nxHZWJjLpS16qitcmKhPNpGOKb', 'N'),
('CR162', 'C080', '1997-02-03', 'OcYvFPKGaMCLH8nOSEWkuTUWKaHlvzUaAXU92ZDaRdgnfYrzrlV3cd2A3MkGozACmuS7EhxbqW5CnglKJXG1R5D3SNkidORzcOwk', 'N'),
('CR163', 'C187', '1997-08-15', 'rjlhcAoVcewXwBjErvcx2J3NWfM31FS72TSM2J74p8nt1AcoM5FQPbSmVVqyQQmIWAUw3f8HFk49QEmNPFOf37RfHr7GLeMGwpUR', 'Y'),
('CR164', 'C098', '1997-12-14', 'ebaSQZWdxLyPdKc1JMiCnTkbSgJ86jgqcK1i1Gijwt3VK2WL1xNS0wpzSIgKsKIeR48fQVsmmAwHCFrQRFbrnGjH5f2Pa6Y0fp5I', 'N'),
('CR165', 'C138', '1997-09-12', 'F1Sagmz16FtQmnM3AsnYmz1Vve6dL2l55efnBAa6YRZb0NQX7wJq6rBotsWyF0bOZcoBoE056HKCjLZWeV9bX2NP98LUPNdWjUn2', 'N'),
('CR166', 'C109', '1997-06-01', '9RObY4F65btuSa0pGE3p7Hneg9x0vBLDpFfekE3QF79kx3V3cHdaCJzOiziSvF29HVd3DxLql9PEiaN4EUMk6p9IBEVtoYDMtTJh', 'Y'),
('CR167', 'C184', '1997-08-31', 'zjTYSMPIUVxSTaMjWhkfp64XuHkGHT3hGezKJUYfECZHH4XZurI4NsEQT42xD5gL2Chiq8gEQKFC1854oj2b7XsEJRfKFOpnVN0r', 'Y'),
('CR168', 'C066', '1997-05-27', 'F8twtccHW4Q7SZF1f7jVshMIEujrYeV1ErTnu8GlndVTquFgBP5JYyWCVUBaS6bzDOaTDjHqMfrTBwRyCWTA3zE6DVyLo6d7761K', 'N'),
('CR169', 'C194', '1997-08-21', 'qyCGWljZSwgOSDeDP03SoqHtc67qDPg6BedauuvKM0FyrYhE09PM3rCaudbLN1rtgQ6SZrnEUNIpfc6JvTfObkOwaLSnGhBK9Xf6', 'N'),
('CR170', 'C024', '1997-07-28', 'tZqy5QwueS8BO3F2PN8uFaBuE6lBfWyU8qhN8tTeo7S5rqjr6uAkW9szFKWnmDEVEVjJkIou8389ZXkcdKy9Xq41IfGjPNkwFx5u', 'Y'),
('CR171', 'C087', '1997-07-12', 'w40cOQjMoLOFFrqHq92CqDMhno1wk4noR1OXosNEixWw8dKadJo2O0U23X1t1YTileu0RrZrXMIDJczyWJFcMd3vDrcmEmByqORX', 'N'),
('CR172', 'C093', '1997-05-26', 'TE0lUQfIBhGOz6uoW1BsIFAMqhEjePTz25jZRgD6ADPcLt4M0NHCVDAoMPwiIiE8Y7dfccSOuUQ892QisAjAO5qMIk0jQVXvMat2', 'N'),
('CR173', 'C101', '1997-06-15', 'EZksKvFWGtvISzczJvSs3qaNONLoow6oZTX1wr04S8ks8M1ovqRjZgDZ6xMAx58eA6VSJyfXMKc0k6ee8G11jbYh2udcuGEvKTMy', 'N'),
('CR174', 'C006', '1997-01-26', 'phznxAOHX4i2SyLPqvkbpLJfQQNeKXtbcBX5MtqFyvvEzsfOIx2KKBxW3hs2B3mna8GE9eR6rPoK1Wc86wmWIm7X6uXK3VeiNhFK', 'Y'),
('CR175', 'C070', '1997-06-14', 'LDwchduOPGFZaBpSUuWZoohosJnwkF4vPHCJFmxiwUvFMTZ6mmCRlGaFGtBpbycrtTiA113s8GEX3Gz5HEEftTTBOwX5VFHxWi5M', 'N'),
('CR176', 'C140', '1997-01-28', 'crrtgKNObfiKmhlzclJnHeYxHIhhZDebjn3PQPv4mNW15xRxHlYuEwJ7r1pwFTUjlSYxMWpw9ZK1pVy5KskanJFUOgXWeqbxdIQ7', 'Y'),
('CR177', 'C010', '1997-10-08', 'v4YVBM0hkaspBYrKAhqF3rVm2VekTVrKrmLcwbdGCDIz8x2Okc7kndJSILfqabLllmwNF4q8CDPwDbS6bo8dF6o3wZekJCDvrEwD', 'Y'),
('CR178', 'C173', '1997-11-08', 'n8JJvN4BDl8JfHX4ce5XtZVgHmE56mQldvdkJ3jciQsrDvKK8rThaLFvPJXwAI0PZhQ364QMYenTvgadizgvCiPjQyydhPNTRDzo', 'Y'),
('CR179', 'C099', '1997-02-05', 'PyLFKESkzak7M6ttgJ2u9hNkPJT5ku4ILAJPz7SfoZL32za54qKv31CR52XLZoh299eIwgOi88Ul6deP1uS3XbZgqBUItC6QF1gJ', 'N'),
('CR180', 'C080', '1997-04-23', 'oLTqWsAHj776MIYfJInFT269O0yDTYTA6BVvYrFUHNYzyNMrwq88vqcxmB31Qrr9wK9QkPvf7ZvBA02UwJR4iGHU6IscCbhUlH5R', 'Y'),
('CR181', 'C002', '1997-12-20', 'YjLfWoJeZz4fyzjB3gpAcS7MiazQqDK5mtZh6ucGfPXcFPrjfRokmOW8P5LlHLCo6GHVYWKrrWPb7uBw2PO9o4OScZBPWacETCLy', 'Y'),
('CR182', 'C019', '1997-10-18', 'KvJ0jjy6LiHKNgWxY9ZwLTi2NJGBoOttl2E9PxJpPoSZsPhpPBy5RB3myCSWSValdOshLvaJZMyTthA6hABogaek1RntQXmiNrpd', 'N'),
('CR183', 'C083', '1997-04-03', 'ar9pqRkAE2d8EnsPs9aL2T0JLyGuakEe5Tvs1yKzfVcWs1e9ECO25jkQSRArfXn6o9bqrigQHJWosSwSdnRNR2yAqAS6X7STpfqX', 'Y'),
('CR184', 'C171', '1997-08-21', 'pWFFxw5Gqns2M6983SycpDo25ThdD0zhwNglDILaMnDCIyi22uIKu1Row0ddIraCQ1pGGtrO4uEgdGTsxJNrFJif7Rfw94Q4hJ7q', 'Y'),
('CR185', 'C040', '1997-03-19', 'O0V6xWoWV89abB2D5dpg58yym77RmQPyhpYmAjrD3JdkeroXEUOIu5DL5S9YgVBI7s6NKasmlKMliAMihRVQle6eAnPYa1F8tMqW', 'N'),
('CR186', 'C129', '1997-02-16', 'wuo3uHDJ8SmTXU2sfaXOOHYBjFh4pKJAIZPUbPOBmS0NPRZz4LVM3mFPZqg260700oHyoM5yDHQvnCx7ZBHVy9sXfYLjDRVOaBoi', 'Y'),
('CR187', 'C185', '1997-10-04', 'HMhlMBiU4b0i3egeYVLR0uMoirjDhFZOvDbbAH1ZQvGv7jhmcj4dhmOmnTypFFtWIrpeBxvT1StSHRdaw0FbooMmcU6PtUsRk5B3', 'Y'),
('CR188', 'C123', '1997-06-16', 'V2zupin9dOzyMrLjZ4WVnPkVPVV8JDY3VqOUtXaz7P4vuWbXrTxIQvZwQZ4ivgTPJQjWQsvk1BaITiDthyiRf378s0DShY9Yl5CF', 'N'),
('CR189', 'C132', '1997-04-06', 'ZPtTU7x6hIKJxt7O1wf4fZUAmEthtCyqm0PNj1DznbwCT7kVZuRlILtPivYy8bx8YumKliplNqOc0FpKTRRCF28JiibLoJWbElbb', 'Y'),
('CR190', 'C061', '1997-05-07', 'K3PjQlcLbfo5dGEeCi6mDe8AcOsdXgCEDp88N8VJrlzf0q1cDjahNGzWz1dvk1YAhmAgebtJeqkMm0dNKMnFf9NX7Wqh0eVLSRmp', 'Y'),
('CR191', 'C003', '1997-02-21', 'lCmrJz39xouKIVyCfyUaLDlz8FUEzHWP7hZgxZRdOOWYBMni49esVj2vj21XB67fA1uZVMv0TzqTWn5IMizCeJcC6SaLPLTUxqkQ', 'Y'),
('CR192', 'C101', '0000-00-00', '4P2jhLHCVcU4Wl0iHWeWJ49wWovVdGlJXOdORpXIgPFhggut6xVwsLr0BeWWQp2K2MeR5sdFB26yzoSQy2lKkYL4AZtFY2uWIvHy', 'N'),
('CR193', 'C135', '1997-09-19', 'SQ3RZiY0QQxOr9vWHKRNQKmAWrbkHTToQwLxLaYc8zHwlaU3aw4aOuu5RovtmWBDzABlD0mxbFzkMBK18g7NEhxSyUQEXINeTU1E', 'N'),
('CR194', 'C158', '1997-09-03', 'ty6UaAYx4Jmt3oQyxSIgNt9QeRDu4MUWdnapIVzyKE0gmVltH7by4lZDWZq7gKgGPVWanBe1s3u4EQVfDF5c9rrcp1ihoRy6vzbk', 'Y'),
('CR195', 'C035', '1997-07-29', 'jVvTnv5UjrY7hDTWki5mJ5UrWtsMrnorrV1LKfBMMJbFJxZqP1micpWsT6Jd4yRmpgYzhg3HYiEvN7ESuR5hZE9BFZ19T6SOHwra', 'Y'),
('CR196', 'C188', '1997-04-12', 'ZUzwnlt3LsbzUKstFYOsZ5LpQzbS2vvC4gc02TL7Bx3ID9bnNRBaH4rJRxEVK8b33ptmpxWe2QWR50N01QQWcZGFFewusiXZgt86', 'N'),
('CR197', 'C131', '1997-11-09', 'I77Wuyh0wN2ohqnq1a8zIk71PMjDyQDeY7FHb2Dz1oy0AsMMQXsSc5BruY7Qti3oCDLI3r4TEyono6KJgGfY1T3UIZDe6IkUB58t', 'N'),
('CR198', 'C074', '0000-00-00', 'eHyHaTmR8lqyB85oeWTvhX3anw9f8goFSOdN7nMWfOOtME5MOUnZI6Z8Wrt9LQXUBktVyuinK8NCjBiFPosmBSNoQ9v6mrWyveYu', 'N'),
('CR199', 'C122', '1997-07-16', '0kELzTAq6G4jFAXS9KA04yTBnpAxvCLuEERly06KyEtM7nBRWLoiENedYN2pbYjiMiUZQkKUcqPz8JHx2uHrKz1SouPcGKX6O83F', 'N'),
('CR200', 'C174', '1997-04-11', '8FPGrM7A7YNcMquk8Wxy4EE94C5wi9Deg47PI3fXSQBVWWeczDydq56lP2xeAWSbpovPeAniDJ0m6S0PwHr9VHp9JndToRNgdJqM', 'N');

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
  `sPassword` varchar(100) NOT NULL, -- 賣方密碼: 加密後可能加長故取60
  `sAddress` varchar(60) default NULL, -- 賣方地址
  `sPhone` varchar(24) default NULL, -- 賣方電話
  `sMail` varchar(60) default NULL, -- 賣方信箱
  `sCountry` varchar(20) default NULL, -- 賣方國家
  PRIMARY KEY  (`sellerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 預設儲存引擎: InnoDB(after php5.5)

-- add dummy datas:
INSERT INTO `sellers` VALUES
 ('S001','星巴克','sel01ler','$2y$10$veXmDFN1rExJQdGUbTkPiOEc0lUq5H0N0xIuMNDCQa5vap1U3sPHa','my_dummy_adrs01','(99)0000-0001','s001@gmail.com','美國')
,('S002','露易莎咖啡','sel02ler','$2y$10$oBCfgBb.BzmRrMAruZQIP.kZWH/jn9D.Rbmr8m3WIIwkE7dJ9i4du','my_dummy_adrs02','(99)0000-0002','s002@gmail.com','台灣')
,('S003','伯朗咖啡','sel03ler','$2y$10$NNrlO66BPXrK/q942nKR7.9SpKEgYp2W3GaRs75I3v.JDlPnDNAQS','my_dummy_adrs03','(99)0000-0003','s003@gmail.com','台灣')
,('S004','上島咖啡','sel04ler','$2y$10$HhsDVl94qKOFtK1l5aAj7OAhapz6ovvedlBXehTgsKc5zvWY3ftg6','my_dummy_adrs04','(99)0000-0004','s004@gmail.com','日本')
,('S005','小樽咖啡','sel05ler','$2y$10$J0r1yBjU6z1cWVzuftoPzePPsU17ibJBawdgB.R4hUQ0ggP2xBQhm','my_dummy_adrs05','(99)0000-0005','s005@gmail.com','日本')
,('S006','資策會咖啡','sel06ler','$2y$10$VLBi1ja7JcXYV1qGfhVdU.ZXnxi1mGbFH9j/ZH8NHGm80G5migqxK','my_dummy_adrs06','(99)0000-0006','s006@gmail.com','台灣');

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
  `startDate` date default NULL, -- 開始日期:
  `overDate` date default NULL, -- 結束日期:
  
  PRIMARY KEY  (`disID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 預設儲存引擎: InnoDB(after php5.5)

-- add dummy datas:
INSERT INTO `discounts` VALUES
 ('D001','曼特寧優惠','星巴克公司現時曼特寧咖啡75折','S001','0.75','2020-03-05', '2020-03-08')
,('D002','曼特寧優惠','露易莎咖啡4月3日起曼特寧咖啡75折','S002','0.75','2020-04-03', '2020-04-06')
,('D003','拿鐵優惠','伯朗咖啡現時拿鐵咖啡85折','S003','0.85','2020-03-05', '2020-03-08')
,('D004','瑪奇朵優惠','上島咖啡6月6日起瑪奇朵咖啡85折','S004','0.85','2020-06-06', '2020-06-09')
,('D005','瑪奇朵優惠','小樽咖啡現時瑪奇朵咖啡85折','S005','0.85','2020-03-05', '2020-03-08')
,('D006','瑪奇朵優惠','露易莎咖啡4月3日起瑪奇朵咖啡75折','S002','0.75','2020-04-03', '2020-04-06')
,('D007','瑪奇朵優惠','伯朗咖啡現時瑪奇朵咖啡85折','S003','0.85','2020-03-05', '2020-03-08')
,('D008','拿鐵優惠','上島咖啡6月6日起拿鐵咖啡85折','S004','0.85','2020-06-06', '2020-06-09')
,('D009','拿鐵優惠','星巴克公司現時拿鐵咖啡85折','S001','0.85','2020-03-05', '2020-03-08')
,('D010','曼特寧優惠','露易莎咖啡4月3日起曼特寧咖啡75折','S002','0.75','2020-04-03', '2020-04-06')
,('D011','曼特寧優惠','伯朗咖啡現時曼特寧咖啡85折','S003','0.85','2020-03-05', '2020-03-08')
,('D012','冰滴咖啡優惠','上島咖啡6月6日起冰滴咖啡85折','S004','0.85','2020-06-06', '2020-06-09')
,('D013','冰滴咖啡優惠','小樽咖啡現時冰滴咖啡85折','S005','0.85','2020-03-05', '2020-03-08')
,('D014','冰滴咖啡優惠','上島咖啡6月6日起冰滴咖啡85折','S004','0.85','2020-06-06', '2020-06-09')
,('D015','冰摩卡優惠','小樽咖啡現時冰摩卡咖啡85折','S005','0.85','2020-03-05', '2020-03-08')
,('D016','冰摩卡優惠','露易莎咖啡4月3日起冰摩卡咖啡75折','S002','0.75','2020-04-03', '2020-04-06')
,('D017','冰摩卡優惠','星巴克公司現時冰摩卡咖啡85折','S001','0.85','2020-03-05', '2020-03-08')
,('D018','利比瑞卡優惠','上島咖啡6月6日起利比瑞卡咖啡85折','S004','0.85','2020-06-06', '2020-06-09')
,('D019','利比瑞卡優惠','小樽咖啡現時利比瑞卡咖啡85折','S005','0.85','2020-03-05', '2020-03-08')
,('D020','利比瑞卡優惠','資策會咖啡現時利比瑞卡咖啡85折','S006','0.85','2020-03-05', '2020-03-08');

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