/*4-1.从课程表中查询所有课程信息*/

select *
from course;

/*4-2.从课程表中查询课程类别的信息。*/
/*应该要防止重复我觉得*/

select dept_name
from course;

/*4-3.从课程表中查询课程类别，要求消除值相同的那些行。*/
/*好吧这道题要求防止重复*/

select distinct dept_name
from course;

/*4-4.从学生表中查询所有的信息，要求只显示查询结果的前6行数据。*/

select *
from student
limit 6;

/*4-5.查询课程表中课程编号、课程名称、 教师、限制选课人数和报名人数、上课时间*/
/*合并了一下上课时间的表，使之成为一列*/

select course_id,title,name,maxnum,curnum,
concat(day," ",start_hr,":",start_min,"~",end_hr,":",end_min) as time_for_class
from course,instructor,time_slot;

/*4-6.查询课程表的信息*/

select *
from course;

/*4-7.在课程表中查询课程类别为“信息技术”，并且学分为“2”的课程。*/
/*小表里没有学分2的课，改成3吧～*/

select *
from course
where dept_name = 'Comp. Sci.'and credits = 3;

/*4-8.查询课程表的课程信息、报名人数与限选人数之比。*/

select * ,curnum/maxnum
from course;

/*4-9.查询课程表中最小的报名人数、最大的报名人数以及平均报名人数。*/

select min(curnum),max(curnum),avg(curnum)
from course;

/*4-10.查询课程信息、报名人数与限选人数之比。要求查询结果按照报名人数升降排序。*/
/*升降排序？我就当升序了吧*/

select * ,curnum/maxnum as '报名人数与限选人数之比'
from course
order by curnum;

/*4-11.查询课程表的教师名、课程编号、课程名，要求查询结果按照教师名降序排序，教师名相同时，则按照课程编号升序排序。*/

select name,course_id,title
from course,instructor
order by name desc,course_id;

/*12.查询课程编号为“004”、“007”、“013”的课程信息。*/

select *
from course
where course_id in ('CS-101','MU-199','BIO-101');


/*13.查询课程编号不为“004”、“007”、“013”的课程编号和课程名称。*/
/*'CS-101','MU-199','BIO-101'改了一点不影响*/

select course_id,title
from course
where course_id not in ('CS-101','MU-199','BIO-101');

/*14.查询课程名以字母D开始的课程信息。*/

select *
from course
where title like 'D%';

/*15.查询课程名以"History"结尾的课程信息。*/

select *
from course
where title like '%History';

/*16.查询姓名第二个字为“宝”的学生信息。*/
/*改成了第二个字母为h*/

select *
from student
where name like '_h%';

/*17.查询不姓“刘”的学生信息。*/

select *
from student
where name like '_h%';

/*18.查询课程表中教师姓名未定的课程信息。*/
/*都不是空的。。*/

select *
from course,instructor
where name is NULL;

/*19.查询报名人数少于15人的课程信息。*/

select *
from course
where curnum < 15;

/*20.查询报名人数少于25并且多于15人的课程信息。*/

select *
from course
where curnum > 15 and curnum < 25;

/*21.查询报名人数少于25并且等于15人的课程信息，要求查询结果按照报名人数降序排列。*/
/*可以相等*/

select *
from course
where curnum  between 15 and 25
order by curnum desc;

/*22.查询报名人数少于25并且少于15人的课程信息，要求查询结果按照报名人数降序排列。*/
/*当作大于25*/

select *
from course
where curnum not between 15 and 25
order by curnum desc;

/*23.查询课程表中“信息技术”类课程信息，并计算平均报名人数。*/

select *
from (select avg(curnum) as avg_num 
from course 
where dept_name = 'Comp. Sci.') as T,course 
where dept_name = 'Comp. Sci.';


/*24.按类别显示课程信息，并计算各类课程的平均报名人数。*/

select * 
from course,(select dept_name,avg(curnum) as avg_num 
from course 
group by dept_name) as S 
where course.dept_name = S.dept_name;

/*25.按课程类别分组统计各类课程的平均报名人数。*/

select dept_name,avg(curnum) as avg_num 
from course 
group by dept_name; 

/*26.查询“信息技术”类课程的平均报名人数。*/

select avg(curnum) as avg_num 
from course 
where dept_name = 'Comp. Sci.'; 

/*空格引发的null血案*/

/*27.查询平均报名人数大于25人的课程类别和每类平均报名人数。*/

select dept_name,S.avg_num from(select dept_name,avg(curnum) as avg_num 
from course 
group by dept_name) as S 
where S.avg_num > 25;

/*28.查询报名人数大于平均报名人数的课程信息。*/

select distinct title,curnum,S.avg_num from(select dept_name,avg(curnum) as avg_num 
from course 
group by dept_name) as S,course 
where course.curnum > S.avg_num;

/*29.从班级表中查询班级名，从系部表中查询系部名称，实用UNION运算符合并两个查询结果。*/

(select class_name from class)
union
(select dept_name from department);

/*30.从班级表中查询班级名，从系部表中查询系部名称，实用UNION运算符合并两个查询结果，要求按降序排序。*/

(select class_name from class)
union
(select dept_name from department)
order by class_name desc;

/*31.查询班级信息，要求显示班级编号、班级名称、班级所在的系部编号、系部名称。*/
select * from class;

/*32.查询学生信息，显示信息包括学生基本信息和班级名称。*/

select ID,name,student.dept_name,tot_cred,class_name
from student,class
where student.class_id = class.class_id;

/*33.查询学生选课信息，要求显示姓名、课程名称、志愿号，按姓名和志愿号排序。*/
/*志愿号就当作是课程号*/

select name,title,course_id 
from student natural join course
order by name,course_id;

/*34.查询学生报名“计算机应用工程系”开设的选修课程情况，显示信息包括学生姓名、课程名称和授课教室。*/

select name,title,building,room_number
from student,course,section
where course.course_id=section.course_id  and course.course_id in
(select course.course_id
 from course,department
 where course.dept_name=department.dept_name and department.dept_name='Comp. Sci.'
)
order by room_number;

/*35.查询每个班级可以选修的、不是自己所在系部开设的选修课程的信息*/
/*class name,course id冲突之我决定改库*/

select distinct class_name,course_id,title,course.dept_name
from course,class,time_slot,instructor
where class.dept_name <>course.dept_name
order by class_name;

