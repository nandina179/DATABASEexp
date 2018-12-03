/*create database*/
drop database if exists School;
create database School;
use School;
/*create tables*/
drop table if exists Student;
create table Student
    (
        sno      char(5),
        sname    varchar(20),
        ssex     char(10) check (ssex in('male','female')),
        sage     numeric(6,0) check(sage between 18 and 22),
        sdept    varchar(40),
        primary key (sno)
    );
drop table if exists Course;
create table Course
    (
        cno       char(5),
        cname     varchar(50),
        ctime     numeric(12, 0) check ( ctime > 0 ),
        Ccredit   numeric(6,1),
        primary key (Cno)
    );
drop table if exists SC;
create table SC
    (
        sno       char(5),
        cno       char(5),
        grade     numeric(6,2),
        foreign key (sno) references Student(sno),
        foreign key (cno) references Course(Cno)
    );

/*insert data to tables*/
insert into `Student` values ('001','Zhang xin','male','18','computer science');
insert into `Student` values ('002','Wang peng','male','19','electronic');
insert into `Student` values ('003','Li na','female','20','Information science');
insert into `Student` values ('004','Ma fei','female','18','computer science');
insert into `Student` values ('005','Zuo li','male','19','Information science');
insert into `Student` values ('006','Zhang hai','female','21','Information science');
insert into `Student` values ('007','Li jian','male','20','electronic');
insert into `Student` values ('008','Wang peng','male','20','computer science');
insert into `Student` values ('009','Li qiang','male','18','electronic');
insert into `Course` values ('C01','Database System','48','1');
insert into `Course` values ('C02','Introduction to the Internet','64','2');
insert into `Course` values ('C03','Programming in Java','72','1');
insert into `Course` values ('C04','Information Technology for Information Management','36','2');
insert into `Course` values ('C05','Bibliometrics','54','3');
insert into `Course` values ('C06','Fundamentals of Power Electronics','48','1');
insert into `Course` values ('C07','Library Automation and Resource Sharing','36','2');
insert into `SC` values ('001','C01','78');
insert into `SC` values ('001','C02','64');
insert into `SC` values ('002','C03','57');
insert into `SC` values ('002','C04','89');
insert into `SC` values ('002','C05','97');
insert into `SC` values ('003','C04',null);
insert into `SC` values ('004','C06','26');
insert into `SC` values ('004','C07','58');
insert into `SC` values ('005','C02','85');
insert into `SC` values ('006','C03','85');
insert into `SC` values ('006','C06','75');
insert into `SC` values ('007','C07',null);
insert into `SC` values ('007','C02','88');
insert into `SC` values ('008','C03','52');
insert into `SC` values ('009','C03','93');
insert into `SC` values ('009','C01','63');
insert into `SC` values ('009','C02','73');



show tables;
/*show tables context*/
select * from Student;
select * from Course;
select * from SC;
