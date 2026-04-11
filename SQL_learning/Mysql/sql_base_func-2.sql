# 函数
SELECT 函数(参数)[AS 别名] FROM table_name;

# 一、字符串函数
/*
1. CONCAT(str1, str2, ...): 将多个字符串连接成一个字符串。
2. LENGTH(str): 返回字符串的长度。
3. SUBSTRING(str, start, length): 从字符串的指定位置开始，提取指定长度的子字符串。
4. UPPER(str): 将字符串转换为大写。
5. LOWER(str): 将字符串转换为小写。
6. TRIM(str): 去除字符串两端的空格。
7. REPLACE(str, from_str, to_str): 将字符串中的指定子字符串替换为另一个子字符串。
8. LEFT(str, n): 从字符串的左侧提取指定长度的子字符串
9. RIGHT(str, n): 从字符串的右侧提取指定长度的子字符串。
10. INSTR(str, substr): 返回子字符串在字符串中第一次出现的位置。
11.LPAD(str, length, padstr): 在字符串的左侧填充指定的字符串，直到达到指定的长度。
12.RPAD(str, length, padstr): 在字符串的右侧填充指定的字符串，直到达到指定的长度。

*/
-- 企业员工工号统一为5位，不足8位的在前面补0
UPDATE table SET COLUMN = LPAD(str, 5, '0');


# 二、数值函数
/*
1. ABS(x): 返回数值的绝对值。
2. CEIL(x): 向上取整。
3. FLOOR(x): 向下取整。
4. ROUND(x, d): 将数值四舍五入到指定的小数位数。
5. RAND(): 返回一个0到1之间的随机数。   
6. POWER(x, y): 返回x的y次幂。
7. SQRT(x): 返回数值的平方根。
8. MOD(x, y): 返回x除以y的余数。
9. GREATEST(x1, x2, ...): 返回参数中的最大值。
10. LEAST(x1, x2, ...): 返回参数中的最小值。

*/
-- 通过数据库函数，生成一个6位数的随机验证码
select lpad(round(rand()*100000,0),6,'0');


# 三、日期函数
/*
1. curdate(): 返回当前日期。
2. curtime(): 返回当前时间。
3. now(): 返回当前日期和时间。
4. year(date): 返回日期中的年份部分。
5. month(date): 返回日期中的月份部分。
6. day(date): 返回日期中的天数部分。
7. date_add(date, INTERVAL expr unit): 在日期上加上指定的时间间隔。
8. date_sub(date, INTERVAL expr unit): 在日期上减去指定的时间
9. datediff(date1, date2): 返回两个日期之间的天数差。
10. date_format(date, format): 将日期格式化为指定的字符串格式。
*/
--date_add,date_sub
select date_add(now(), INTERVALL 7 day);
select date_sub(now(), INTERVALL 7 month);
-- datediff,第一个时间减去第二个时间，返回天数差
select datediff('2024-12-31', now());
--查询所有员工的入职天数，并根据入职天数倒序排序
select name,datediff(current_date,end_date) as work_days from emp order by work_days desc;


# 四、流程控制函数
/*
1. IF(value, t, f): 如果value为true，返回t，否则返回f。
2. IFNULL(value1, value2): 如果value1不为null，返回value1，否则返回value2。
3. CASE: 根据条件返回不同的结果。
   CASE
       WHEN condition1 THEN result1
       WHEN condition2 THEN result2
       ...
       ELSE resultN
   END[AS 别名]
如果condition1为true，返回result1；如果condition2为true，返回result2；否则返回resultN。
4.CASE表达式的简化形式
   CASE expression
       WHEN value1 THEN result1
       WHEN value2 THEN result2
       ...
       ELSE resultN
   END[AS 别名]
如果expression等于value1，返回result1；如果expression等于value2，返回result2；否则返回resultN。
*/
-- 查询emp表中员工姓名和工作地址（北京/上海/广州/深圳--->一线城市，其他--->二线城市）
select 
name,
(case work_address
when '北京' then '一线城市'
when '上海' then '一线城市'
when '广州' then '一线城市'
when '深圳' then '一线城市'
else '二线城市'
end) as city_level;


 











































