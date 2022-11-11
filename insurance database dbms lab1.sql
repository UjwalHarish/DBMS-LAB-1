create database insurance;
use insurance;

create table person(
driver_id varchar(10) primary key,
name varchar(20),
address varchar(30)
);

describe person;

create table car(
reg_num varchar(10),
model varchar(10),
year int,
primary key(reg_num)
);

create table accident(
report_num int,
accident_date varchar(15),
location varchar(20),
primary key(report_num)
);

create table owns( 
driver_id varchar(10),
reg_num varchar(10),
primary key(driver_id,reg_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num)
);

create table participated(
driver_id varchar(10),
reg_num varchar(10),
report_num int,
damage_amount int,
primary key(driver_id,reg_num,report_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accident(report_num)
);

insert into person values('A01','Richard','Srinivas Nagar');
insert into person values('A02','Pradeep','Rajaji Nagar');
insert into person values('A03','Smith','Ashok Nagar');
insert into person values('A04','Venu','N R Colony');
insert into person values('A05','Jhon','Hanumanth Nagar');

insert into car values('KA052250','Indica',1990);
insert into car values('KA031181','Lancer',1957);
insert into car values('KA095477','Toyota',1998);
insert into car values('KA053408','Honda',2008);
insert into car values('KA041702','Audi',2005);

drop table car;

insert into owns values('A01','KA052250');
insert into owns values('A02','KA053408');
insert into owns values('A03','KA031181');
insert into owns values('A04','KA095477');
insert into owns values('A04','KA041702');

drop table owns;

insert into accident values(11,'01-JAN-03','Mysore Road');
insert into accident values(12,'02-FEB-04','South End Circle');
insert into accident values(13,'21-JAN-03','Bull Temple Road');
insert into accident values(14,'17-FEB-08','Mysore Road');
insert into accident values(15,'04-MAR-05','Kanakapura Road');

insert into participated values('A01','KA052250',11,10000);
insert into participated values('A02','KA053408',12,50000);
insert into participated values('A03','KA031181',13,25000);
insert into participated values('A04','KA095477',14,3000);
insert into participated values('A05','KA041702',15,5000);

drop table accident;
drop table participated;

select * from person;
select * from accident;
select * from car;
select * from participated;
select * from owns;

show tables;

update participated
set damage_amount = 25000
where reg_num = 'KA053408' and report_num=12;

select count(distinct driver_id)
from participated a, accident b
where a.report_num=b.report_num and b.accident_date like '%08';

insert into accident values(16,'2008-03-08','Domlur');

-- to diplay accident date and location
select accident_date,location from accident;

-- to display driver id who did accident accompanying damage amount greater than equal to 25000
select driver_id 
from participated
where damage_amount>=25000;

-- listing the entire participated table in descending order of damage amount
select * 
from participated
order by damage_amount desc;

-- finding the average of damage amounts
select avg(damage_amount) from participated;

-- to delete that entry from participated table whose damage amount is less than average damage amount
delete from participated
where damage_amount<(select participated from (select avg(damage_amount)from x));

select name from person A, participated B where A.driver_id=B.driver_id /*linking the parent and child table using foreign key*/
and damage_amount>(select avg(damage_amount) from participated);

-- finding the maximum damage amount
select max(damage_amount) from participated;