/*3-1查询所有选修过“Bibliometrics”课的学生的姓名和成绩*/
select sname,grade
from Student,Course,SC
where Student.sno = SC.sno
and Course.cno = SC.cno
and cname = 'Bibliometrics'; 

/*3-2查询考试成绩不及格的学生的个数*/
select count(grade)
from SC
where grade < 60;
/*what the grade is empty can't be counted into the result*/

/*3-3查询名字中至少含有一个“z”字符的学生的姓名、学号和性别*/
select sname,sno,ssex
from Student
where sname like '%z%';

/*3-4查询选修了“Introduction to the Internet”课程的学生的学号及其成绩，查询结果按分数的降序排列；*/
select SC.sno,grade
from Student,Course,SC
where Student.sno=SC.sno
and SC.cno = Course.Cno
and cname = 'Introduction to the Internet'
order by grade desc;

/*3-5查询“Zuo li”同学选修课程的总学时(time)数*/
select sum(ctime) 
from Course
where cno in
(select cno from Student
join sc on Student.sno = SC.sno
and Student.sname = 'Zuo li'
);

/*3-6查询年龄不大于20岁的学生的平均考试成绩*/
select avg(grade) from SC
where sno in(select sno from Student where sage <= 20);

/*3-7查询“computer science”专业学生选修“Database System”的人数*/
select count(sname) from Student
join SC on Student.sno = SC.sno
join Course on SC.cno = Course.cno
and cname = 'Database System'
and sdept = 'computer science';

/*3-8查询同时选修课程“Database System”和“Introduction to the Internet”的学生姓名*/
select sname from Student 
join SC on Student.sno = SC.sno
join Course on Course.cno = SC.cno
and cname = 'Database System'
where sname in
(select sname from Student 
join SC on Student.sno = SC.sno
join Course on Course.cno = SC.cno
and cname = 'Introduction to the Internet'
);

/*3-9查询选修的课程中含有“Wang gang”同学所有选修课程的学生姓名*/
select sname from Student 
where sno in
(select sno 
from SC where cno in
(select cno from SC       
where sno in
(select cno from Student
where sname = 'Wang peng'
)));

/*3-10查询“Information Technology for Information Management”考试成绩为空的学生姓名及专业名称*/
select sname,sdept
from Student,SC
where Student.sno = SC.sno
and SC.grade is NULL;

select @@global.sql_mode;
/*
set @@global.sql_mode 
='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
*/
/*3-11查询“computer science”专业学生每个人的选修课总学分*/
select st1.sname,sum(grade) from SC sc1,Student st1
where st1.sno = sc1.sno
and st1.sno in
(select Student.sno   
from Student where sdept = 'computer science')
group by st1.sno;

/*3-12查询个人考试平均成绩高于专业平均成绩的学生姓名*/
select sname from 
(select sname,sdept,avg(grade) a_g from Student,SC     
where Student.sno = SC.sno 
group by sname) as S,
(select sdept,avg(grade) a_g from Student,SC   
where Student.sno = SC.sno 
group by sdept) as D
where S.sdept = D.sdept
and S.a_g > D.a_g;

/*3-13查询个人考试平均成绩高于女生平均成绩的男生姓名*/
select sname from 
(select sname,avg(grade) a_g from Student st1,SC sc1      
where st1.sno = sc1.sno 
and ssex = 'male') as S
where S.a_g >(select avg(grade) from Student,SC
where Student.sno = SC.sno
and ssex = 'female');

/*3-14查询比“computer science”专业所有学生年龄都大的学生姓名*/
select sname from Student
where sage >
(select max(sage) from Student
where sdept = 'computer science');

/*3-15查询考试成绩仅有一科不及格学生姓名*/
select sname from Student,SC
where Student.sno = SC.sno
and grade < 60
group by Student.sno
having count(*) = 1;


/*4-1*/
/*4-2*/
/*4-3*/