# SQL

# 一、DDL
--数据库操作和表操作

# 1.DDL-数据库操作
--查询所有数据库
SHOW DATABASES;
--查询当前数据库
SELECT DATABASE();
--创建数据库
CREATE DATABASE [IF NOT EXISTS] database_name [DEFAULT CHARSET charset_name] [COLLATE collation_name];
CREATE DATABASE IF NOT EXISTS databse_name DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_general_ci;
--删除数据库
DROP DATABASE [IF EXISTS] database_name;
--使用数据库
USE database_name;



# 2.DDL-表操作
# 2.1查询表结构
--查询当前数据库的所有表
SHOW TABLES;
--查询表结构
DESC table_name;
--创建表
CREATE TABLE [IF NOT EXISTS] table_name(
    column_name data_type [commnent 'comment_text'] [primary key|unique key|index key|foreign key],
    ...
)[comment 'table_comment'];#comment是可选的注释内容
--删除表
DROP TABLE [IF EXISTS] table_name;
/*
数据类型
    # 数值类型
        TINYINT
        SMALLINT
        MEDIUMINT
        INT
        BIGINT
        FLOAT
        DOUBLE
        DECIMAL(M,D)
    # 日期时间类型
        YEAR    YYYY
        DATE    YYYY-MM-DD
        TIME    HH:MM:SS
        DATETIME   YYYY-MM-DD HH:MM:SS
        TIMESTAMP   YYYY（2038）-MM-DD HH:MM:SS  时间戳
    # 字符串类型
        CHAR   定长
        VARCHAR   变长  
        TEXT
        BLOB
*/

# 2.2DDL-  修改表结构
--修改表
ALTER TABLE table_name 
    ADD|    --增加列
    MODIFY  --修改列名和类型
    DROP    --删除列
    CHANGE  --修改列名
    RENAME TO    --修改表名
    column_name column_type [comment 'comment_text'] [KEY];
--复制表
CREATE TABLE table_name LIKE table_name;
CREATE TABLE table_name AS SELECT * FROM table_name;



# 二、DML
/*
DATA MANIPULATION LANGUAGE
数据操作语言，用于执行数据库中表的记录进行增删改查 
添加数据INSERT
删除数据DELETE
修改数据UPDATE table_name SET
查询数据SELECT
*/
INSERT INTO table_name(column1,column2,...) VALUES(value1,value2,...),(value1,value2,...);
UPDATE table_name SET column1=value1,column2=value2,... [WHERE condition];
DELETE FROM table_name [WHERE condition];
SELECT column1,column2,... FROM table_name [WHERE condition];



# 三、DQL
/*
DATA QUERY LANGUAGE
数据查询语言，用于查询数据,用来查询数据库中表的记录

语法-编写顺序
select    字段列表
from      表名列表
where     条件列表
group by  分组字段列表
having    分组后条件列表
order by  排序字段列表
limit     分页参数

基本查询
条件查询（where)
聚合函数(count,sum,avg,max,min)
分组查询(group by)
排序查询(order by)
分页查询(limit)

*/
# SELECT
# 3.1.基本查询
--1.查询多个字段
SELECT column1,column2,... FROM table_name;
--2.查询所有字段
SELECT * FROM table_name;
--3.设置别名
SELECT column1 AS 别名1,column2 AS 别名2,... FROM table_name;
--4.去除重复记录
SELECT DISTINCT column1,column2,... FROM table_name;
--5.空值处理
SELECT IFNULL(column1,默认值) FROM table_name;

# 3.2.条件查询
SELECT column1,column2,... FROM table_name WHERE condition;
/*
--比较运算符
>
<
>=
<=
=
!=或<>
BETWEEN...AND...   在某个范围内(含最小值和最大值)
IN(...)   在in之后的列表中的值，多选一
LIKE 'pattern'   模糊查询，%代表任意字符，_代表单个字符
IS NULL 或 IS NOT NULL   判断是否为NULL


--逻辑运算符
AND 或 &&    并且（多个条件同时成立）
OR 或 ||    或者（多个条件其中一个成立）
NOT 或 !    非（条件不成立）
*/

# 3.3.聚合函数(count,sum,avg,max,min)
/*
聚合函数：将一列数据作为一个整体，进行纵向计算
注意：null值不参与计算
执行顺序：where -> group by -> having -> select
分组之后，查询的字段一般为聚合函数和分组字段
*/
SELECT 聚合函数名(column_name) FROM table_name;  #统计行数

# 3.4.分组查询
SELECT column1,column2,...,聚合函数(column_name) FROM table_name [WHERE condition] GROUP BY column [HAVING condition];
/*
where 和 having 的区别：
执行时机不同：where 用于过滤行数据，在分组之前进行过滤
判断条件不同：where 只能使用列名和常量，不能使用聚合函数；having 可以使用聚合函数和分组字段
*/
-- 查询年龄小于45岁的员工的工作地址和人数，并根据工作地址分组，筛选出人数大于等于3的地址
select workaddress,count(*) as addr_count from emp where age<45 group by workaddress having addr_count>=3;

# 3.5.排序查询
SELECT column1,column2,... FROM table_name [WHERE condition] ORDER BY column1 [ASC|DESC],column2 [ASC|DESC],...;
-- 当一个字段相同时，再按照另一个字段排序
-- 根据年龄升序排序，年龄相同的按照工资降序排序
SELECT * FROM emp ORDER BY age ASC,salary DESC;

# 3.6.分页查询
SELECT column1,column2,... FROM table_name [WHERE condition] ORDER BY column1 [ASC|DESC],column2 [ASC|DESC],... LIMIT 起始索引, 查询记录数;
/*
起始索引：从0开始，起始索引=（页码-1）*每页记录数
不同数据库分页语法不同，MySQL使用LIMIT，SQL Server使用OFFSET FETCH，Oracle使用ROWNUM
*/
--查询第2页，每页10条记录
SELECT * FROM emp ORDER BY id ASC LIMIT 10,10;  #起始索引为10，查询记录数为10，即查询第2页的记录

# 3.7.执行顺序
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT



# 四、DCL
/*
DATA CONTROL LANGUAGE(数据控制语言),用来管理数据库用户、控制数据库的访问query权限和安全级别

权限
ALL,ALL PRIVILEGES    所有权限
SELECT  查询数据
INSERT  插入数据
UPDATE  更新数据
DELETE  删除数据
CREATE  创建权限 数据库/表
DROP    删除权限 数据库/表/视图
ALTER   修改表

GRANT   授予权限
REVOKE  收回权限
*/
# 4.1用户管理
--1.查询用户
USE mysql;
SELECT * FROM user;
--2.创建用户
CRATE USER 'username'@'host' IDENTIFIED BY 'password';
--访问任意主机
CREATE USER 'username'@'%' IDENTIFIED BY 'password';
--登录数据库
>>mysql
>> mysql -u username -p
--3.修改用户密码
ALTER USER 'username'@'host' IDENTIFIED WITH mysql_native_password BY 'new_password';
--4.删除用户
DROP USER 'username'@'host';

# 4.2权限控制
--1.查询
SELECT GRSNTS FOR 'username'@'host';
--2.授予权限
GRANT 权限列表 ON 数据库名.表名 TO 'username'@'host';
--3.收回权限
REVOKE 权限列表 ON 数据库名.表名 FROM 'username'@'host';
















