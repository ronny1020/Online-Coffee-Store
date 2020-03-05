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
,('D009','拿鐵優惠','星巴克公司現時拿鐵咖啡85折','S001','0.85')
,('D010','曼特寧優惠','露易莎咖啡4月3日起曼特寧咖啡75折','S002','0.75')
,('D011','曼特寧優惠','伯朗咖啡現時曼特寧咖啡85折','S003','0.85')
,('D012','冰滴咖啡優惠','上島咖啡6月6日起冰滴咖啡85折','S004','0.85')
,('D013','冰滴咖啡優惠','小樽咖啡現時冰滴咖啡85折','S005','0.85')
,('D014','冰滴咖啡優惠','上島咖啡6月6日起冰滴咖啡85折','S004','0.85')
,('D015','冰摩卡優惠','小樽咖啡現時冰摩卡咖啡85折','S005','0.85')
,('D016','冰摩卡優惠','露易莎咖啡4月3日起冰摩卡咖啡75折','S002','0.75')
,('D017','冰摩卡優惠','星巴克公司現時冰摩卡咖啡85折','S001','0.85')
,('D018','利比瑞卡優惠','上島咖啡6月6日起利比瑞卡咖啡85折','S004','0.85')
,('D019','利比瑞卡優惠','小樽咖啡現時利比瑞卡咖啡85折','S005','0.85')
,('D020','利比瑞卡優惠','資策會咖啡現時利比瑞卡咖啡85折','S006','0.85');

DROP TABLE IF EXISTS `discounts2`;
CREATE TABLE `discounts2` (
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
INSERT INTO `discounts2` VALUES
 ('D001','曼特寧優惠','星巴克公司現時曼特寧咖啡75折','S001','0.75','2019-02-18', '2019-02-20')
,('D002','曼特寧優惠','露易莎咖啡4月3日起曼特寧咖啡75折','S002','0.75','2019-02-18', '2019-02-20')
,('D003','拿鐵優惠','伯朗咖啡現時拿鐵咖啡85折','S003','0.85','2019-02-18', '2019-02-20')
,('D004','瑪奇朵優惠','上島咖啡6月6日起瑪奇朵咖啡85折','S004','0.85','2019-02-18', '2019-02-20')
,('D005','瑪奇朵優惠','小樽咖啡現時瑪奇朵咖啡85折','S005','0.85','2019-02-18', '2019-02-20')
,('D006','瑪奇朵優惠','露易莎咖啡4月3日起瑪奇朵咖啡75折','S002','0.75','2019-02-18', '2019-02-20')
,('D007','瑪奇朵優惠','伯朗咖啡現時瑪奇朵咖啡85折','S003','0.85','2019-02-18', '2019-02-20')
,('D008','拿鐵優惠','上島咖啡6月6日起拿鐵咖啡85折','S004','0.85','2019-02-18', '2019-02-20')
,('D009','拿鐵優惠','星巴克公司現時拿鐵咖啡85折','S001','0.85','2019-02-18', '2019-02-20')
,('D010','曼特寧優惠','露易莎咖啡4月3日起曼特寧咖啡75折','S002','0.75','2019-02-18', '2019-02-20')
,('D011','曼特寧優惠','伯朗咖啡現時曼特寧咖啡85折','S003','0.85','2019-02-18', '2019-02-20')
,('D012','冰滴咖啡優惠','上島咖啡6月6日起冰滴咖啡85折','S004','0.85','2019-02-18', '2019-02-20')
,('D013','冰滴咖啡優惠','小樽咖啡現時冰滴咖啡85折','S005','0.85','2019-02-18', '2019-02-20')
,('D014','冰滴咖啡優惠','上島咖啡6月6日起冰滴咖啡85折','S004','0.85','2019-02-18', '2019-02-20')
,('D015','冰摩卡優惠','小樽咖啡現時冰摩卡咖啡85折','S005','0.85','2019-02-18', '2019-02-20')
,('D016','冰摩卡優惠','露易莎咖啡4月3日起冰摩卡咖啡75折','S002','0.75','2019-02-18', '2019-02-20')
,('D017','冰摩卡優惠','星巴克公司現時冰摩卡咖啡85折','S001','0.85','2019-02-18', '2019-02-20')
,('D018','利比瑞卡優惠','上島咖啡6月6日起利比瑞卡咖啡85折','S004','0.85','2019-02-18', '2019-02-20')
,('D019','利比瑞卡優惠','小樽咖啡現時利比瑞卡咖啡85折','S005','0.85','2019-02-18', '2019-02-20')
,('D020','利比瑞卡優惠','資策會咖啡現時利比瑞卡咖啡85折','S006','0.85','2019-02-18', '2019-02-20');

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