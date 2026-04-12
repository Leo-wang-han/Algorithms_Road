# 约束

# 一、约束创建
/*需求演示
id  唯一标识  int  主键，自动增长  PRIMARY KEY,AUTO_INCREMENT
name  姓名  varchar(20)  不为空且唯一  NOT NULL,UNIQUE
age  年龄  int  大于0且小于150  CHECK
status  状态  int  默认值为1  DEFAULT 
gender  性别  char(1)  枚举值为'M'或'F'  ENUM

*/
--建表
CREATE TABLE emp (
    id INT PRIMARY KEY AUTO_INCREMENT comment '主键', 
    name VARCHAR(20) NOT NULL UNIQUE comment '姓名',
    age INT CHECK (age > 0 AND age < 150) comment '年龄',
    status char(1) DEFAULT '1' comment '状态',
    gender CHAR(1) ENUM('M', 'F') comment '性别'
);


# 二、外键约束
/*
外键约束用于维护表之间的关系，确保数据的一致性和完整性。
外键约束可以防止在子表中插入无效的引用，并且可以定义级联操作来处理父表中的数据变更。
拥有外键约束的表称为子表，引用的表称为父表。
*/
# 2.1语法
# 添加外键
-- 方法一：在创建表时定义外键约束
CREATE TABLE 表名 (
    字段名 数据类型 约束,
    ...
    [CONSTRAINT 自定义外键名称] FOREIGN KEY (外键字段名) REFERENCES 主表(主表列名)
);
-- 方法二：在表创建后添加外键约束
ALTER TABLE 表名 ADD CONSTRAINT 自定义外键名称 FOREIGN KEY (外键字段名) REFERENCES 主表(主表列名);

-- 给表emp添加一个外键约束，引用dept表的id列
alter table emp add constraint fk_dept_id foreign key (dept_id) references dept(id);

# 删除外键
alter table emp drop foreign key fk_dept_id;

# 2.2删除/更新行为
/*
1. NO ACTION: 默认行为，表示当父表中的数据被删除或更新时，首先检查该记录是否有对应外键，如果子表中存在引用该数据的记录，则不允许删除或更新父表中的数据。
2. RESTRICT: 与NO ACTION类似，表示当父表中的数据被删除或更新时，首先检查该记录是否有对应外键，如果子表中存在引用该数据的记录，则不允许删除或更新父表中的数据。
3. CASCADE: 表示当父表中的数据被删除或更新时，首先检查该记录是否有对应外键，子表中引用该数据的记录也会被相应地删除或更新。
4. SET NULL: 表示当父表中的数据被删除或更新时，首先检查该记录是否有对应外键，子表中引用该数据的记录的外键字段会被设置为NULL。
5. SET DEFAULT: 表示当父表中的数据被删除或更新时，子表中引用该数据的记录的外键字段会被设置为默认值(innodb不支持)。
*/
 
-- 给表emp添加一个外键约束，引用dept表的id列，并设置级联删除和更新,在更新或删除父表数据时，子表中引用该数据的记录也会被相应地更新或删除
alter table emp add constraint 自定义外键名称 foriegn key (外键字段名) references 主表(主表字段名) on update cascade on delete cascade;
-- 给表emp添加一个外键约束，引用dept表的id列，并设置级联删除和更新,在更新或删除父表数据时，子表中引用该数据的记录的外键字段会被设置为NULL
alter table emp add constraint 自定义外键名称 foriegn key (外键字段名) references 主表(主表字段名) on update set null on delete set null;








