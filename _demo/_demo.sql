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
  `cPassword` varchar(100) NOT NULL, -- 買家密碼: 加密後可能加長故取60
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
  `aPassword` varchar(100) NOT NULL unique, -- 管理員密碼: 加密後可能加長故取60
  `aDepartment` varchar(30) default NULL, -- 管理員部門
  `aTitle` varchar(30) default NULL, -- 管理員職稱
  PRIMARY KEY  (`adminID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 預設儲存引擎: InnoDB(after php5.5)

-- add dummy datas:
INSERT INTO `admins` VALUES
 ('A001','大名01','adm01','$2y$10$uKV2BCDw.Vpg9SvkO8IgA.0owhUVHSxHXasoeVUFlrs7AWE2y3xjG','部門01','部長')
,('A002','大名02','adm02','$2y$10$7BYWnH3yp5WOEGc/hAoOt.t2pJtJrJxoUgRswUe7FztgTq711HoS.','部門02','部長')
,('A003','大名03','adm03','$2y$10$anNz3OJPg68IQVibkSyvZuzmoLMv.cQjtqWpRcjzxStCLYngQzvOe','部門03','部長');

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
 ,('I003','休館通知','為防治武漢肺炎擴散，資策會咖啡敦南店將於4月7日至4月9日進行消毒作業暫停營業','S006')
 ,('I004','新品上市','上島咖啡深焙咖啡豆將於3月7日準時開賣','S004')
 ,('I005','講座通知','小樽咖啡將於4月7日於國家圖書館舉行咖啡產地講座','S005')
 ,('I006','夥伴招募','星巴克公司將於6月14日舉行人才招募，歡迎有興趣的民眾加入我們的行列','S001')
,('I007','夥伴招募','露易莎咖啡將於7月24日舉行人才招募，歡迎有興趣的民眾加入我們的行列','S002')
,('I008','夥伴招募','伯朗咖啡將於7月28日舉行人才招募，歡迎有興趣的民眾加入我們的行列','S003')
,('I009','試喝會','上島咖啡深焙咖啡將於6月5日舉行試喝會','S004')
,('I010','講座通知','小樽咖啡將於8月8日於國家圖書館舉行咖啡產地講座','S005')
,('I011','試喝會','為獎勵學員辛勞學習，資策會咖啡將5月5日舉行試喝會','S006')
,('I012','新品上市','星巴克公司冰滴咖啡將於4月4日準時開賣','S001')
,('I013','新品上市','伯朗冰滴咖啡將於4月4日準時開賣','S003')
,('I014','新品上市','露易莎冰滴咖啡將於4月4日準時開賣','S002')
,('I015','講座通知','星巴克公司將於6月7日於國家圖書館舉行咖啡產地講座','S001')
,('I016','儲備幹部招募','星巴克公司將於6月14日舉行幹部招募，歡迎優秀人才加入本公司','S001')
,('I017','儲備幹部招募','露易莎咖啡將於6月24日舉行幹部招募，歡迎優秀人才加入本公司','S002')
,('I018','儲備幹部招募','上島咖啡將於7月24日舉行幹部招募，歡迎優秀人才加入本公司','S004')
,('I019','試喝會','伯朗咖啡深焙咖啡將於6月5日舉行試喝會','S003')
,('I020','講座通知','上島咖啡將於9月8日於國家圖書館舉行咖啡產地講座','S004')
,('I021','講座通知','資策會咖啡將於6月8日於國家圖書館舉行咖啡產地講座','S006')
,('I022','咖啡節','露易莎咖啡為慶祝咖啡節來臨，全館曼特寧買2送1','S002')
,('I023','咖啡節','伯朗咖啡為慶祝咖啡節來臨，全館曼特寧買2送1','S003')
,('I024','咖啡節','資策會咖啡為慶祝咖啡節來臨，全館曼特寧買2送1','S006')
,('I025','咖啡節','小樽咖啡為慶祝咖啡節來臨，全館曼特寧買2送1','S005')
,('I026','咖啡節','上島咖啡為慶祝咖啡節來臨，全館曼特寧買2送1','S004')
,('I027','新品上市','上島咖啡特調瑪奇朵將於3月6日準時開賣','S004')
,('I028','新品上市','小樽咖啡特調瑪奇朵將於3月6日準時開賣','S005')
,('I029','新品上市','資策會咖啡特調瑪奇朵將於3月6日準時開賣','S006')
,('I030','休館通知','為防治武漢肺炎擴散，小樽咖啡敦南店將於4月7日至4月9日進行消毒作業暫停營業','S005')
,('I031','休館通知','為防治武漢肺炎擴散，上島咖啡敦南店將於4月7日至4月9日進行消毒作業暫停營業','S004')
,('I032','休館通知','為防治武漢肺炎擴散，伯朗咖啡敦南店將於4月7日至4月9日進行消毒作業暫停營業','S003')
,('I033','休館通知','為防治武漢肺炎擴散，露易莎咖啡敦南店將於4月7日至4月9日進行消毒作業暫停營業','S002')
,('I034','休館通知','為防治武漢肺炎擴散，星巴克公司敦南店將於4月7日至4月9日進行消毒作業暫停營業','S001')
,('I035','新品上市','星巴克公司深焙咖啡豆將於3月7日準時開賣','S001')
,('I036','新品上市','露易莎咖啡深焙咖啡豆將於3月7日準時開賣','S002')
,('I037','新品上市','伯朗咖啡深焙咖啡豆將於3月7日準時開賣','S003')
,('I038','新品上市','小樽咖啡深焙咖啡豆將於3月7日準時開賣','S005')
,('I039','新品上市','資策會咖啡深焙咖啡豆將於3月7日準時開賣','S006')
,('I040','講座通知','資策會咖啡將於4月7日於國家圖書館舉行咖啡產地講座','S006')
,('I041','講座通知','上島咖啡將於4月7日於國家圖書館舉行咖啡產地講座','S004')
,('I042','講座通知','伯朗咖啡將於4月7日於國家圖書館舉行咖啡產地講座','S003')
,('I043','講座通知','露易莎咖啡將於4月7日於國家圖書館舉行咖啡產地講座','S002')
,('I044','講座通知','星巴克公司將於4月7日於國家圖書館舉行咖啡產地講座','S001')
,('I045','夥伴招募','上島咖啡將於6月14日舉行人才招募，歡迎有興趣的民眾加入我們的行列','S004')
,('I046','夥伴招募','小樽咖啡將於7月24日舉行人才招募，歡迎有興趣的民眾加入我們的行列','S005')
,('I047','夥伴招募','資策會咖啡將於7月28日舉行人才招募，歡迎有興趣的民眾加入我們的行列','S006')
,('I048','試喝會','星巴克公司深焙咖啡將於6月5日舉行試喝會','S001')
,('I049','試喝會','露易莎咖啡將5月5日舉行試喝會','S002')
,('I050','試喝會','小樽咖啡深焙咖啡將於6月5日舉行試喝會','S005')
,('I051','講座通知','露易莎咖啡將於9月8日於國家圖書館舉行咖啡產地講座','S002')
,('I052','講座通知','伯朗咖啡將於6月8日於國家圖書館舉行咖啡產地講座','S003')
,('I053','新品上市','上島冰滴咖啡將於4月4日準時開賣','S004')
,('I054','新品上市','小樽冰滴咖啡將於4月4日準時開賣','S005')
,('I055','新品上市','資策會冰滴咖啡將於4月4日準時開賣','S006')
,('I056','儲備幹部招募','伯朗咖啡將於6月14日舉行幹部招募，歡迎優秀人才加入本公司','S003')
,('I057','儲備幹部招募','上島咖啡將於6月24日舉行幹部招募，歡迎優秀人才加入本公司','S005')
,('I058','儲備幹部招募','小樽咖啡將於7月24日舉行幹部招募，歡迎優秀人才加入本公司','S006')
,('I059','新品上市','星巴克公司特調瑪奇朵將於3月6日準時開賣','S001')
,('I060','新品上市','伯朗咖啡特調瑪奇朵將於3月6日準時開賣','S003');


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
 ('D001','咖啡節優惠','星巴克公司3月5日起曼特寧與拿鐵咖啡75折','S001','0.75','2020-03-05', '2020-03-12')
,('D002','咖啡節優惠','露易莎咖啡3月5日起曼特寧與拿鐵咖啡75折','S002','0.75','2020-03-05', '2020-03-12')
,('D003','咖啡節優惠','伯朗咖啡3月5日起曼特寧與拿鐵咖啡85折','S003','0.85','2020-03-05', '2020-03-12')
,('D004','咖啡節優惠','上島咖啡3月5日起曼特寧與拿鐵咖啡85折','S004','0.85','2020-03-05', '2020-03-12')
,('D005','咖啡節優惠','小樽咖啡3月5日起曼特寧與拿鐵咖啡85折','S005','0.85','2020-03-05', '2020-03-12')
,('D006','咖啡節優惠','資策會咖啡3月5日起曼特寧與拿鐵咖啡75折','S006','0.75','2020-03-05', '2020-03-12')
,('D007','感謝祭優惠','星巴克公司4月3日起瑪奇朵與拿鐵咖啡85折','S001','0.85','2020-04-03', '2020-04-10')
,('D008','感謝祭優惠','露易莎咖啡4月3日起瑪奇朵與拿鐵咖啡85折','S002','0.85','2020-04-03', '2020-04-10')
,('D009','感謝祭優惠','伯朗咖啡4月3日起瑪奇朵與拿鐵咖啡85折','S003','0.85','2020-04-03', '2020-04-10')
,('D010','感謝祭優惠','上島咖啡4月3日起瑪奇朵與拿鐵咖啡75折','S004','0.75','2020-04-03', '2020-04-10')
,('D011','感謝祭優惠','小樽咖啡4月3日起瑪奇朵與拿鐵咖啡85折','S005','0.85','2020-04-03', '2020-04-10')
,('D012','感謝祭優惠','資策會咖啡4月3日起冰瑪奇朵與拿鐵咖啡85折','S006','0.85','2020-04-03', '2020-04-10')
,('D013','母親節優惠','星巴克公司5月10日瑪奇朵與冰滴咖啡85折','S001','0.85','2020-05-10', '2020-05-17')
,('D014','母親節優惠','露易莎咖啡5月10日起瑪奇朵與冰滴咖啡85折','S002','0.85','2020-05-10', '2020-05-17')
,('D015','母親節優惠','伯朗咖啡5月10日起瑪奇朵與冰滴咖啡85折','S003','0.85','2020-05-10', '2020-05-17')
,('D016','母親節優惠','上島咖啡5月10日起瑪奇朵與冰滴咖啡75折','S004','0.75','2020-05-10', '2020-05-17')
,('D017','母親節優惠','小樽咖啡5月10日起瑪奇朵與冰滴咖啡85折','S005','0.85','2020-05-10', '2020-05-17')
,('D018','母親節優惠','資策會咖啡5月10日起瑪奇朵與冰滴咖啡85折','S006','0.85','2020-05-10', '2020-05-17')
,('D019','新品優惠','星巴克公司6月8日起利比瑞卡咖啡85折','S001','0.85','2020-06-08', '2020-06-15')
,('D020','新品優惠','露易莎咖啡6月8日起利比瑞卡咖啡85折','S002','0.85','2020-06-08', '2020-06-15')
,('D021','新品優惠','伯朗咖啡6月8日起利比瑞卡咖啡85折','S003','0.85','2020-06-08', '2020-06-15')
,('D022','新品優惠','上島咖啡6月8日起利比瑞卡咖啡85折','S004','0.85','2020-06-08', '2020-06-15')
,('D023','新品優惠','小樽咖啡6月8日起利比瑞卡咖啡85折','S005','0.85','2020-06-08', '2020-06-15')
,('D024','新品優惠','資策會咖啡6月8日起利比瑞卡咖啡85折','S006','0.85','2020-06-08', '2020-06-15')
,('D025','情人節優惠','星巴克公司7月7日起冰滴咖啡85折','S001','0.85','2020-07-07', '2020-07-14')
,('D026','情人節優惠','露易莎咖啡7月7日起冰滴咖啡75折','S002','0.75','2020-07-07', '2020-07-14')
,('D027','情人節優惠','伯朗咖啡7月7日起冰滴咖啡85折','S003','0.85','2020-07-07', '2020-07-14')
,('D028','情人節優惠','上島咖啡7月7日起冰滴咖啡85折','S004','0.85','2020-07-07', '2020-07-14')
,('D029','情人節優惠','小樽咖啡7月7日冰滴咖啡85折','S005','0.85','2020-07-07', '2020-07-14')
,('D030','情人節優惠','資策會咖啡7月7日起冰滴咖啡85折','S006','0.85','2020-07-07', '2020-07-14')
,('D031','父親節優惠','星巴克公司8月8日起冰摩卡咖啡85折','S001','0.85','2020-08-08', '2020-08-15')
,('D032','父親節優惠','露易莎咖啡8月8日起冰摩卡咖啡75折','S002','0.75','2020-08-08', '2020-08-15')
,('D033','父親節優惠','伯朗咖啡8月8日起冰摩卡咖啡85折','S006','0.85','2020-08-08', '2020-08-15')
,('D034','父親節優惠','上島咖啡8月8日起冰摩卡咖啡85折','S001','0.85','2020-08-08', '2020-08-15')
,('D035','父親節優惠','小樽咖啡8月8日起冰摩卡咖啡85折','S002','0.85','2020-08-08', '2020-08-15')
,('D036','父親節優惠','資策會咖啡8月8日起利冰摩卡咖啡85折','S003','0.85','2020-08-08', '2020-08-15');


CREATE TABLE discount_detail (
  disID varchar(10) NOT NULL,-- Primary key:流水號
  productID int(10) ZEROFILL NOT NULL, -- Primary key:流水號(商品)
  disPrice int(10) NOT NULL -- 單價
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 預設儲存引擎: InnoDB(after php5.5)
  
  INSERT INTO discount_detail VALUES
  ('D001',0000164413,'20'),
  ('D001',0000164414,'23'),
  ('D002',0000164413,'20'),
  ('D002',0000164414,'23'),
   ('D003',0000164413,'20'),
  ('D003',0000164414,'23'),
   ('D004',0000164413,'20'),
  ('D004',0000164414,'23'),
   ('D005',0000164413,'20'),
  ('D005',0000164414,'23'),
   ('D006',0000164413,'20'),
  ('D006',0000164414,'23'),
  ('D007',0000164414,'23'),
  ('D007',0000164415,'20'),
   ('D008',0000164414,'23'),
  ('D008',0000164415,'20'),
   ('D009',0000164414,'23'),
  ('D009',0000164415,'20'),
   ('D010',0000164414,'23'),
  ('D010',0000164415,'20'),
   ('D011',0000164414,'23'),
  ('D011',0000164415,'20'),
   ('D012',0000164414,'23'),
  ('D012',0000164415,'20'),
  ('D013',0000164415,'20'),
  ('D013',0000164416,'22'),
  ('D014',0000164415,'20'),
  ('D014',0000164416,'22'),
  ('D015',0000164415,'20'),
  ('D015',0000164416,'22'),
  ('D016',0000164415,'20'),
  ('D016',0000164416,'22'),
  ('D017',0000164415,'20'),
  ('D017',0000164416,'22'),
  ('D018',0000164415,'20'),
  ('D018',0000164416,'22'),
  ('D019',0000164417,'21'),
  ('D020',0000164417,'21'),
  ('D021',0000164417,'21'),
  ('D022',0000164417,'21'),
  ('D023',0000164417,'21'),
  ('D024',0000164417,'21'),
  ('D025',0000164416,'22'),
  ('D026',0000164416,'22'),
  ('D027',0000164416,'22'),
  ('D028',0000164416,'22'),
  ('D029',0000164416,'22'),
  ('D030',0000164416,'22'),
  ('D031',0000164418,'443'),
  ('D032',0000164418,'443'),
  ('D033',0000164418,'443'),
  ('D034',0000164418,'443'),
  ('D035',0000164418,'443'),
  ('D036',0000164418,'443');
  




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

INSERT INTO `coffee`.`products` (`ProductName`, `sellerID`, `CategoryID`, `UnitPrice`, `UnitsInStock`, `add_time`, `specification`, `description`) VALUES
('好貨1','S004','8','443','84','2019-03-03 03:34:03','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨2','S003','3','225','97','2019-03-17 23:49:42','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨3','S004','2','574','45','2018-02-03 06:09:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨4','S002','7','878','76','2018-06-06 23:43:26','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨5','S005','5','748','12','2017-07-21 21:39:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨6','S004','5','78','67','2018-05-24 07:26:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨7','S005','3','934','19','2017-10-03 16:40:20','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨8','S005','2','832','99','2019-03-07 20:57:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨9','S004','5','63','19','2019-11-06 19:26:43','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨10','S003','6','50','32','2017-12-11 05:47:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨11','S001','5','436','54','2019-08-07 23:37:47','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨12','S002','4','108','44','2018-06-02 06:31:00','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨13','S004','1','284','89','2018-10-10 01:02:35','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨14','S003','2','215','71','2019-12-29 21:31:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨15','S004','6','688','64','2019-03-14 21:05:18','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨16','S001','8','812','38','2017-05-06 03:24:52','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨17','S004','3','948','67','2020-01-25 21:19:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨18','S005','6','255','45','2019-07-26 03:00:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨19','S004','8','225','85','2017-12-19 19:01:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨20','S001','4','332','66','2019-06-04 01:18:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨21','S002','7','989','33','2017-09-20 10:52:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨22','S005','5','654','56','2018-01-28 01:51:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨23','S003','7','65','69','2018-01-21 17:22:50','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨24','S005','3','220','91','2019-02-27 03:16:10','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨25','S003','3','317','62','2017-04-05 02:22:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨26','S004','1','254','28','2019-05-31 09:49:42','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨27','S004','1','799','54','2017-06-11 21:50:08','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨28','S005','2','258','59','2020-01-06 18:43:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨29','S003','2','679','81','2020-01-16 18:16:27','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨30','S001','6','783','41','2020-01-01 10:03:22','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨31','S003','1','443','55','2017-07-04 05:55:50','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨32','S001','7','618','41','2017-12-03 00:58:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨33','S003','2','360','82','2019-04-26 00:12:21','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨34','S004','7','225','67','2017-08-23 05:24:22','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨35','S004','4','884','92','2018-03-11 10:47:03','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨36','S004','8','526','34','2019-02-12 20:44:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨37','S002','8','226','66','2018-01-16 10:28:03','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨38','S001','7','474','26','2017-04-16 10:53:09','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨39','S004','4','384','56','2018-11-14 07:04:21','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨40','S001','3','826','77','2019-10-22 22:17:45','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨41','S001','8','645','52','2017-07-28 06:59:23','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨42','S004','1','365','24','2017-04-21 23:30:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨43','S001','4','812','55','2017-11-23 05:29:02','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨44','S004','8','450','95','2017-12-24 11:52:32','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨45','S002','8','811','33','2018-12-07 19:17:14','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨46','S003','2','285','51','2019-06-12 06:17:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨47','S003','1','716','50','2018-07-18 04:55:11','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨48','S004','1','990','84','2019-12-25 12:49:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨49','S002','5','825','81','2019-05-08 17:34:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨50','S004','2','986','15','2017-09-14 17:09:50','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨51','S004','1','669','57','2019-12-18 04:19:09','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨52','S002','4','277','26','2018-11-16 04:32:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨53','S001','4','165','30','2019-05-23 20:56:34','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨54','S003','1','258','10','2018-08-14 04:57:01','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨55','S004','5','25','78','2019-10-11 18:24:12','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨56','S001','1','232','79','2019-11-23 19:20:01','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨57','S005','5','83','83','2018-12-01 07:36:52','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨58','S004','1','697','77','2018-11-09 21:48:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨59','S005','8','409','53','2019-01-11 23:35:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨60','S003','4','997','54','2019-08-31 15:39:08','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨61','S005','8','171','40','2018-05-08 01:05:21','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨62','S005','5','495','16','2018-03-15 00:19:40','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨63','S002','4','187','43','2018-11-12 05:15:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨64','S005','2','273','67','2019-01-02 22:49:05','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨65','S005','6','337','11','2017-08-06 20:04:45','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨66','S005','4','337','67','2019-07-05 17:06:45','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨67','S001','1','308','94','2018-04-01 10:03:08','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨68','S004','1','631','63','2019-05-21 15:10:07','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨69','S005','5','518','77','2018-09-25 05:59:19','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨70','S004','3','723','72','2019-11-06 05:38:19','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨71','S005','7','180','24','2018-03-01 17:56:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨72','S002','2','618','37','2018-08-16 15:17:30','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨73','S005','6','944','30','2017-12-17 10:43:49','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨74','S003','5','560','60','2017-03-26 04:32:42','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨75','S005','4','989','93','2018-02-03 08:29:39','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨76','S003','4','671','14','2019-05-03 06:34:48','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨77','S001','5','605','47','2019-09-03 08:23:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨78','S003','4','152','89','2018-05-26 00:56:31','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨79','S002','6','274','66','2020-02-12 08:06:35','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨80','S001','4','530','26','2018-06-03 07:56:55','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨81','S002','5','840','37','2019-03-06 00:27:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨82','S002','3','576','52','2018-12-26 15:00:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨83','S005','3','825','49','2017-10-18 18:01:01','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨84','S003','1','640','24','2019-06-29 00:15:09','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨85','S001','7','141','90','2019-07-13 13:37:34','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨86','S002','4','525','40','2019-02-11 20:37:25','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨87','S002','2','642','95','2018-05-15 10:08:59','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨88','S005','3','53','35','2017-12-02 15:08:50','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨89','S003','1','939','29','2017-03-31 21:54:25','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨90','S001','3','615','44','2019-05-18 18:39:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨91','S005','6','552','32','2017-04-07 22:30:22','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨92','S004','4','241','55','2018-11-18 01:48:06','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨93','S002','3','816','64','2017-12-18 01:21:02','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨94','S003','6','235','62','2019-11-29 16:53:03','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨95','S005','6','536','40','2018-10-02 12:59:42','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨96','S003','2','541','29','2018-05-08 20:54:14','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨97','S001','2','675','24','2018-02-13 10:20:42','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨98','S003','2','679','27','2019-05-28 02:44:03','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨99','S002','3','289','12','2017-09-30 13:57:10','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨100','S005','3','921','90','2017-06-26 11:50:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨101','S005','3','708','34','2019-03-06 04:46:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨102','S001','6','197','52','2018-01-19 14:40:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨103','S004','4','658','29','2020-01-27 14:40:30','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨104','S003','8','801','29','2018-03-01 22:07:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨105','S005','3','841','69','2018-03-20 18:17:55','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨106','S001','7','32','19','2019-09-24 00:25:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨107','S001','5','10','90','2019-05-19 11:35:30','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨108','S002','6','231','71','2019-11-28 18:23:49','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨109','S003','8','714','45','2018-11-18 04:19:36','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨110','S001','2','552','79','2019-04-19 10:03:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨111','S005','3','46','36','2017-05-19 02:00:17','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨112','S002','2','750','65','2019-11-23 10:47:50','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨113','S004','3','209','22','2019-10-10 03:06:17','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨114','S003','5','353','65','2019-03-22 10:08:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨115','S003','6','905','80','2019-04-04 03:19:49','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨116','S001','4','578','56','2017-09-02 03:42:59','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨117','S004','7','333','45','2018-03-01 16:09:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨118','S005','1','66','37','2019-12-28 04:11:14','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨119','S005','8','51','19','2018-08-18 01:39:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨120','S002','1','39','21','2019-01-20 23:02:27','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨121','S005','8','844','34','2017-08-17 11:35:57','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨122','S004','1','788','15','2020-02-23 07:36:19','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨123','S004','1','124','95','2019-12-06 00:28:26','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨124','S002','3','813','59','2018-01-13 06:43:21','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨125','S003','1','539','58','2019-10-29 06:26:02','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨126','S003','7','474','90','2019-03-29 21:35:20','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨127','S004','6','89','64','2017-05-04 08:38:05','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨128','S001','5','943','82','2019-11-11 22:09:59','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨129','S003','7','228','43','2018-07-18 10:45:14','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨130','S004','8','823','35','2018-02-11 03:42:58','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨131','S003','6','637','75','2017-11-04 03:09:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨132','S003','4','990','55','2017-07-09 10:49:34','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨133','S001','6','264','35','2019-05-05 04:25:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨134','S001','2','203','29','2019-02-22 12:28:17','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨135','S005','6','482','58','2018-08-09 16:07:05','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨136','S001','6','534','88','2019-09-01 09:42:19','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨137','S001','8','716','34','2017-08-03 03:09:49','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨138','S001','6','378','48','2018-05-24 16:48:08','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨139','S002','6','22','76','2017-04-19 01:08:22','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨140','S001','8','598','10','2019-09-21 19:42:44','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨141','S003','7','263','56','2019-08-11 13:01:02','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨142','S005','4','248','78','2018-02-26 06:46:40','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨143','S003','8','451','28','2019-02-18 22:27:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨144','S005','4','391','74','2018-01-27 07:52:39','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨145','S005','7','253','58','2017-05-08 04:28:58','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨146','S005','5','148','17','2018-11-24 00:49:58','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨147','S004','1','524','27','2018-12-12 04:10:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨148','S004','3','93','71','2017-12-13 01:38:18','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨149','S004','7','257','97','2020-02-21 12:31:36','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨150','S005','7','405','70','2020-02-29 20:05:25','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨151','S003','5','574','90','2018-09-01 05:06:17','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨152','S005','1','23','62','2017-11-02 10:34:58','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨153','S002','4','38','21','2019-07-02 23:08:00','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨154','S005','4','790','18','2017-03-28 09:22:22','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨155','S003','4','571','95','2019-11-26 13:27:18','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨156','S001','5','315','19','2019-05-12 17:07:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨157','S004','4','640','51','2017-04-25 20:10:49','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨158','S001','1','967','39','2018-10-12 04:13:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨159','S001','6','27','77','2019-07-19 07:10:44','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨160','S005','7','804','57','2017-06-24 06:48:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨161','S005','1','256','90','2020-01-01 10:42:32','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨162','S003','3','935','83','2019-07-05 10:02:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨163','S003','5','945','56','2020-03-05 04:16:06','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨164','S003','1','400','25','2018-02-08 22:33:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨165','S002','5','780','51','2017-07-29 12:32:20','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨166','S004','6','468','57','2020-01-09 13:05:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨167','S003','6','94','13','2019-09-29 17:09:00','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨168','S001','6','265','67','2017-11-05 18:21:02','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨169','S002','5','628','96','2018-08-18 04:23:06','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨170','S004','7','510','53','2019-08-01 01:15:11','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨171','S005','8','487','47','2018-12-26 13:51:31','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨172','S003','2','269','46','2018-12-20 03:44:42','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨173','S003','6','17','65','2018-05-10 17:39:51','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨174','S001','3','658','99','2017-09-28 11:19:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨175','S002','8','924','94','2019-07-12 22:02:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨176','S002','2','681','27','2018-01-29 12:22:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨177','S004','6','906','43','2018-09-02 06:17:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨178','S002','6','774','100','2018-09-15 02:11:41','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨179','S002','2','43','99','2020-01-31 12:40:21','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨180','S004','2','621','73','2018-02-04 10:09:48','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨181','S002','2','561','99','2020-01-06 10:33:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨182','S003','8','821','54','2018-02-21 22:57:45','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨183','S003','7','913','83','2018-02-07 05:32:39','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨184','S004','1','125','95','2019-09-11 03:16:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨185','S001','8','488','70','2018-07-10 15:21:03','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨186','S002','2','269','68','2017-04-04 04:58:39','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨187','S001','3','274','68','2019-09-20 04:25:22','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨188','S001','8','948','64','2018-09-21 18:38:18','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨189','S002','4','835','70','2018-07-31 10:26:06','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨190','S001','7','598','10','2017-08-02 01:03:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨191','S003','1','341','99','2017-10-18 06:03:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨192','S001','6','213','79','2018-10-03 10:03:11','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨193','S004','7','463','33','2019-03-08 08:39:45','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨194','S002','2','781','88','2019-03-09 03:04:22','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨195','S004','3','153','86','2018-03-11 20:58:43','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨196','S004','2','626','30','2018-08-23 09:34:57','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨197','S004','7','23','83','2019-12-30 19:51:52','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨198','S004','8','974','81','2019-07-13 07:01:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨199','S004','2','428','28','2017-11-05 00:27:40','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨200','S003','1','219','68','2019-11-23 21:58:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨201','S002','4','916','91','2018-11-08 08:02:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨202','S003','8','218','68','2019-10-22 19:37:08','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨203','S002','8','207','28','2017-11-21 09:13:35','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨204','S002','4','104','67','2017-11-25 10:01:33','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨205','S002','8','809','37','2019-02-06 15:38:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨206','S001','5','115','37','2018-09-24 14:40:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨207','S004','6','438','43','2017-09-27 03:51:26','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨208','S003','8','10','32','2020-01-07 20:49:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨209','S005','6','719','62','2018-12-14 14:27:27','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨210','S004','4','869','87','2017-12-17 01:49:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨211','S001','5','607','39','2017-09-16 14:57:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨212','S002','5','612','91','2018-02-14 18:32:23','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨213','S003','5','211','23','2019-03-07 04:45:17','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨214','S005','2','751','24','2019-01-15 13:38:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨215','S003','3','588','13','2018-08-25 10:05:50','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨216','S002','5','488','25','2020-02-06 15:08:09','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨217','S003','5','811','48','2018-10-27 12:32:00','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨218','S003','1','886','35','2019-07-14 12:24:14','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨219','S003','3','289','35','2017-03-23 11:57:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨220','S002','3','728','81','2019-08-25 11:52:49','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨221','S001','7','327','68','2019-03-12 19:34:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨222','S002','4','635','59','2018-07-02 22:40:47','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨223','S004','3','449','93','2020-02-11 18:29:25','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨224','S005','4','297','29','2019-07-19 01:56:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨225','S003','6','543','40','2018-09-09 18:35:10','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨226','S004','6','215','84','2018-10-30 23:56:59','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨227','S005','6','83','25','2018-07-17 10:50:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨228','S002','7','541','92','2018-03-17 09:29:42','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨229','S005','5','962','25','2019-07-13 22:36:05','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨230','S002','7','276','89','2018-07-11 18:23:06','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨231','S004','5','998','76','2019-09-17 12:25:01','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨232','S005','2','368','44','2019-11-21 20:49:30','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨233','S004','8','537','36','2018-04-28 17:33:18','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨234','S003','7','910','99','2017-10-27 07:56:58','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨235','S005','6','451','69','2017-05-06 06:35:32','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨236','S002','5','229','47','2017-08-30 09:27:33','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨237','S003','8','616','16','2019-07-29 15:03:01','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨238','S003','3','714','87','2018-11-01 17:10:02','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨239','S005','6','567','99','2017-08-07 17:32:47','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨240','S001','4','939','66','2017-05-12 07:37:21','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨241','S005','8','399','75','2017-04-23 08:35:42','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨242','S001','5','127','26','2019-06-29 18:01:40','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨243','S005','2','262','61','2017-08-09 05:50:50','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨244','S002','3','567','52','2019-03-15 02:57:57','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨245','S005','4','131','95','2019-02-28 23:07:41','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨246','S005','3','734','12','2019-03-17 04:40:59','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨247','S001','1','199','41','2017-03-28 05:53:44','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨248','S002','8','948','20','2019-09-10 11:11:36','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨249','S004','4','61','78','2018-08-08 03:09:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨250','S005','1','547','41','2017-11-13 03:38:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨251','S005','3','563','67','2019-08-12 13:16:57','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨252','S001','2','248','31','2019-12-04 05:58:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨253','S003','8','958','95','2017-03-12 22:51:36','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨254','S002','6','908','26','2019-11-15 16:55:20','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨255','S004','6','678','21','2018-07-21 21:26:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨256','S005','5','579','35','2018-07-19 10:40:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨257','S002','4','601','33','2018-09-25 07:12:50','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨258','S002','7','287','92','2018-02-15 12:18:07','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨259','S004','5','15','10','2017-12-03 21:40:30','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨260','S001','8','838','75','2019-07-18 06:07:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨261','S003','4','953','85','2018-05-29 04:03:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨262','S001','4','263','44','2019-07-20 22:54:23','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨263','S003','2','356','95','2019-03-01 09:04:20','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨264','S002','8','406','44','2019-01-20 04:02:23','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨265','S004','4','530','88','2018-07-03 15:31:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨266','S003','4','834','50','2018-07-17 01:55:21','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨267','S002','7','703','52','2018-03-10 21:13:36','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨268','S004','7','231','44','2017-07-02 16:06:47','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨269','S003','3','827','95','2019-03-25 07:31:39','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨270','S004','4','790','56','2019-05-05 19:45:33','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨271','S005','8','177','75','2019-11-21 14:09:50','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨272','S003','7','729','56','2017-04-24 08:53:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨273','S004','8','99','75','2019-10-19 07:16:34','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨274','S001','5','386','39','2017-09-01 18:14:26','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨275','S003','4','898','44','2017-07-05 23:12:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨276','S005','5','927','53','2019-04-24 20:25:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨277','S004','3','258','89','2017-11-19 21:07:44','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨278','S001','7','662','54','2019-01-11 14:15:17','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨279','S005','6','974','53','2018-04-23 00:49:40','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨280','S003','3','969','38','2019-09-02 15:16:07','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨281','S002','7','346','78','2017-04-08 23:43:40','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨282','S004','5','964','51','2017-04-25 03:56:51','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨283','S002','6','666','96','2017-03-25 10:35:59','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨284','S004','1','311','53','2019-08-16 14:48:34','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨285','S005','8','500','33','2019-10-31 15:10:43','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨286','S003','8','749','45','2019-05-06 20:05:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨287','S004','7','536','82','2019-06-16 21:36:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨288','S004','5','498','33','2017-06-12 21:05:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨289','S003','7','927','60','2018-08-22 22:35:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨290','S005','3','202','42','2017-08-26 00:07:07','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨291','S004','5','370','41','2019-01-10 12:06:33','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨292','S002','7','78','98','2017-11-11 09:48:51','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨293','S004','6','995','64','2019-04-19 20:34:22','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨294','S004','7','661','10','2018-04-17 13:51:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨295','S003','4','128','30','2017-08-12 05:01:14','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨296','S003','8','665','58','2017-05-24 12:49:11','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨297','S003','8','464','54','2018-09-28 03:42:33','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨298','S001','5','65','95','2017-07-07 07:58:08','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨299','S005','5','908','58','2017-05-11 23:04:33','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨300','S001','4','693','13','2019-09-25 20:52:32','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨301','S002','5','532','30','2019-10-22 19:43:02','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨302','S004','7','871','66','2017-06-21 04:46:57','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨303','S002','4','893','16','2019-11-11 00:30:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨304','S005','8','522','95','2019-02-24 04:08:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨305','S005','1','568','54','2018-09-08 19:21:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨306','S004','1','696','63','2018-02-26 00:15:49','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨307','S003','6','52','10','2019-07-24 17:15:03','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨308','S004','5','680','22','2017-08-25 19:05:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨309','S004','1','869','42','2017-04-06 18:38:48','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨310','S002','1','114','35','2018-03-18 07:15:31','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨311','S002','5','238','90','2017-06-19 09:22:48','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨312','S004','1','393','77','2019-05-29 18:06:06','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨313','S002','6','39','67','2019-10-28 12:21:08','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨314','S003','5','525','10','2017-07-15 10:14:55','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨315','S002','7','491','87','2017-09-20 06:51:47','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨316','S001','7','419','36','2019-09-27 19:00:05','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨317','S001','4','432','56','2019-12-21 22:11:43','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨318','S001','7','840','56','2018-07-24 06:04:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨319','S001','4','345','50','2019-03-12 13:55:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨320','S002','5','934','50','2018-01-14 16:14:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨321','S001','8','157','89','2019-03-08 10:17:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨322','S001','7','202','95','2017-09-30 08:32:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨323','S005','4','494','22','2019-09-09 14:07:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨324','S003','2','991','78','2018-03-16 10:27:41','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨325','S004','8','304','47','2019-03-16 02:36:10','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨326','S004','8','208','26','2018-05-14 04:04:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨327','S001','7','177','68','2018-06-20 21:09:00','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨328','S003','6','327','82','2020-02-19 20:25:23','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨329','S004','7','473','76','2017-03-24 00:42:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨330','S001','8','342','69','2019-05-06 19:53:31','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨331','S003','7','463','92','2018-05-03 11:40:39','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨332','S003','5','191','28','2018-09-19 00:33:52','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨333','S001','3','983','53','2017-04-30 09:25:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨334','S001','3','860','46','2017-03-24 14:58:23','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨335','S003','3','323','36','2019-02-09 16:28:49','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨336','S005','4','199','46','2019-07-10 08:29:48','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨337','S003','1','303','70','2019-01-28 13:34:44','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨338','S003','8','170','23','2017-10-14 14:36:00','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨339','S001','3','451','64','2019-04-05 22:03:25','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨340','S005','1','279','47','2018-07-02 01:30:58','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨341','S003','4','140','74','2019-11-21 20:33:26','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨342','S005','6','754','73','2018-12-15 19:00:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨343','S002','5','675','13','2018-01-17 16:59:18','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨344','S005','7','978','36','2018-07-29 20:09:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨345','S005','2','680','19','2017-08-07 06:27:44','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨346','S003','1','914','24','2018-05-07 12:55:20','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨347','S001','1','528','31','2017-05-09 06:21:26','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨348','S003','4','348','33','2019-08-09 16:06:57','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨349','S002','5','914','48','2019-06-06 02:42:11','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨350','S005','2','234','40','2017-07-28 11:57:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨351','S005','1','49','69','2017-05-16 08:53:17','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨352','S004','1','624','65','2019-10-24 00:36:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨353','S001','6','573','100','2019-03-24 07:36:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨354','S003','2','460','22','2019-04-05 02:39:07','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨355','S001','6','817','49','2017-10-19 17:25:36','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨356','S002','4','701','91','2018-01-30 14:19:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨357','S003','3','50','98','2019-06-20 16:36:27','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨358','S005','2','785','36','2018-04-21 20:57:39','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨359','S002','8','719','20','2019-09-13 21:34:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨360','S001','6','638','23','2019-10-30 03:40:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨361','S004','7','782','93','2019-09-09 10:53:30','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨362','S002','8','99','99','2017-07-23 16:49:30','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨363','S005','6','797','47','2018-07-05 04:31:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨364','S001','2','395','37','2019-05-17 13:51:19','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨365','S005','1','272','22','2019-07-28 15:32:17','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨366','S001','4','534','55','2018-09-21 05:35:09','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨367','S005','8','550','89','2019-08-29 15:23:47','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨368','S003','6','304','33','2017-10-19 15:59:55','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨369','S003','2','227','87','2018-03-14 21:41:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨370','S004','5','935','10','2018-06-06 01:40:23','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨371','S004','4','75','12','2017-10-07 02:05:50','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨372','S004','4','986','94','2019-12-02 08:57:30','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨373','S005','8','225','60','2018-09-04 12:37:39','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨374','S005','8','159','18','2019-06-16 18:16:59','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨375','S002','6','843','11','2018-06-13 02:11:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨376','S003','6','445','63','2018-12-07 05:56:14','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨377','S001','5','384','87','2019-06-01 04:59:35','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨378','S003','3','602','15','2019-02-18 17:37:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨379','S003','8','771','94','2018-05-22 18:42:36','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨380','S005','3','553','57','2018-06-01 01:58:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨381','S003','2','389','93','2018-07-24 20:43:08','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨382','S002','6','894','63','2020-01-21 13:06:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨383','S001','4','646','82','2018-05-18 05:25:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨384','S002','1','198','37','2019-11-02 01:12:19','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨385','S002','5','71','46','2018-02-26 21:07:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨386','S002','6','573','79','2019-09-10 00:35:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨387','S001','1','315','38','2017-07-07 04:08:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨388','S003','1','582','28','2019-01-03 03:19:18','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨389','S003','8','705','42','2019-06-22 07:43:51','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨390','S005','8','960','56','2018-04-10 22:08:43','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨391','S003','7','14','57','2018-06-11 08:42:01','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨392','S002','6','821','93','2020-02-27 09:15:59','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨393','S003','7','21','39','2017-09-05 22:55:48','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨394','S002','6','731','86','2018-06-17 01:28:25','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨395','S005','3','531','48','2017-12-30 16:03:34','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨396','S005','8','820','60','2019-01-03 20:57:25','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨397','S004','8','137','26','2018-07-30 16:58:35','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨398','S003','2','593','83','2018-01-28 18:10:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨399','S003','3','508','96','2018-05-25 16:01:32','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨400','S001','4','695','64','2018-04-28 16:12:12','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨401','S003','2','297','13','2018-08-25 16:08:31','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨402','S003','8','104','25','2017-04-27 19:36:45','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨403','S004','7','613','99','2017-03-22 03:09:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨404','S002','3','276','16','2018-04-19 00:33:55','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨405','S003','7','471','89','2019-07-15 14:16:19','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨406','S002','6','326','26','2018-05-15 06:02:34','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨407','S003','1','690','35','2019-04-11 20:53:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨408','S003','1','969','42','2019-10-16 16:31:12','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨409','S002','1','902','74','2017-04-14 04:06:39','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨410','S001','7','440','44','2017-07-17 18:07:57','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨411','S005','1','571','91','2017-04-20 22:57:01','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨412','S005','5','16','34','2018-05-16 12:18:42','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨413','S004','3','824','94','2019-01-07 05:25:11','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨414','S003','6','175','20','2019-07-26 04:22:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨415','S004','7','966','80','2019-12-25 18:11:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨416','S005','1','831','38','2019-08-14 05:47:55','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨417','S005','7','927','22','2019-03-18 14:03:44','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨418','S001','7','963','34','2017-09-26 16:54:50','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨419','S005','1','615','36','2017-06-10 05:10:17','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨420','S004','3','201','94','2019-03-17 13:28:27','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨421','S004','3','268','50','2019-11-18 17:20:43','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨422','S004','2','267','27','2020-01-12 17:33:02','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨423','S001','2','629','29','2017-03-19 00:12:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨424','S003','1','970','80','2018-10-23 08:49:31','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨425','S005','1','653','97','2017-11-11 21:22:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨426','S002','3','968','74','2020-03-03 05:38:31','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨427','S005','4','975','55','2018-12-05 21:52:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨428','S005','2','246','84','2020-02-19 21:19:57','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨429','S004','8','52','83','2018-09-11 19:47:45','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨430','S003','1','576','60','2017-09-18 21:48:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨431','S004','5','424','66','2020-02-19 08:30:12','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨432','S005','3','297','59','2019-07-11 11:49:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨433','S005','1','66','78','2019-09-16 23:15:10','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨434','S005','7','976','98','2019-12-15 17:38:34','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨435','S001','4','120','49','2017-05-11 21:03:14','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨436','S002','6','317','84','2018-01-31 00:40:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨437','S003','8','248','40','2017-07-19 22:28:58','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨438','S002','3','591','89','2018-01-22 04:10:30','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨439','S002','8','866','29','2018-09-14 00:40:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨440','S001','6','862','89','2019-11-16 01:18:23','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨441','S003','5','693','86','2020-01-23 19:20:43','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨442','S003','3','371','60','2019-01-04 00:06:32','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨443','S005','2','385','12','2019-10-29 02:24:41','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨444','S005','2','47','33','2019-05-25 01:47:25','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨445','S004','4','631','76','2019-08-25 09:37:44','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨446','S002','3','951','64','2018-10-06 18:47:03','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨447','S001','1','197','62','2019-10-12 10:25:52','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨448','S001','6','342','20','2019-12-20 15:54:22','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨449','S005','5','620','72','2017-11-17 01:22:26','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨450','S005','1','214','46','2020-01-27 22:42:25','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨451','S003','5','851','13','2019-02-17 03:26:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨452','S005','4','889','46','2017-07-27 10:28:30','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨453','S001','1','846','45','2017-11-06 14:55:23','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨454','S001','2','899','53','2018-04-18 07:25:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨455','S002','8','661','14','2017-06-13 17:05:19','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨456','S002','6','58','49','2018-07-31 06:16:44','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨457','S004','2','966','70','2018-11-30 01:59:03','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨458','S001','5','753','19','2017-08-14 06:00:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨459','S003','4','591','58','2019-07-08 17:57:39','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨460','S001','4','661','66','2019-08-21 17:49:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨461','S005','2','175','27','2017-12-23 07:57:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨462','S001','3','338','38','2018-03-31 19:15:20','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨463','S002','3','211','28','2017-10-28 05:34:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨464','S001','2','564','61','2020-03-01 15:40:22','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨465','S004','6','954','43','2018-06-21 16:47:45','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨466','S005','2','306','40','2020-02-29 10:55:09','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨467','S003','1','833','89','2019-12-25 19:00:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨468','S005','7','514','99','2018-03-22 18:18:27','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨469','S001','5','881','47','2019-04-01 10:45:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨470','S005','5','924','44','2018-12-19 12:27:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨471','S005','8','95','92','2020-02-01 11:48:55','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨472','S002','8','385','66','2019-11-06 09:37:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨473','S005','4','415','76','2018-01-14 17:45:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨474','S004','8','376','90','2019-06-28 02:40:20','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨475','S001','4','13','22','2018-06-12 23:47:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨476','S001','8','537','46','2017-03-23 08:01:58','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨477','S001','2','442','17','2017-07-11 08:18:43','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨478','S005','2','375','78','2018-03-15 23:00:41','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨479','S003','5','583','85','2019-05-18 01:22:17','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨480','S001','2','565','60','2017-04-28 23:52:02','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨481','S002','7','39','60','2018-06-11 15:46:44','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨482','S003','8','746','28','2019-09-26 04:57:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨483','S001','7','17','45','2019-04-07 15:57:00','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨484','S001','4','492','61','2017-12-26 01:04:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨485','S002','4','375','80','2020-02-03 02:23:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨486','S004','8','647','14','2019-11-21 13:55:09','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨487','S001','2','361','23','2018-01-26 04:49:18','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨488','S002','1','112','39','2018-07-14 02:59:01','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨489','S005','6','781','29','2020-01-15 05:50:45','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨490','S004','6','259','68','2019-10-26 14:45:21','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨491','S003','7','350','54','2017-11-07 11:15:49','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨492','S002','8','992','61','2018-12-27 13:48:30','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨493','S005','8','913','13','2019-03-07 20:42:35','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨494','S003','2','99','54','2019-10-15 23:23:43','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨495','S003','2','193','51','2020-02-05 03:53:34','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨496','S001','3','87','96','2019-02-06 10:29:20','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨497','S004','2','571','78','2020-01-21 02:20:27','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨498','S001','1','872','62','2020-01-31 17:15:42','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨499','S001','5','334','43','2019-05-18 08:50:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨500','S003','3','809','42','2018-03-05 20:58:45','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨501','S002','5','223','68','2017-07-16 08:03:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨502','S005','6','387','45','2019-02-01 03:12:01','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨503','S003','7','125','92','2017-10-21 14:54:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨504','S005','1','607','85','2018-09-12 15:30:02','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨505','S001','3','343','37','2019-06-09 03:26:25','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨506','S002','4','330','11','2018-08-09 07:44:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨507','S004','6','398','33','2019-02-17 10:17:08','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨508','S004','7','698','59','2019-10-26 12:38:12','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨509','S004','7','453','23','2019-12-16 12:35:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨510','S001','1','965','73','2018-06-17 01:40:20','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨511','S003','4','957','91','2017-09-07 11:32:42','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨512','S005','1','211','96','2019-08-28 01:18:45','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨513','S002','1','386','43','2020-03-05 05:02:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨514','S001','6','805','93','2018-11-10 20:16:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨515','S005','8','553','37','2018-04-10 08:56:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨516','S005','5','744','46','2020-01-20 01:22:09','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨517','S002','6','806','43','2017-11-11 03:33:31','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨518','S003','2','520','52','2018-09-29 11:07:10','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨519','S004','2','291','37','2019-08-18 03:48:14','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨520','S004','8','75','35','2017-04-04 08:47:00','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨521','S002','1','15','10','2019-09-05 07:05:33','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨522','S004','6','678','27','2018-04-08 23:01:27','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨523','S001','2','722','38','2017-04-24 20:19:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨524','S001','2','396','44','2017-10-25 02:02:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨525','S002','1','11','11','2018-01-26 17:03:02','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨526','S003','8','898','82','2018-01-01 02:55:17','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨527','S001','5','74','22','2017-06-07 04:23:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨528','S004','4','35','25','2019-11-02 05:42:17','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨529','S004','2','443','64','2017-08-11 07:14:31','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨530','S005','8','791','76','2017-10-21 21:51:41','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨531','S002','2','617','65','2019-08-29 22:55:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨532','S004','3','165','42','2018-05-05 01:46:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨533','S001','5','257','73','2019-02-12 00:23:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨534','S001','3','229','51','2018-05-14 02:10:02','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨535','S004','3','840','22','2019-06-29 08:46:52','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨536','S005','4','541','56','2017-09-14 14:00:07','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨537','S004','3','826','70','2018-06-06 19:04:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨538','S001','6','361','73','2018-07-28 20:56:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨539','S001','8','755','42','2018-11-25 14:10:07','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨540','S002','6','752','100','2018-04-20 07:39:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨541','S004','8','479','15','2017-08-21 13:24:36','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨542','S002','2','362','28','2018-08-30 17:15:20','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨543','S002','4','191','64','2017-04-23 05:48:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨544','S005','1','559','22','2017-04-30 09:19:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨545','S002','3','58','99','2019-01-11 11:17:51','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨546','S004','8','114','19','2017-04-14 03:07:31','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨547','S004','1','68','34','2017-09-15 20:53:35','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨548','S005','7','46','28','2019-08-07 04:40:02','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨549','S004','8','154','34','2018-02-14 01:12:55','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨550','S003','1','561','30','2018-05-08 11:34:43','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨551','S005','8','631','61','2019-08-23 09:07:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨552','S002','8','108','67','2018-05-29 03:38:45','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨553','S005','4','957','65','2019-09-11 05:15:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨554','S003','5','807','54','2018-09-01 12:57:14','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨555','S002','1','891','77','2020-01-30 07:30:03','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨556','S002','1','979','99','2017-06-21 18:18:00','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨557','S005','1','480','17','2019-05-02 05:31:47','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨558','S005','7','842','92','2018-12-31 16:50:57','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨559','S003','7','385','88','2018-02-18 20:59:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨560','S005','3','16','61','2020-01-13 23:33:12','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨561','S003','2','553','32','2018-07-01 00:46:47','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨562','S002','1','370','93','2017-06-15 23:07:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨563','S003','7','571','55','2017-10-26 16:39:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨564','S001','7','906','13','2019-08-20 20:48:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨565','S003','2','854','89','2017-08-27 22:19:20','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨566','S001','2','301','52','2017-08-02 09:53:20','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨567','S003','8','508','54','2018-10-01 21:17:14','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨568','S002','1','637','54','2017-09-12 09:27:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨569','S003','7','237','86','2017-08-07 12:23:00','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨570','S001','3','833','10','2019-01-25 17:58:57','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨571','S004','3','975','80','2018-03-06 03:28:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨572','S004','1','230','14','2017-10-01 03:26:30','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨573','S002','4','641','55','2017-11-10 20:06:11','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨574','S004','7','613','93','2019-11-06 03:18:48','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨575','S001','6','904','50','2017-10-15 07:18:50','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨576','S004','8','726','91','2019-01-14 04:10:39','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨577','S005','8','783','97','2020-02-15 00:14:30','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨578','S004','5','317','83','2020-02-09 01:47:09','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨579','S002','6','709','48','2019-08-02 04:32:40','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨580','S001','3','661','15','2017-12-15 14:52:14','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨581','S001','8','717','38','2017-12-21 06:07:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨582','S001','5','811','37','2018-04-28 12:51:14','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨583','S004','3','514','92','2020-01-22 18:53:41','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨584','S005','2','970','41','2019-12-21 15:57:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨585','S005','6','49','45','2018-06-13 06:30:02','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨586','S005','3','86','25','2019-12-10 01:28:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨587','S002','8','496','12','2018-02-23 05:03:09','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨588','S002','6','704','54','2017-11-29 05:20:57','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨589','S005','1','13','72','2019-10-08 23:51:05','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨590','S002','3','967','27','2018-06-09 02:40:09','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨591','S005','7','623','33','2017-12-21 06:53:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨592','S002','6','318','19','2018-01-07 15:03:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨593','S002','3','566','14','2018-03-04 14:53:26','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨594','S002','4','943','91','2018-09-20 01:06:44','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨595','S002','3','633','93','2018-01-16 07:43:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨596','S001','1','106','87','2017-05-01 18:44:05','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨597','S005','4','325','91','2018-08-15 08:13:48','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨598','S004','2','395','24','2018-02-12 18:06:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨599','S001','1','331','79','2018-01-08 10:17:34','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨600','S001','2','940','56','2018-12-16 18:13:40','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨601','S003','2','351','56','2017-04-02 04:21:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨602','S001','2','10','73','2018-02-05 21:49:32','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨603','S001','8','852','65','2019-07-31 10:41:12','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨604','S002','5','376','24','2019-01-18 05:42:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨605','S004','5','148','87','2019-08-04 19:51:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨606','S002','1','148','48','2017-07-09 11:42:25','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨607','S004','2','444','95','2018-07-20 06:20:05','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨608','S001','3','111','74','2020-01-16 03:21:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨609','S004','6','972','70','2017-11-27 21:44:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨610','S004','2','141','55','2018-05-21 01:16:26','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨611','S005','2','907','70','2020-01-22 10:56:58','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨612','S004','1','770','80','2017-06-10 04:19:03','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨613','S001','4','136','21','2019-04-06 01:04:44','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨614','S003','8','162','26','2017-08-26 22:50:50','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨615','S004','4','817','64','2017-11-23 22:07:55','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨616','S005','5','814','58','2018-08-15 01:08:57','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨617','S001','2','729','74','2018-03-09 21:01:01','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨618','S001','2','389','68','2019-11-12 14:42:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨619','S004','6','245','68','2019-03-09 12:41:23','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨620','S005','4','455','61','2019-08-12 12:44:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨621','S001','3','408','77','2019-02-06 20:48:25','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨622','S005','2','15','97','2019-05-10 01:52:43','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨623','S002','7','10','79','2019-07-14 21:15:36','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨624','S005','7','538','75','2019-04-08 05:23:07','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨625','S001','6','677','46','2017-10-01 00:57:11','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨626','S003','2','865','100','2019-04-12 23:40:25','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨627','S004','2','338','36','2018-10-11 10:17:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨628','S005','3','511','87','2019-09-04 13:14:45','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨629','S003','6','610','26','2018-09-29 04:31:05','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨630','S005','6','78','90','2018-08-12 21:56:17','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨631','S003','4','648','24','2018-10-18 01:17:35','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨632','S004','8','647','63','2017-06-16 07:03:03','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨633','S004','4','69','92','2018-10-12 12:45:23','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨634','S003','6','750','70','2018-10-03 03:55:05','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨635','S003','1','179','90','2017-11-16 04:29:31','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨636','S001','2','216','45','2018-05-11 22:49:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨637','S003','1','701','37','2017-06-04 00:18:07','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨638','S002','1','817','45','2018-08-28 17:15:06','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨639','S003','1','170','90','2019-09-04 21:41:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨640','S002','6','205','48','2018-06-10 12:24:10','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨641','S002','8','820','89','2018-11-20 20:48:42','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨642','S004','8','211','72','2017-07-11 06:56:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨643','S004','8','922','31','2017-08-04 08:18:51','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨644','S005','7','967','100','2018-12-28 11:28:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨645','S003','8','565','62','2019-10-20 18:07:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨646','S005','1','478','76','2019-10-24 15:00:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨647','S001','5','408','21','2019-09-18 23:45:06','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨648','S004','4','112','12','2018-10-13 14:03:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨649','S005','8','526','63','2018-02-15 03:35:01','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨650','S005','3','534','49','2019-06-15 05:41:09','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨651','S003','7','141','51','2019-01-26 05:05:41','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨652','S002','6','501','62','2019-08-21 10:35:08','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨653','S005','3','939','17','2018-06-08 08:30:17','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨654','S002','3','199','80','2018-06-07 12:40:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨655','S001','5','994','42','2019-06-13 10:29:34','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨656','S005','6','180','34','2018-06-11 22:52:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨657','S005','5','641','53','2017-11-07 01:44:51','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨658','S004','4','681','54','2019-10-08 00:17:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨659','S001','3','331','32','2019-09-04 19:39:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨660','S004','1','551','90','2017-04-29 20:52:31','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨661','S005','2','604','68','2019-03-27 17:27:47','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨662','S003','1','403','27','2018-02-06 07:25:26','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨663','S002','6','142','69','2018-03-01 13:44:42','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨664','S004','4','780','29','2017-10-06 03:15:19','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨665','S002','8','788','44','2019-11-10 12:25:27','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨666','S005','7','961','24','2019-09-26 15:16:47','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨667','S003','8','871','93','2018-12-24 04:38:02','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨668','S005','1','87','51','2019-06-23 11:31:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨669','S002','1','679','84','2017-12-01 10:03:51','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨670','S004','3','42','33','2019-09-15 23:28:33','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨671','S003','1','790','87','2017-08-02 19:14:09','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨672','S002','5','406','44','2017-11-15 02:40:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨673','S003','3','375','63','2019-01-16 03:46:36','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨674','S003','7','137','99','2017-10-31 01:54:31','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨675','S005','7','532','33','2019-06-01 08:59:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨676','S003','7','903','55','2019-03-21 18:31:35','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨677','S003','7','653','49','2017-10-13 16:56:06','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨678','S005','2','933','59','2017-05-12 16:59:51','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨679','S005','5','699','80','2017-07-10 20:07:02','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨680','S001','2','864','73','2018-07-20 02:58:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨681','S003','6','182','82','2019-09-24 04:33:51','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨682','S001','8','598','57','2018-10-14 12:33:12','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨683','S002','1','260','56','2019-02-13 00:41:32','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨684','S003','2','955','74','2019-02-10 14:24:33','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨685','S005','1','437','77','2018-12-01 12:41:32','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨686','S005','1','336','35','2020-01-27 00:38:03','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨687','S005','7','460','17','2018-04-06 14:03:51','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨688','S001','8','445','79','2019-05-22 19:23:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨689','S004','4','780','78','2018-02-28 12:26:03','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨690','S003','2','526','87','2019-04-20 07:17:50','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨691','S003','6','871','14','2020-01-09 20:48:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨692','S003','6','779','43','2020-02-17 01:00:05','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨693','S005','7','405','12','2019-08-01 14:15:41','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨694','S005','8','850','92','2019-04-30 21:05:00','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨695','S004','3','824','17','2019-10-23 12:33:14','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨696','S005','8','94','47','2017-06-16 03:04:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨697','S004','6','552','89','2019-04-19 00:47:08','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨698','S005','8','671','63','2019-10-07 08:32:34','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨699','S001','8','454','84','2017-10-16 22:24:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨700','S001','1','717','11','2019-05-03 13:12:57','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨701','S001','8','853','44','2019-04-17 09:29:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨702','S005','1','888','61','2017-07-17 15:34:32','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨703','S002','6','589','50','2019-08-21 14:54:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨704','S004','2','905','53','2018-02-22 04:28:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨705','S001','4','526','16','2019-11-26 02:40:23','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨706','S003','8','353','75','2019-11-04 14:07:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨707','S003','4','163','100','2017-04-21 04:34:57','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨708','S004','4','178','37','2017-10-10 11:33:08','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨709','S003','8','726','65','2018-09-01 09:54:45','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨710','S003','1','919','24','2017-12-21 12:39:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨711','S001','6','196','37','2017-07-19 06:29:33','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨712','S004','4','545','97','2017-07-30 13:31:17','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨713','S002','7','465','86','2017-03-22 17:29:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨714','S003','5','961','61','2017-04-16 18:32:48','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨715','S003','7','710','34','2017-09-01 09:42:20','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨716','S001','6','358','63','2017-05-25 12:39:58','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨717','S005','8','452','28','2017-04-07 04:58:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨718','S005','7','560','82','2019-10-09 05:51:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨719','S001','7','545','89','2019-04-22 11:36:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨720','S003','3','282','15','2020-02-26 07:20:33','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨721','S001','5','727','34','2019-08-15 23:06:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨722','S003','4','223','89','2017-10-01 13:18:26','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨723','S005','8','578','72','2018-09-01 15:09:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨724','S002','4','388','16','2019-01-27 15:51:52','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨725','S004','2','318','50','2017-06-21 18:27:52','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨726','S002','4','919','82','2019-04-26 04:23:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨727','S002','7','185','28','2019-07-23 07:43:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨728','S002','2','507','33','2019-12-07 13:36:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨729','S004','7','184','51','2018-01-07 09:32:17','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨730','S003','4','162','59','2019-03-02 07:09:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨731','S003','3','565','28','2017-10-15 10:04:09','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨732','S001','5','802','78','2018-10-07 16:43:58','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨733','S001','3','648','18','2017-10-30 22:08:49','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨734','S002','8','275','71','2017-03-11 05:48:40','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨735','S002','3','13','36','2017-03-18 11:46:05','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨736','S003','8','951','88','2018-06-10 22:32:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨737','S001','5','672','64','2018-12-19 19:06:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨738','S005','1','871','43','2019-04-03 04:32:12','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨739','S005','4','983','41','2018-03-31 04:24:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨740','S003','2','225','31','2018-10-16 20:12:09','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨741','S002','2','231','90','2018-11-18 02:59:58','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨742','S005','1','924','17','2017-05-06 11:20:35','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨743','S001','7','349','93','2018-02-08 16:20:35','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨744','S001','1','679','25','2018-04-02 07:41:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨745','S002','3','323','38','2018-11-10 16:13:01','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨746','S002','2','558','87','2018-06-16 11:12:42','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨747','S004','6','207','91','2017-06-08 23:52:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨748','S005','4','940','20','2019-02-12 06:08:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨749','S002','2','448','44','2018-08-28 14:35:02','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨750','S004','8','625','81','2019-10-17 15:01:45','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨751','S003','2','92','49','2019-09-14 13:00:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨752','S003','7','26','68','2018-02-03 16:52:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨753','S005','4','784','70','2019-09-29 07:48:11','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨754','S001','5','343','70','2018-10-05 06:51:59','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨755','S004','2','23','82','2018-10-18 00:12:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨756','S002','8','621','56','2018-05-23 21:02:30','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨757','S003','8','354','13','2019-11-13 22:46:26','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨758','S002','5','884','30','2017-12-31 17:26:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨759','S005','4','959','51','2018-02-03 07:20:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨760','S003','1','640','21','2017-06-26 12:46:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨761','S003','6','897','37','2018-02-20 08:17:34','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨762','S005','4','282','22','2019-05-24 17:41:51','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨763','S005','8','64','30','2018-07-05 08:17:06','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨764','S002','2','493','61','2020-01-22 21:50:57','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨765','S003','3','806','27','2019-01-17 09:06:30','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨766','S004','8','93','82','2018-08-07 16:27:41','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨767','S004','4','66','71','2020-01-01 01:42:10','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨768','S001','1','617','62','2019-09-21 10:17:26','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨769','S001','2','124','71','2017-04-22 12:58:41','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨770','S005','8','674','52','2018-06-07 14:46:00','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨771','S001','7','217','90','2018-03-15 10:54:19','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨772','S001','3','18','13','2017-08-02 05:07:21','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨773','S001','6','136','53','2017-07-02 13:20:03','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨774','S003','7','969','29','2018-09-18 18:47:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨775','S004','8','982','40','2019-10-02 11:43:33','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨776','S005','8','617','37','2018-09-11 18:22:39','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨777','S003','1','249','100','2019-08-14 01:22:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨778','S001','8','986','98','2019-04-28 23:18:14','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨779','S001','8','827','81','2017-08-14 23:50:27','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨780','S001','1','489','38','2018-04-20 20:44:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨781','S004','8','197','96','2019-05-14 01:15:58','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨782','S005','5','1000','50','2017-08-02 20:33:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨783','S004','3','225','63','2018-11-09 17:30:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨784','S005','7','105','10','2020-01-12 00:12:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨785','S001','7','179','15','2020-03-02 17:38:21','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨786','S005','1','652','10','2017-03-13 15:30:59','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨787','S002','2','608','14','2018-03-16 23:48:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨788','S005','7','527','12','2017-12-16 08:55:21','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨789','S003','6','155','100','2018-11-10 18:05:57','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨790','S001','1','907','72','2019-08-18 12:55:22','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨791','S005','1','655','53','2018-05-03 10:10:27','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨792','S004','6','182','78','2017-10-22 10:32:34','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨793','S002','6','509','12','2018-07-19 06:05:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨794','S002','2','166','12','2017-05-01 17:09:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨795','S001','7','821','32','2019-08-17 16:42:27','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨796','S001','5','794','28','2017-08-11 10:50:59','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨797','S001','6','908','28','2017-06-16 07:47:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨798','S005','5','641','65','2018-06-29 15:52:17','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨799','S003','5','941','31','2018-02-09 13:53:12','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨800','S001','2','54','15','2019-09-22 13:01:00','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨801','S001','6','957','32','2019-06-01 20:46:58','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨802','S005','3','370','10','2019-04-05 18:43:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨803','S002','6','708','34','2018-11-01 22:59:03','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨804','S004','1','724','13','2017-09-12 03:30:20','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨805','S002','2','393','13','2018-12-23 19:27:51','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨806','S002','1','993','97','2019-03-23 07:19:42','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨807','S001','6','444','59','2019-03-20 04:26:44','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨808','S005','5','246','41','2018-05-14 16:37:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨809','S002','6','291','81','2018-01-09 17:57:45','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨810','S005','6','229','53','2020-02-02 05:00:07','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨811','S001','5','702','12','2019-10-25 01:30:34','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨812','S001','2','422','65','2017-11-18 09:34:22','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨813','S001','7','480','52','2017-11-17 21:27:27','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨814','S001','3','968','55','2017-05-14 02:27:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨815','S001','5','326','54','2017-04-08 05:06:33','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨816','S003','7','300','56','2018-05-09 17:55:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨817','S005','2','465','46','2019-05-10 06:26:12','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨818','S001','1','739','32','2018-08-30 11:24:39','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨819','S002','2','261','75','2019-05-17 08:10:33','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨820','S004','5','558','96','2019-09-06 00:16:27','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨821','S003','1','709','37','2017-08-08 18:20:10','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨822','S001','2','828','64','2019-03-11 23:33:26','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨823','S005','7','698','69','2019-09-21 17:35:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨824','S001','4','822','61','2017-08-22 07:23:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨825','S005','8','118','46','2017-03-19 22:57:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨826','S003','6','223','75','2019-10-01 19:34:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨827','S002','7','162','14','2019-03-17 21:49:03','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨828','S001','6','906','42','2017-07-15 04:37:18','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨829','S002','1','640','67','2019-05-09 02:03:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨830','S002','4','387','16','2018-03-25 17:50:41','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨831','S005','2','325','40','2019-07-20 02:52:43','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨832','S005','2','573','50','2018-06-14 14:09:41','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨833','S002','6','515','53','2018-02-19 21:49:34','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨834','S004','2','689','58','2019-08-06 14:49:06','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨835','S002','6','819','80','2019-05-04 11:38:42','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨836','S004','3','532','98','2018-10-24 00:27:05','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨837','S003','2','466','74','2018-02-17 00:43:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨838','S004','6','234','37','2019-06-07 13:00:14','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨839','S004','6','581','98','2017-06-14 16:03:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨840','S005','4','262','27','2018-09-11 01:17:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨841','S005','4','849','37','2017-09-04 08:58:55','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨842','S004','8','953','48','2019-06-22 18:41:49','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨843','S002','7','18','17','2018-02-28 14:18:40','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨844','S005','1','428','45','2019-12-27 15:09:05','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨845','S001','4','827','52','2019-01-30 05:06:30','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨846','S005','6','684','90','2017-03-12 22:38:26','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨847','S004','4','984','59','2017-12-13 09:41:35','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨848','S003','2','616','83','2018-08-23 19:47:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨849','S003','5','569','24','2019-08-10 18:25:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨850','S002','4','953','56','2019-12-27 16:06:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨851','S001','1','792','49','2019-06-09 21:47:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨852','S001','3','625','92','2018-07-18 00:45:34','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨853','S002','4','348','63','2019-07-24 02:55:42','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨854','S004','4','922','93','2017-04-09 21:57:27','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨855','S005','3','601','39','2017-05-30 15:29:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨856','S002','6','512','58','2019-12-22 19:05:14','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨857','S002','8','313','86','2017-11-13 12:34:47','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨858','S003','5','595','78','2017-09-19 17:22:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨859','S005','8','898','58','2018-09-26 07:57:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨860','S002','3','222','89','2019-02-07 21:11:48','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨861','S002','3','906','70','2017-08-12 00:40:25','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨862','S001','8','620','44','2019-09-29 14:00:40','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨863','S003','2','215','86','2019-06-04 09:21:33','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨864','S003','1','530','32','2019-08-04 17:24:21','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨865','S004','6','277','74','2017-04-23 13:04:03','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨866','S005','7','688','71','2020-02-23 12:50:33','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨867','S003','7','195','24','2018-04-27 20:43:06','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨868','S004','8','409','55','2019-12-01 19:40:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨869','S003','7','375','52','2017-03-30 12:57:22','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨870','S004','6','255','58','2018-08-11 21:05:59','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨871','S001','2','938','54','2018-11-13 00:56:27','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨872','S004','8','429','26','2017-05-20 12:18:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨873','S002','3','930','84','2017-10-01 09:30:48','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨874','S001','1','11','71','2018-04-02 12:17:40','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨875','S001','8','146','23','2019-10-25 11:29:26','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨876','S005','5','365','95','2019-02-07 12:16:20','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨877','S004','5','252','28','2019-10-24 03:48:30','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨878','S005','6','517','96','2018-02-16 20:22:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨879','S004','2','73','61','2019-07-29 12:10:00','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨880','S001','7','796','74','2018-09-20 18:36:48','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨881','S001','3','989','32','2018-02-14 23:37:57','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨882','S002','8','251','89','2017-07-29 00:09:12','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨883','S003','5','395','87','2018-07-24 09:00:01','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨884','S002','8','66','18','2017-10-26 13:13:51','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨885','S001','7','567','33','2017-05-10 00:27:27','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨886','S004','1','702','44','2018-12-16 02:46:21','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨887','S005','7','588','20','2019-09-01 18:39:51','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨888','S003','5','949','82','2018-04-16 23:19:01','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨889','S001','5','276','95','2019-10-31 16:52:19','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨890','S005','6','447','47','2018-04-22 03:22:52','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨891','S001','7','756','14','2018-10-08 19:47:52','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨892','S005','2','780','58','2019-12-10 16:59:40','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨893','S001','8','863','36','2018-12-01 14:53:31','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨894','S005','3','337','40','2018-09-22 14:03:49','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨895','S004','6','112','29','2019-04-24 03:09:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨896','S001','2','517','11','2020-02-07 22:34:32','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨897','S005','1','174','37','2018-09-19 19:35:58','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨898','S003','6','551','64','2018-11-17 18:33:49','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨899','S001','3','409','96','2019-09-19 02:24:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨900','S003','3','336','67','2017-08-13 04:48:45','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨901','S001','5','250','14','2017-05-09 12:51:20','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨902','S001','5','999','11','2018-03-07 15:17:49','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨903','S004','2','703','95','2019-10-05 17:17:13','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨904','S001','8','351','69','2019-08-06 03:46:27','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨905','S004','4','625','31','2017-09-16 23:52:07','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨906','S002','7','28','73','2019-02-02 10:38:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨907','S005','8','23','95','2019-08-10 05:08:42','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨908','S005','2','687','61','2018-10-27 22:35:00','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨909','S003','4','808','10','2018-11-10 06:06:30','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨910','S003','7','369','53','2019-06-25 03:26:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨911','S002','5','392','75','2019-03-20 12:20:38','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨912','S001','5','264','11','2017-10-09 00:07:56','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨913','S005','4','598','95','2019-12-30 13:03:06','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨914','S003','6','264','66','2019-04-16 05:12:44','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨915','S002','2','917','19','2018-05-25 08:09:11','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨916','S004','5','873','42','2018-02-11 02:17:23','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨917','S004','6','12','48','2019-10-29 00:06:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨918','S001','8','314','58','2018-03-18 09:28:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨919','S005','6','807','31','2019-07-21 23:09:01','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨920','S005','4','81','87','2018-06-21 12:59:45','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨921','S001','1','818','82','2018-02-03 10:28:58','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨922','S003','4','516','79','2018-03-19 02:45:59','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨923','S002','4','683','76','2018-03-06 18:45:36','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨924','S003','1','891','15','2018-07-12 04:30:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨925','S005','1','662','34','2019-03-10 03:37:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨926','S004','1','783','17','2019-03-02 11:46:52','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨927','S004','4','210','61','2018-07-03 04:43:44','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨928','S003','8','577','27','2018-01-25 07:57:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨929','S002','1','771','45','2017-09-01 19:33:08','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨930','S003','3','616','53','2017-11-28 19:34:16','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨931','S003','2','270','52','2018-09-30 13:27:12','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨932','S002','7','132','23','2017-06-20 07:00:11','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨933','S003','3','981','68','2018-05-30 17:58:51','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨934','S002','1','620','87','2019-11-12 18:21:04','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨935','S005','1','437','11','2019-12-16 18:34:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨936','S002','7','960','95','2018-08-17 03:01:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨937','S004','5','990','36','2018-04-15 04:21:57','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨938','S002','4','289','64','2019-10-30 08:53:07','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨939','S003','2','82','79','2018-12-13 17:24:40','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨940','S001','3','89','93','2018-11-22 18:40:34','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨941','S003','7','953','59','2018-10-08 19:09:44','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨942','S001','4','883','84','2020-02-12 18:49:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨943','S001','3','907','70','2018-01-01 02:56:29','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨944','S002','4','779','62','2019-06-12 00:40:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨945','S003','2','802','46','2018-08-25 14:40:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨946','S005','1','99','42','2018-06-15 00:35:20','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨947','S004','7','715','97','2017-05-13 13:58:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨948','S003','1','505','83','2018-02-04 06:12:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨949','S005','4','874','68','2019-11-13 00:00:59','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨950','S005','2','508','82','2017-12-03 12:34:36','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨951','S005','2','672','37','2019-10-15 13:01:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨952','S004','6','75','84','2017-09-23 09:02:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨953','S002','2','949','65','2020-02-13 13:39:35','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨954','S005','7','843','31','2018-05-11 07:52:42','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨955','S003','6','859','32','2018-08-17 03:22:35','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨956','S004','1','237','95','2018-12-12 05:27:50','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨957','S004','4','316','32','2018-09-11 18:54:01','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨958','S001','5','141','43','2017-10-31 06:08:18','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨959','S002','2','761','49','2019-12-25 20:32:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨960','S005','7','798','22','2018-08-09 04:42:19','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨961','S004','6','139','48','2020-01-19 06:35:47','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨962','S001','6','704','97','2018-05-04 22:11:23','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨963','S003','6','120','36','2019-12-11 07:49:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨964','S001','4','960','42','2020-02-29 18:19:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨965','S002','5','454','59','2019-09-13 07:37:11','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨966','S003','8','243','51','2018-12-10 23:54:37','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨967','S001','6','19','53','2019-01-15 05:18:21','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨968','S005','1','989','47','2018-12-05 10:46:17','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨969','S001','7','801','87','2017-12-27 16:20:50','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨970','S005','4','758','99','2019-11-08 15:28:53','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨971','S003','7','70','27','2017-08-07 05:17:18','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨972','S001','4','826','51','2019-08-02 17:42:55','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨973','S002','1','40','92','2018-08-17 07:39:02','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨974','S004','1','553','47','2018-11-12 23:22:01','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨975','S001','4','857','60','2017-05-06 11:16:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨976','S005','8','656','20','2017-12-02 13:29:49','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨977','S001','3','164','50','2019-08-11 11:55:23','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨978','S002','3','263','58','2018-12-12 08:30:54','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨979','S005','7','429','81','2017-05-18 09:08:25','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨980','S004','3','521','85','2019-08-30 21:35:18','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨981','S001','6','547','24','2017-11-11 13:24:46','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨982','S003','3','381','26','2018-11-18 09:50:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨983','S005','4','619','30','2019-09-14 12:07:05','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨984','S002','6','845','60','2018-05-23 03:51:24','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨985','S003','6','411','35','2017-06-08 08:33:07','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨986','S004','4','357','23','2018-12-30 22:35:57','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨987','S003','2','844','88','2017-10-31 10:40:44','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨988','S005','4','695','80','2019-05-08 06:00:12','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨989','S005','4','440','12','2019-09-27 21:33:34','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨990','S003','2','451','43','2018-04-07 00:36:03','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨991','S001','3','102','21','2019-07-19 13:34:28','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨992','S001','4','886','97','2018-05-04 00:17:11','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨993','S004','3','32','74','2019-09-24 10:15:15','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨994','S001','6','472','69','2017-03-24 02:28:22','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨995','S005','6','518','13','2017-08-18 06:01:48','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨996','S001','8','244','37','2019-12-31 00:07:10','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨997','S005','6','990','76','2018-07-18 04:55:44','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨998','S004','2','832','64','2019-03-10 06:11:55','產地：','最高品質的咖啡，感受手作的溫度。'),
('好貨999','S001','4','851','88','2018-10-15 05:00:54','產地：','最高品質的咖啡，感受手作的溫度。'); 



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

INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165356,236);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165248,169);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164867,126);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165181,170);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164592,123);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165102,194);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165013,243);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164923,230);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165141,83);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165238,2);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165109,141);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165098,155);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164429,119);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164637,186);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164926,35);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164487,150);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164862,162);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164566,169);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164949,18);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164497,167);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165097,35);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164429,133);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165225,217);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164663,2);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165234,46);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165078,83);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165070,243);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165062,184);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164827,17);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164590,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164420,21);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164772,48);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164562,60);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164890,23);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165181,219);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165348,9);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164519,75);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164421,49);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164604,157);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164652,205);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164690,126);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164465,107);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165410,198);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164887,89);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164676,217);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164834,235);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165208,136);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164484,184);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165141,217);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165016,25);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165309,138);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165281,150);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165118,196);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165368,225);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164800,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165035,25);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164675,221);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165013,183);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164523,142);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164692,155);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164458,188);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165286,125);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165263,87);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165132,83);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165170,75);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164874,52);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165134,137);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164703,125);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164647,46);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164695,43);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164426,192);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164670,130);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164623,87);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164979,35);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165176,102);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164428,201);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165353,1);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165030,40);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164904,159);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164724,130);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164517,51);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165092,222);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164775,9);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165028,58);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164812,75);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164995,219);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165277,180);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164529,150);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164640,150);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165061,62);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164989,168);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164848,201);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164790,181);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164561,192);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165111,51);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164833,44);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164552,177);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165131,22);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165234,103);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164542,241);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165254,92);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165300,193);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164890,1);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165266,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165380,49);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164767,48);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164554,192);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164575,93);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164921,232);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165243,96);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165286,93);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164785,220);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165391,197);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164689,40);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164953,45);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165385,90);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165124,65);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165233,5);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165299,62);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164600,242);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165201,139);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164572,113);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164680,141);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164562,201);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165065,114);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164545,209);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164573,236);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164912,162);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164792,231);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165321,176);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164641,152);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165173,6);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164451,231);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165289,84);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165191,222);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165255,101);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164853,111);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165251,230);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165319,148);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165048,96);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164873,182);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165394,186);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165117,175);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164575,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164763,232);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164785,117);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164851,129);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165138,202);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165251,29);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164560,93);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165259,60);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165177,22);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165026,191);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165130,196);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164588,76);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164935,28);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164969,163);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164651,93);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165329,2);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164853,5);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165227,22);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164776,115);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164552,221);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165176,174);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165168,64);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164480,44);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164862,157);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165284,91);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165405,150);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165048,107);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164844,53);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165123,40);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164927,112);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164461,23);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165083,221);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164589,55);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164691,85);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165191,144);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164927,137);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164728,187);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164494,209);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165177,155);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164529,219);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165166,160);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165029,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165024,90);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164810,150);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165056,134);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165331,102);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165188,235);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164926,118);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165026,66);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164700,205);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165346,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165177,9);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164967,34);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164816,160);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165002,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164902,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164509,179);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164542,58);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164840,143);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164733,90);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164673,94);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164692,171);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164786,22);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165005,195);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165010,1);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164436,129);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164816,60);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165416,209);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164451,193);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164901,7);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165103,153);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165238,29);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165016,160);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165032,217);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164691,217);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164843,109);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164881,179);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164560,42);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164643,126);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164975,45);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164740,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164476,120);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165401,100);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164758,6);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165291,91);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165140,134);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164500,62);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164434,130);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164945,34);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164743,185);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165066,190);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164499,40);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165099,32);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165274,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164460,195);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165276,21);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165018,43);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164667,38);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164544,177);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165205,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164938,46);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164452,207);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164577,68);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165297,2);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164686,201);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164917,194);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164656,202);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164518,210);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165251,209);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165217,159);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165258,161);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164956,74);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164774,50);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164782,176);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164712,186);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164494,59);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165309,187);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164612,206);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164966,83);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164716,232);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164515,59);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164596,17);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165130,155);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164452,31);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164897,110);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165332,72);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165034,14);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165136,133);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164685,95);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164521,42);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164885,63);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164671,83);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164415,10);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164691,204);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165357,81);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165282,144);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164868,106);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164557,4);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165343,51);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164570,95);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164939,227);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165414,158);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165140,168);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164992,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164551,205);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165381,230);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165030,15);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165239,4);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164564,194);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164880,173);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165148,224);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165271,47);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165313,234);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165217,24);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164993,104);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164704,148);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165278,217);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164565,191);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164468,125);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164718,32);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164490,3);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164785,140);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164590,168);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164879,69);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164632,89);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164610,119);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165030,190);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165073,190);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165317,23);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164705,223);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164524,239);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164766,35);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164684,48);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164652,102);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164444,91);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164728,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164460,220);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164989,115);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164835,58);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165051,133);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165178,101);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165002,127);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165345,200);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164633,31);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165167,217);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165204,87);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164773,235);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165340,64);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164529,168);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164541,158);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164849,133);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164474,222);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164888,179);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164983,156);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164687,56);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164757,219);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164826,7);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164729,69);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164952,86);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164551,187);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164698,240);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164652,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165105,123);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164619,1);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165232,136);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164847,199);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165274,233);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164718,108);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165372,51);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165260,84);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165147,220);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164781,107);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165022,122);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164430,243);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164760,194);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165172,75);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164760,186);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165081,66);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164701,224);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165388,58);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164452,67);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164624,31);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165280,91);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164969,130);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165136,118);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164934,160);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164931,231);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165058,116);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164973,236);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165391,179);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164587,150);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164959,100);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164773,70);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165291,12);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165106,162);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165292,111);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164726,101);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165283,210);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165084,233);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164982,137);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164819,233);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164874,187);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164902,122);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165375,85);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164479,158);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165279,120);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165325,182);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165085,36);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165187,174);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164900,145);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164729,130);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164420,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164892,233);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165286,98);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165306,20);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165173,124);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164786,25);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164754,79);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165358,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164694,222);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165191,106);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164528,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165072,44);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164604,203);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164417,33);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164975,177);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165416,2);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164651,172);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165130,188);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164515,90);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164669,14);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164830,26);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164566,162);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164915,241);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164811,139);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165267,179);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165203,33);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164670,80);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165184,184);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164771,128);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165178,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165222,182);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164675,42);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164492,160);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165344,49);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164473,66);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164961,111);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164653,182);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164822,34);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165370,147);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165402,139);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165054,23);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164909,30);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165133,168);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164671,227);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164727,123);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164974,162);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165110,123);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164474,112);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164439,149);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165153,42);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164844,64);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164460,28);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164875,58);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165272,9);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165333,81);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164708,224);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164589,152);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165214,24);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164481,36);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165117,243);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164869,63);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164633,99);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165363,101);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165267,129);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165064,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165340,13);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164579,126);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165262,18);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165389,204);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164578,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165160,153);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165329,40);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164613,76);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165084,80);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164686,137);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165225,35);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165199,66);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164485,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164908,126);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164615,8);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165291,61);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165134,197);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164840,21);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164499,99);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164814,161);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164803,79);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165338,172);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165291,175);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165066,80);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164963,22);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164467,188);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164910,229);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164453,70);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165230,107);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165401,171);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165250,81);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165044,55);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165221,128);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164899,171);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164924,121);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164448,1);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165227,110);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164940,75);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164767,154);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165006,23);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165202,235);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165286,119);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164437,138);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164773,223);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165284,45);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165373,30);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165180,47);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164629,229);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164893,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164609,53);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164597,62);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164516,56);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164946,98);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164707,39);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164765,198);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165085,63);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165304,78);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165154,75);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165202,83);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164831,61);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164699,26);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165401,164);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165114,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165099,116);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165319,34);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164675,9);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164612,171);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164858,16);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164977,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165318,144);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164423,82);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165046,70);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164583,52);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165414,76);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165355,51);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164670,27);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164956,70);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165269,5);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165144,226);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164744,3);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165103,193);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165276,61);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165391,214);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165198,102);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165172,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165409,165);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164482,173);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165116,37);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164941,43);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165076,56);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164921,149);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165317,133);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165015,161);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165222,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165054,170);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165049,52);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164825,108);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165252,197);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164600,201);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165006,153);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164692,114);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165123,44);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164726,97);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164558,162);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164522,231);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164906,50);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164646,204);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165268,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164541,97);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164420,73);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164915,188);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164923,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164918,217);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165049,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164629,178);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165143,199);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165269,27);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164974,22);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164525,32);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164564,28);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164909,141);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165253,22);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165312,66);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164562,127);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165142,186);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164711,115);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164543,239);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164841,145);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165271,100);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164516,100);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164875,56);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165112,223);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164423,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164423,24);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164429,59);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164552,133);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164935,163);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164791,57);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165009,85);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164898,63);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165355,6);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165304,75);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165209,214);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165063,164);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165364,168);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164701,225);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165009,82);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165112,38);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164945,33);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165056,157);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165034,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165020,201);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165403,80);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165076,211);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164995,101);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164571,207);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164788,232);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164741,89);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164664,10);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165345,105);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164976,157);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164805,150);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165148,115);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164783,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164866,70);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164763,17);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165188,78);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165391,66);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165416,42);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165349,29);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164754,200);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165071,12);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164522,120);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164452,174);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165092,99);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164758,130);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165092,41);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165351,212);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165058,52);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165011,212);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165194,192);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164532,161);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164756,12);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164877,126);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165299,51);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164509,126);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164806,199);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165050,188);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164844,189);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164703,216);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164566,195);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165218,1);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164504,207);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164878,141);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164691,153);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164602,57);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164818,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165215,178);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164694,167);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164529,83);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165200,230);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165223,170);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165030,2);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165364,165);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164693,125);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164787,8);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164829,31);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165285,226);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164665,196);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164757,75);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165114,151);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164829,160);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165113,6);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165028,22);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165331,171);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165292,229);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165411,201);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165277,170);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165306,232);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165284,211);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164929,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165344,191);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165334,227);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164926,170);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164574,89);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164515,120);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165017,145);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165336,151);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164939,117);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164481,141);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164899,191);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164829,198);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164908,13);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164925,185);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165359,63);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165209,8);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165411,104);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164820,124);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165231,170);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164893,109);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164711,203);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164698,30);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165347,221);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164482,38);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164691,34);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165104,64);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165209,67);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164731,133);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165400,116);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165383,23);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164509,6);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165260,241);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165132,166);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164415,129);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164968,82);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164626,97);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164994,59);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165110,221);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165273,167);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165123,31);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165052,208);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165036,229);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164897,73);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165246,235);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165342,148);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164480,74);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165188,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164732,45);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165249,94);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164682,92);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164799,106);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164424,148);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164586,140);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165091,7);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165323,242);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164450,24);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164779,112);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165172,125);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164606,219);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165161,238);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165303,120);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164648,63);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165251,35);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164788,67);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164703,110);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165354,172);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165275,160);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165007,150);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165375,106);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165125,59);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164976,124);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165313,131);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164804,151);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164737,215);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164667,96);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164722,126);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165402,140);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164907,196);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165025,233);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164830,120);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164767,115);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164973,186);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165390,2);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164578,134);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164981,176);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164582,176);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164844,223);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165164,96);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164545,163);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165029,194);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164779,105);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164513,129);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164542,126);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165214,201);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164586,5);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164769,73);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165369,135);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164940,3);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164850,56);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165012,220);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165044,24);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164805,154);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164768,100);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164893,195);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165063,44);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164712,86);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164643,194);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165106,35);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164789,241);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164766,105);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164880,57);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164450,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164943,6);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165140,112);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165005,30);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165108,223);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164652,227);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164495,159);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164803,11);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165270,174);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165052,170);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165352,21);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165178,44);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164667,89);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164975,24);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165036,4);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164512,172);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164857,159);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165215,181);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165022,164);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165193,92);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164485,58);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164547,97);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164468,87);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165130,206);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165117,115);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165154,145);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165014,188);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164951,101);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165154,222);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164640,40);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164950,166);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165268,165);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164836,149);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164591,158);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165154,224);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164663,124);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164878,152);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164499,3);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164832,221);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165389,238);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164496,135);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164630,129);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165058,209);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164868,96);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165091,41);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165074,36);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164423,236);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164667,60);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164875,168);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165380,107);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164796,54);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164602,76);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164515,60);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165105,131);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165010,15);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165405,6);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164540,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165212,212);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164488,21);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164901,159);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164612,16);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164796,72);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165166,62);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164616,241);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165376,161);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164521,8);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164831,89);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165149,166);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164719,135);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164889,175);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164458,103);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164729,54);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165195,211);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165396,225);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164413,182);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164684,10);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164556,114);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164930,7);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164454,238);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165109,120);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165188,98);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164609,40);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164648,167);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164952,75);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164519,127);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165267,45);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165319,69);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165408,21);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164999,37);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164430,235);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164863,102);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165373,52);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164811,157);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165107,137);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165009,112);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165410,158);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164775,10);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165141,191);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164727,18);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165242,9);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165095,73);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164641,208);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164705,150);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164978,81);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164839,114);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164540,175);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164524,122);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165312,37);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165240,170);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164942,233);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165122,140);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164465,168);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164916,52);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164478,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164794,182);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165277,118);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164627,126);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164689,42);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164811,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164680,83);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164545,214);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165303,117);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165213,89);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164504,113);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165227,10);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165141,130);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165294,237);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164595,176);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165283,127);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164515,37);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164983,180);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165372,50);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164446,159);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165361,211);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164915,222);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164973,61);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164765,49);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165280,73);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164747,243);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165354,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165364,136);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164468,51);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164534,155);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164550,176);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164693,182);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165259,102);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164501,12);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165003,74);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164661,193);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165331,35);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165403,84);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164440,64);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164457,44);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164729,78);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164688,149);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164768,21);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165322,80);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164574,42);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165291,156);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164481,101);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164861,4);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164455,183);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165354,63);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164891,36);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165133,184);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165372,64);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165030,232);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164943,159);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164661,203);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165362,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164485,170);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164892,76);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164719,197);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165359,54);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164751,7);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164637,202);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164471,7);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165081,121);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165306,28);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164706,117);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164553,67);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165152,18);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164772,81);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164443,190);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165228,156);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164682,144);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165379,65);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165086,40);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165206,160);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165045,188);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164992,69);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165008,199);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164809,236);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164969,116);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164700,51);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165384,185);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165322,74);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165231,201);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165216,143);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165268,40);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164589,154);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165062,126);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164817,238);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165302,129);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164976,236);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164718,68);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164939,160);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165145,174);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164677,52);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164680,58);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164895,78);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164794,66);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164791,196);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165350,66);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165043,54);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165043,152);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164791,155);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164935,45);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164856,234);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164793,140);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164889,168);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164419,151);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164600,205);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164423,227);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165121,39);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164706,154);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164719,22);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165294,68);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164497,17);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164980,84);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164874,209);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164998,174);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164442,107);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164705,228);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165403,78);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164548,109);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165043,189);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164753,172);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164856,115);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165135,82);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165075,102);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164970,67);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165010,94);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165074,146);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164798,73);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164579,101);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164538,168);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164516,220);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164530,74);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164938,27);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164914,144);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164458,201);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164461,198);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165413,225);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165020,111);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164740,134);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164661,230);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164448,168);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164781,76);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165338,219);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165358,28);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164507,48);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165365,146);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164901,26);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165056,147);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164538,70);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164526,197);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165238,242);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165268,234);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165245,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165026,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164518,90);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165023,209);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164651,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164553,133);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164735,65);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164973,28);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164873,156);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164830,37);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164635,134);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164816,153);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165269,155);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165047,203);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165373,124);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164664,29);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164452,26);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164440,2);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164586,86);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164560,102);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165210,227);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165108,86);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164916,86);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165013,199);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165155,45);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165263,146);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164793,51);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165151,203);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165176,202);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165117,197);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165031,91);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165410,79);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165340,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164982,105);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164942,232);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164820,109);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164929,165);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165132,193);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165191,198);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164416,148);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164552,68);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164573,48);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164468,17);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164919,39);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165217,11);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165077,57);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165357,55);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164994,26);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164978,145);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164933,164);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164703,172);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165336,232);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164619,68);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165280,157);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164529,193);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164575,69);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165027,209);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165307,118);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164922,45);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164555,193);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164808,23);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165314,140);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164504,178);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164528,203);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164946,38);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165343,38);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165345,241);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164486,93);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165036,176);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164826,89);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164452,84);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164685,175);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164637,193);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164548,153);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164445,230);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165344,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165192,31);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164606,43);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164864,238);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165001,86);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164930,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164432,172);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165038,134);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164891,74);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164961,182);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164554,70);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165383,53);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165071,49);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164803,72);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164983,32);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165068,125);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165237,111);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165415,53);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164495,119);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165134,156);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164945,87);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165031,117);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164452,226);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164623,64);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165192,146);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165075,48);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165396,195);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164427,224);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164631,222);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165354,75);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164986,67);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165334,82);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164489,89);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165362,185);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164672,110);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164782,6);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164838,105);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165026,188);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164552,217);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164458,228);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164500,180);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164955,202);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165355,115);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165196,53);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164743,96);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165206,35);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164543,119);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164446,41);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165112,47);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164538,37);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164993,138);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165051,227);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164983,200);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164687,204);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164716,113);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164917,12);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165389,59);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164933,80);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165174,219);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165012,91);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164796,156);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165371,215);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165014,51);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165216,234);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165058,99);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164593,34);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164753,155);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165264,18);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165245,194);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164976,89);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164711,34);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164867,118);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164955,43);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165016,18);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164989,31);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165365,34);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164511,65);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165342,131);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164443,154);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164457,63);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164968,93);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164602,123);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165299,223);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164818,199);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165374,167);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165361,115);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165039,113);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164782,45);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165062,38);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164508,50);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164916,138);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165243,1);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165279,174);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164817,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165231,85);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164792,34);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165130,137);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164687,179);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164765,90);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165006,26);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165213,92);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164468,166);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165300,62);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165031,241);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164421,100);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164455,94);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165162,15);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164765,140);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164659,157);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165074,192);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164469,52);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164577,141);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164594,14);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165376,208);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164878,74);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164926,64);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165158,185);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164499,90);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164492,202);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165109,55);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164572,202);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165347,156);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164612,120);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164951,210);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164630,174);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164953,217);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165386,212);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165342,109);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164925,1);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165137,55);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164658,229);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165259,150);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164725,222);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165308,175);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165150,56);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164550,220);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164730,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164968,33);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164670,17);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165273,231);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165408,234);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165119,210);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165307,217);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164707,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164500,96);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164859,39);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164543,6);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164553,227);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165120,94);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164550,150);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164627,95);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165387,203);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165388,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164697,173);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164547,26);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165414,16);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165328,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164942,22);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165034,149);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164437,115);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164581,154);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165117,13);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164770,116);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164999,50);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165185,165);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164444,187);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164551,204);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165367,75);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164906,224);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164984,49);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165268,94);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164666,78);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164961,217);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165065,192);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164923,82);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164850,147);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164818,95);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164634,239);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164633,52);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165407,168);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165280,149);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165010,177);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164660,173);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164428,187);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165298,179);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165138,112);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164778,159);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164799,189);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164827,222);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164521,108);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165174,37);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164895,8);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165066,159);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164908,168);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164971,89);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165104,136);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165337,120);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164885,16);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164945,97);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164727,152);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165133,122);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164827,86);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164557,177);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165186,161);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164444,47);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165127,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164632,9);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165210,115);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165329,110);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164835,205);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164714,93);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165191,243);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165020,64);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165195,142);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164666,47);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164603,8);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164635,229);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164563,179);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164884,3);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164801,211);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164875,240);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165141,221);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165288,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164607,157);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165369,164);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165341,40);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165203,144);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165399,37);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164653,33);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164915,74);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164725,61);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165029,81);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165042,166);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164643,67);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164875,124);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164514,46);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165228,159);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165120,242);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164802,120);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164827,127);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164807,95);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164624,177);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164840,142);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164974,197);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165037,18);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165319,13);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164519,195);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164975,36);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165345,209);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165101,141);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164938,170);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165399,126);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165297,221);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165307,90);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165279,24);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165345,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165197,220);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165141,147);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165330,70);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165004,208);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165163,97);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164719,194);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165114,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164684,126);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164668,66);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164681,93);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164925,27);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165321,214);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164484,8);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164535,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165247,46);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165406,96);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165236,212);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164589,184);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165007,222);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165141,198);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164651,68);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164449,192);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164462,95);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165004,238);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164848,150);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164580,133);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164678,98);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165087,55);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165168,175);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164885,81);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165338,207);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165157,222);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164667,235);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165012,212);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165005,178);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165387,32);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164724,133);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164566,214);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165295,101);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164780,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164451,162);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165026,54);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165026,140);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165129,174);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165356,56);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164901,228);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164935,231);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164556,202);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164420,79);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165143,210);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164521,169);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164520,170);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165401,76);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165215,18);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164966,43);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165000,117);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164734,222);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164838,86);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164658,188);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164766,83);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165319,31);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165292,157);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165413,136);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164858,39);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165224,119);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164913,101);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164578,136);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165134,116);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164440,15);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165142,149);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164572,110);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165234,167);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165135,36);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165148,212);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164755,89);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164489,82);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165262,1);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165186,195);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164626,92);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165391,112);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164903,150);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165085,150);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165395,75);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164602,10);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165048,174);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165348,2);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165321,136);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164441,192);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165041,226);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164472,210);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164856,16);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164545,90);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165391,64);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164501,73);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164875,174);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164645,12);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164878,200);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165163,227);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164430,22);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165377,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164931,158);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164552,48);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165224,205);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164846,148);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164824,131);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165324,169);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164462,21);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165283,218);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164714,161);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165288,83);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165136,105);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165259,140);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165013,85);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165056,100);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164596,2);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164735,14);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164878,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164690,212);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165143,129);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165008,24);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165390,10);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164826,28);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164805,134);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165057,163);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164522,131);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164552,4);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165104,177);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164935,192);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165312,79);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164685,206);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164801,141);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164564,199);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164627,128);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164537,200);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164436,81);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164910,21);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164673,120);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165098,80);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164614,218);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164660,80);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164771,31);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164451,207);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164770,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164433,29);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164923,233);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164591,216);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165295,214);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164824,184);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164514,26);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165011,164);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165176,65);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164837,107);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165079,63);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164892,170);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164534,91);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165287,72);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164854,186);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165099,185);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165343,163);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164712,63);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164546,33);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165171,145);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164645,156);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165032,124);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164996,5);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165257,229);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164600,146);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164470,232);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164759,14);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164593,64);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165023,181);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164461,202);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164495,79);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165085,125);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165010,146);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165183,235);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164523,49);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165193,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164763,179);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164444,120);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164690,5);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164985,57);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164652,151);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164526,29);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165179,94);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165121,100);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165280,84);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165294,51);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164842,177);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164797,60);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164819,122);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165104,25);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165282,22);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165197,38);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165373,7);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165042,223);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165281,9);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164518,39);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164891,186);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164932,163);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165032,46);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165225,104);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165359,40);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164518,35);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165269,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164732,24);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164819,242);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164891,72);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165140,35);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164701,63);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165058,219);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164519,112);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165350,42);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165181,142);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164620,170);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165363,99);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164685,123);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164493,45);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165112,198);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164474,51);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164736,130);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164522,153);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165375,223);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165103,8);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164448,179);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164909,82);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165189,91);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164775,8);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164829,14);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164735,52);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165216,236);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165252,76);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164435,150);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164642,111);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164926,72);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165058,144);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164432,97);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165413,110);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164828,198);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164754,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165229,229);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165138,43);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165177,111);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165149,108);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164421,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164510,124);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164442,104);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165189,67);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165199,43);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165093,146);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164645,206);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164511,202);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164825,7);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164740,152);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165041,145);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165147,108);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164489,85);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164737,234);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164497,25);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164758,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165235,163);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164606,215);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164973,181);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165296,224);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165048,163);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164884,156);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165281,28);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165248,56);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165416,33);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164825,121);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164433,40);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164638,23);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165410,11);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164773,140);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164548,181);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165184,59);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165390,80);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165347,69);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164807,121);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165125,127);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165080,175);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164422,81);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164670,40);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164968,166);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164584,157);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164643,214);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165258,34);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164863,2);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164677,46);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165293,110);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165233,227);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164558,96);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165136,91);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164805,239);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165007,14);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165131,156);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164428,20);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164966,155);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165034,197);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165002,72);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165406,200);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164860,72);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164431,159);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164528,68);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164611,32);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164548,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165315,105);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164452,70);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164726,214);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164846,45);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164635,100);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164612,221);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165070,64);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165292,237);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164848,62);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165247,8);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164474,208);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165188,225);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165415,184);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165252,27);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165319,173);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165138,228);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165286,168);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165211,168);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165379,93);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164587,101);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164948,120);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164483,12);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164545,15);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164636,50);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165253,63);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165063,60);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164709,223);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165129,199);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164892,115);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164917,178);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165164,139);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164917,8);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164702,20);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164933,218);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165174,93);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165350,118);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164560,35);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165111,3);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165137,12);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165291,129);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165183,129);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165049,59);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164662,86);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164762,27);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165308,179);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164816,195);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164446,32);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164493,14);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165381,60);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164646,62);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164918,118);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165264,195);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165293,124);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164691,158);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164605,34);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164572,220);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165166,149);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165207,82);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164556,173);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165265,163);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164748,112);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164900,73);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164757,205);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164806,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164660,236);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164889,93);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165089,223);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164744,26);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165414,29);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164626,104);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165183,219);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164725,136);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164856,4);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164417,89);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165411,214);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164844,232);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164563,17);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165218,64);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164509,104);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164968,139);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165322,114);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164889,33);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165164,196);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164682,24);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164666,25);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165150,195);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165266,178);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164660,128);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165201,128);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165206,195);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165131,121);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164990,163);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165054,182);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164604,174);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165349,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164669,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165088,70);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164788,166);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164852,222);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165048,181);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165088,21);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164783,76);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164605,193);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164855,238);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164422,38);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165146,81);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165094,117);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165315,35);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164604,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165343,187);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165331,235);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164685,188);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164461,109);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165048,127);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164712,195);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164934,163);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164746,243);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165380,238);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165204,42);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165142,95);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164680,147);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165144,35);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164821,93);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164621,190);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164597,206);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164947,10);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164617,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164786,198);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164839,200);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164810,22);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164616,143);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164961,97);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164972,58);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165177,135);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164424,12);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164512,164);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164726,86);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165160,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165123,156);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164656,82);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165413,95);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164922,48);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164993,86);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164561,38);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164750,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165357,128);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164896,237);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165059,228);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164661,110);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165042,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164567,190);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164973,123);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164555,120);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164534,240);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164918,167);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164761,149);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165075,154);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164711,193);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164736,219);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164998,208);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165035,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164524,223);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164979,108);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164528,24);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165154,233);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164956,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164429,225);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164750,201);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164714,163);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164929,238);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165271,155);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164569,27);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164875,192);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165301,160);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164429,153);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164586,171);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165075,47);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164662,79);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164826,194);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165308,200);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165027,16);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164420,210);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165391,155);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164665,14);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165285,105);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164644,73);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164468,106);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164604,195);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164617,238);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164741,124);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165345,197);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165283,169);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164655,197);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164621,30);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165024,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165254,63);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165383,143);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164856,137);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165018,11);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165407,125);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164521,122);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164911,83);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165158,102);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165082,25);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164594,224);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164559,174);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164663,66);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164636,47);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164807,239);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165408,226);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164555,165);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165271,184);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164616,215);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164827,36);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165341,73);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165307,180);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164981,3);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164467,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165370,123);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164556,73);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164579,205);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164984,45);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164837,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165121,114);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165318,82);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165265,49);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165093,127);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164896,62);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165241,216);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164949,210);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165358,144);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165313,204);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165382,24);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164604,7);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165126,23);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164518,16);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164915,238);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164634,96);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165149,134);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165406,51);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164512,175);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164833,112);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165085,197);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165125,140);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165364,44);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165015,141);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164457,68);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164784,21);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164977,10);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164604,223);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165414,83);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165249,144);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164994,104);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164966,131);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164533,142);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165155,79);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164523,111);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165017,111);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165360,169);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165323,239);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164723,17);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164421,94);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165192,66);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165250,112);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165339,201);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164746,152);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165288,69);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165172,220);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165120,189);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164746,101);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165332,110);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165334,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164613,75);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164449,2);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164431,242);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164698,98);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165218,165);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164562,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164530,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164766,237);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165354,125);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164763,237);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165016,185);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165285,207);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165076,128);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165254,205);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164956,44);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164895,84);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165069,102);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165088,197);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164544,193);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165234,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164423,20);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164491,241);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164928,22);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164575,134);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165412,189);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165244,116);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165296,242);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164667,118);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164605,26);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164928,32);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164874,147);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164913,90);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164664,235);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165123,167);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164896,105);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165056,45);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164484,211);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164592,67);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164580,187);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164577,229);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164494,165);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164459,59);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164424,224);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164701,143);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164958,54);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165225,196);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164548,111);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165009,171);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165107,222);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164662,103);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165105,112);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164923,146);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164428,78);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164740,109);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165144,184);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164562,103);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165051,237);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164595,236);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164583,176);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165198,210);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164593,65);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165016,124);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164483,17);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164560,74);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164448,109);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165173,104);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164614,142);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164466,169);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165015,184);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165136,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165306,172);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165342,172);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165201,24);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165140,96);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165289,229);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164637,200);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164767,5);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164538,125);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164426,191);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164927,54);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164873,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164425,79);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164628,31);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165079,165);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165207,153);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164908,202);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165074,12);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164742,166);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165108,169);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164550,122);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164769,76);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165302,230);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164922,122);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165011,81);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165214,17);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165054,152);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165207,34);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165127,49);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164503,98);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165203,124);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164922,34);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164438,165);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165194,139);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164616,230);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165182,218);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164846,172);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164515,78);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165236,58);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164602,207);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165345,164);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165069,214);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165294,135);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165396,228);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165278,163);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165177,179);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164445,116);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164609,233);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164970,73);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164602,38);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165205,223);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164440,176);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164724,18);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164865,195);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165253,243);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164983,220);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164623,76);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164420,44);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164437,151);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165223,2);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165092,9);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164497,205);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164475,145);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165270,155);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165227,85);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164793,16);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164526,47);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164429,18);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165233,140);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164879,200);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165364,139);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164649,195);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165085,241);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164640,39);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164959,218);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165256,7);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165080,120);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164892,220);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165048,26);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164462,115);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165337,70);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165305,211);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164840,166);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165071,125);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164583,241);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164527,119);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164879,238);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164718,194);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164914,159);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164992,152);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165361,235);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164615,110);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165374,42);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164415,181);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164919,221);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165104,206);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165368,161);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164464,219);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164467,57);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164488,85);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165093,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165294,32);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165118,126);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164691,207);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164657,222);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164742,62);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164465,237);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165331,173);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164463,58);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164827,147);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164416,152);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165143,126);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164925,181);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164441,49);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164821,208);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164611,174);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165314,172);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164854,223);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165169,195);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164677,70);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164554,212);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164633,121);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165067,93);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164864,7);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165212,149);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165229,56);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165106,242);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165294,72);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164437,83);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164664,166);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165270,64);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164500,114);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164415,67);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164462,131);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164959,193);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164639,234);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164706,63);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165006,34);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165374,233);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164533,205);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164556,207);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165311,60);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165180,29);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165147,149);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164623,208);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165125,163);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165160,95);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165299,55);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165370,235);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165182,107);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164883,218);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164766,44);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164456,227);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165077,240);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164624,222);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164923,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164581,43);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164586,6);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164540,193);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164423,131);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164915,189);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165338,240);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164819,67);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165047,176);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164942,125);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164766,48);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164603,78);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164800,56);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164692,161);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165118,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165068,6);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164801,239);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164899,216);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165009,10);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165121,181);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164610,98);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165154,176);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164583,66);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164890,146);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164974,242);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165166,139);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165033,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164703,200);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164879,177);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165405,238);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165240,41);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165268,149);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164875,205);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164948,195);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165027,135);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165397,43);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165003,135);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164906,67);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164914,120);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164728,60);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165054,1);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165123,128);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164949,192);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164788,189);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164856,181);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165107,215);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164945,202);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164698,152);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164495,106);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164453,153);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164627,27);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164849,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165154,55);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164470,243);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165226,117);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165398,125);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165394,185);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164498,241);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164640,53);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165160,73);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164424,231);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164732,3);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164985,67);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164839,93);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165276,100);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164741,180);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164926,48);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164728,194);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165236,10);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164969,40);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164741,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165023,163);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164594,100);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164923,141);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164420,167);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165158,172);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164867,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164690,21);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164416,231);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165290,169);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165006,186);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164684,221);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164654,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164835,104);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164591,97);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165305,203);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165313,91);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165212,191);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165253,52);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164857,124);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164680,210);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164565,116);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164819,181);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164576,177);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164959,39);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164488,220);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164932,184);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164800,115);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164853,193);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164665,133);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164818,69);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165376,203);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164805,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164549,236);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165191,181);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164708,125);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165381,184);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164850,123);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164667,70);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165077,141);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164639,73);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164928,134);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165015,2);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165188,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165270,29);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164831,66);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164835,23);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165278,9);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165110,58);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165304,33);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164476,175);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164757,9);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164572,129);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165390,92);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165304,182);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164579,231);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165043,8);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164883,91);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165009,126);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165012,48);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165005,190);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164540,94);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164599,243);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164797,131);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164752,136);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164872,90);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164630,113);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164470,167);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165023,79);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164610,89);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165393,131);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164959,177);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165412,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164942,28);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165391,185);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164851,199);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164945,90);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164503,162);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164972,236);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164619,54);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165304,144);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164881,220);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165207,92);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164936,37);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165340,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165089,66);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164559,74);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164786,195);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164621,34);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164765,206);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165279,105);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165217,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164662,109);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165215,152);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165143,10);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164609,31);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164854,201);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164995,208);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165411,16);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164461,149);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165250,149);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165032,118);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165190,104);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164656,237);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165411,89);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164452,47);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165078,101);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165152,175);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165184,136);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165332,16);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165209,197);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164904,208);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164928,18);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165208,58);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164588,36);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164564,134);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165415,41);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164782,31);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164908,107);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164527,232);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164987,81);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165101,236);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164634,68);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164620,15);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165309,180);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165000,239);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164666,130);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164629,66);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164861,63);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164583,240);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164942,117);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164826,238);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165166,70);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164692,97);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164707,129);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165392,76);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164995,45);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165085,143);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165168,164);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165353,151);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165016,65);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165360,135);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165360,111);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165296,121);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164440,86);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165365,100);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165069,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164956,136);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164517,178);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164690,182);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165078,109);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164548,241);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164460,151);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164577,95);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165402,121);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165295,29);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164787,83);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165038,140);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164530,212);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164851,48);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164422,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164955,31);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165156,35);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164711,91);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165095,233);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164924,150);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164875,115);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164622,184);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164744,13);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164705,194);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164679,102);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165343,131);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165371,66);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164468,48);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164714,215);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164898,24);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164490,117);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164625,115);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164532,10);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164872,60);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164825,147);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164846,24);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165095,90);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164608,8);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164504,6);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164722,199);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165173,172);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164684,89);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165118,20);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164541,46);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164973,172);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165303,49);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164552,3);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165278,136);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165035,52);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165056,62);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164927,87);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164713,46);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164636,135);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165065,237);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164511,196);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165360,166);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165241,86);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165104,160);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164692,16);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165190,75);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164920,119);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164808,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164502,124);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165115,134);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164427,177);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164696,70);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165249,93);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164414,99);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165271,60);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164966,237);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164937,182);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164750,239);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164691,182);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164678,46);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165403,208);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164834,217);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165400,155);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165116,191);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164871,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165088,66);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164452,179);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164433,73);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164732,111);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164548,188);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165161,168);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165110,91);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165268,17);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165230,188);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165244,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164510,226);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164700,179);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165302,170);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165316,156);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164450,182);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164609,140);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165094,146);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164815,215);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164587,12);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165234,228);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164922,128);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164622,212);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165369,55);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165416,135);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164995,62);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164456,26);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164838,78);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164479,148);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164490,121);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164721,8);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164705,139);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165365,3);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165051,91);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164771,242);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164891,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164423,104);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164741,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165147,177);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164488,31);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165259,89);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165397,127);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165112,76);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164989,226);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165397,196);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165289,46);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164492,116);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164494,75);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164582,63);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165290,15);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164991,194);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165227,131);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165107,105);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164659,195);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165381,164);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164697,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164544,78);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164703,177);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164852,156);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165371,163);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164525,133);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165211,193);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164561,120);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164993,157);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165106,64);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164537,228);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164591,108);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165346,158);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165294,60);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164980,43);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164582,169);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165003,80);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164823,154);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165046,152);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164987,44);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164636,3);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165282,149);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165009,104);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165079,126);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165119,235);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164673,41);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165236,61);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164526,203);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164990,4);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165325,226);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164987,190);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164781,97);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164616,102);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164505,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164695,63);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165323,215);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164810,181);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165001,51);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165209,164);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164812,241);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165160,161);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164939,154);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164880,75);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164470,105);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164968,121);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164739,168);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165098,179);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164656,65);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164701,210);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164480,133);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164909,171);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164795,122);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165029,72);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164635,233);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165314,241);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164735,23);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165106,141);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165365,70);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164711,149);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165359,117);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164731,94);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164752,72);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164532,227);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165288,102);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164904,39);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164902,219);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164655,29);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164953,116);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164867,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165399,48);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164804,240);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164832,216);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165345,165);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164659,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165338,136);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164631,52);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164538,219);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164767,211);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165282,46);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164451,230);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165350,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164730,200);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164911,226);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165085,187);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164771,90);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164434,168);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165041,216);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164936,136);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164605,37);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164990,9);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164633,1);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165168,20);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164604,222);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164954,141);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165080,40);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165095,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164934,172);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164477,112);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165130,11);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165125,150);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164646,24);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165012,243);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165071,152);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165411,80);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164521,130);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164925,53);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164902,96);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165078,235);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164539,79);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164591,18);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165031,174);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164554,227);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165084,131);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164440,53);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165054,193);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165188,223);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164652,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164495,180);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165398,98);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164606,91);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164658,142);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165052,232);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164609,221);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164736,216);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165377,140);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165112,23);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165356,225);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164423,32);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164753,11);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164999,89);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165170,139);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164766,30);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165209,173);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165015,15);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165334,215);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165134,59);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164828,165);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165023,70);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165167,78);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165095,229);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165251,178);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164430,65);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165383,226);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164560,205);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165240,221);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164628,176);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164957,130);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164556,56);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165168,106);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164857,180);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165015,37);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164850,217);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164878,128);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164891,123);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164787,120);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164559,59);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164806,101);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164648,92);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164664,173);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165413,66);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165163,30);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164914,23);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164994,73);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164488,124);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164805,62);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165204,46);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165063,227);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164482,174);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165137,145);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165261,157);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165232,114);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165019,159);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164679,65);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165270,117);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165208,129);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164677,232);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164500,8);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165100,85);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165379,32);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164414,178);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165295,94);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164547,175);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164762,219);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164545,97);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165281,108);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164503,166);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164959,103);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164917,77);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165156,21);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164819,32);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164447,216);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164413,102);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165253,59);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164446,200);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165144,83);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164848,115);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165366,187);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164782,232);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165410,24);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164918,124);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164731,58);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164749,147);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165294,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164454,201);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164487,27);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165348,69);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164705,10);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164516,117);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164750,86);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165141,121);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165296,207);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164604,206);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164971,223);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164920,121);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164849,145);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165379,30);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164664,55);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165360,118);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164772,73);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164746,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164465,232);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164804,14);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165267,176);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165264,166);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164816,123);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164957,111);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165212,118);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164414,113);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165099,188);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165079,217);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165055,240);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164659,240);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164697,163);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165414,78);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165219,8);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164777,83);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164711,47);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165371,79);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164815,48);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164890,24);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165159,97);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165308,94);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165091,239);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165392,241);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165399,57);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165029,218);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164761,94);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165037,194);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164527,40);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165151,188);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164733,75);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164628,214);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165165,198);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164861,221);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165309,87);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164650,9);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165381,33);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164773,231);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164827,111);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165030,147);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164520,7);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164481,198);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164808,135);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165358,56);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165378,229);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164535,15);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164455,191);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164930,61);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165186,45);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165336,75);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165360,138);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164937,115);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164474,110);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164455,28);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165081,163);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164695,243);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165187,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164442,46);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165217,160);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164590,231);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164568,34);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165094,28);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164791,236);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164875,92);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165098,215);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165214,148);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164829,176);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164543,37);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165227,167);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165280,1);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165049,125);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164846,199);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164806,27);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165408,90);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164696,74);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165015,104);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164976,26);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165389,112);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164771,232);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165401,122);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164647,133);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164547,24);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164885,164);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164508,175);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165223,5);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164665,227);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165241,161);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165296,78);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165302,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165327,189);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164649,51);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164940,102);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164574,159);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164427,35);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164710,161);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164900,104);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165359,4);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164702,103);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164435,212);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164420,54);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165158,68);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165205,212);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164438,33);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164826,84);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165184,85);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164885,72);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164784,30);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165245,201);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164442,226);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164770,106);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164965,198);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164469,50);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164964,7);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164682,31);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165011,230);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164738,217);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165006,78);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164527,97);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164657,174);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164996,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165387,146);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164601,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164460,22);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164629,210);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164830,203);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165328,114);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165250,219);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164480,119);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164934,107);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165411,203);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165164,119);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164909,95);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165230,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164633,73);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164580,33);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165043,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164899,221);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165347,133);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165327,186);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165398,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165017,216);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164536,225);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164548,35);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164984,1);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164778,152);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165198,174);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165182,68);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165259,71);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164673,119);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165327,117);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165026,27);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164610,123);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164893,222);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165387,234);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164731,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164883,242);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164881,187);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164641,215);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165166,88);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165386,23);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164560,31);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164947,128);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165298,202);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164510,179);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164720,97);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165039,40);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165302,235);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164889,131);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165388,46);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164505,55);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164628,157);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165088,105);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164776,29);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164611,157);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165081,32);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164414,46);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165138,121);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164485,155);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164858,107);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164805,217);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165247,180);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165022,228);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165386,92);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165106,87);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164755,67);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165041,191);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164654,100);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165207,98);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165163,19);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164838,140);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164671,40);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164437,1);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164421,95);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164506,26);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164492,175);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164708,55);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165118,93);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164993,112);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165035,92);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165389,110);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164588,112);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165078,68);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165391,110);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164706,143);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165040,128);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164725,202);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164743,243);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164559,45);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164450,178);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164662,138);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165358,132);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165119,177);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164745,150);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165105,215);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165292,215);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164481,166);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164447,136);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164465,176);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165161,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164810,131);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164803,218);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164611,136);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165328,75);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165352,213);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000165339,112);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164782,208);
INSERT INTO coffee.products_tagMap (productID, tagID) VALUES (0000164589,10);



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