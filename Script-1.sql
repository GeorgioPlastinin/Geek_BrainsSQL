#---1----
update users set created_at = now(), updated_at = now();

#---2----
alter table users modify column created_at datetime;
alter table users modify column updated_at datetime;

#---3----
select value from (select value ,if(value = 0, ~0, value) as zero
from storehouses_products order by zero) as abc

#---4---
select * from users 
where date_format(birthday,'%M') in ('may', 'august')

#---5---
SELECT * FROM users WHERE id IN (5, 1, 2)
order by field(id, 5, 1, 2) 

#---------------------------------------------------------
#---1---
select avg(age) from (select year(current_date()) - year(birthday) as age from users) as avg_age

#---2---
select count(*) as stats from (select dayofweek(concat(year(now()),'-',month(birthday),'-',dayofmonth(birthday))) 
as date from users) as stats where date=7; #день недели (date)

#---3----
select exp(sum(log(value))) from table;