select avg(price) as marketprice
from itemprice
where item_name = "가격"

select item_id, item_name, price, condition, item_description,
 seller_id, post_date, transaction_state 
from item 
where seller_id in (select user_id 
                    from user 
                    where user.location_id in (select location.location_id 
                                                from location
                                                where district="만안구"))
                    and price <80000 and price >=40000

select post_id, title, user_id, date, view_count
from freeboard
where freeboard.user_id in (select user.user_id
                            from user
                            where user.location_id = (select location_id
                                                        from location
                                                        where eup_dong="석수2동"))

select a.item_name, a.price, a.seller_id
from item as a
where a.item_id in (select b.item_id
                        from item as b
                        where b.seller_id in (select user_id
                                                from user
                                                where location_id=(select location_id
                                                                    from location
                                                                    where city="안양시"
                                                                        district="만안구"
                                                                        eup_dong="석수2동")))\

select transaction_state, count(item_id) as num
from dealhistory
where user_id="userexample"
group by transaction_state

create trigger setnull_trigger before update of takes
referencing new row as nrow
for each row
    when (nrow.grade='')
    begin atomic
        set nrow.grade = null;
end;

create trigger credits_earned after update of takes on (grade)
referencing new row as nrow
referencing old row as orow
for each row
when nrow.grade <> 'F' and nrow.grade is not null
and orow.grade ='F' or orow.grade is null
begin atomic
    update student
    set tot_cred=tot_cred+
        (select credits
         from course
         where course.course_id=nrow.course_id)
    where student.id=nrow_id;
end;

select name, title
from (student natural join takes) join course using (course_id)

select *
from student join takes on student_ID=takes_ID

select *
from student, takes
where student_ID=takes_ID

select *
from course natural right outer join prereq

select *
from course full outer join prereq using (course_id)

select *
from course inner join prereq on course.course_id=prereq.course_id

select *
from course left outer join prereq on course.course_id=prereq.course_id

create view departemetn(dept_name, total_salary) as
select dept_name, sum(salary)
from instructor
group by dept_name;

create view physics_fall_2017 as
select course.course_id, sec_id, building, room_number
from course, section
where course.course_id = section.course_id
and course.dept_name='Physics'
and section.semester='Fall'
and section.year='2017';

create table course(
    dept_name(20),
    foreign key(dept_name) references department
    on delete 
    on update cascade
)

create type dollars as numeric(12, 2) final

create table department
(dept_name varchar(20),
building varchar(15),
budget dollars);

grant select on department to Amit, Satoshi
grant all privileges on department to public

grant reference (dept_name) on department to Mariano
revoke all on department from public
grant select on department to Amit with grant option;
revoke select on department from Amit, Satoshi cascade;

create function dept_count (dept_name varchar(20))
    returns integer
    begin
    declare d_count integer;
        select count(*) into d_count
        from instructor
        where instructor.dept_name=dept_name
    return d_count;
end

select dept_name, budget
from department
where dept_count (dept_name)>12

create function instructor_of(dept_name char(20))
    returns table(
        ID varchar(5),
        name varchar(20),
        dept_name varchar(20),
        salary numeric(8,2))
    return table
        (select ID, name, dept_name, salary
        from instructor
        where instructor.dept_name=instructor_of.dept_name)
    )

select *
from table(instructor_of('Music'))

create procedure dept_count_proc(in dept_name varchar(20), out d_count integer)
    begin
        select count(*) into d_count
        from instructor
        where instructor.dept_name=dept_count_proc.dept_name
    end

call dept_count_proc('Physics', d_count);

create trigger setnull_trigger before update of takes
referencing new row as nrow
for each row
    when (nrow.grade='')
    begin atomic
        set nrow.grade=null;
end;

create trigger credits_earned after update of takes on (grade)
referencing new row as nrow
referencing old row as orow
for each row
when nrow.grade <> 'F' and nrow.grade is not null
    and (orow.grade = 'F' or orow.grade is null)
begin atomic
    update student
    set tot_cred=tot_cred+
        (select credits
        from course
        where course.course_id=nrow.course_id)
    where student.id=nrow.id
end;

select name, title
from (student natural join takes) join course using (course_id)

select *
from student join takes on student_ID=takes_ID

select * from student, takes
where student_ID=takes_ID

create view faculty as
    select ID, name , dept_name
    from instructor

select name
from faculty
where dept_name='Biology'; 

select name
from instructor
where dept_name='Biology'; 

create view departments_total_salary(dept_name, total_salary) as
    select dept_name, sum(salary)
    from instructor
    group by dept_name;

create view physics_fall_2017_watson as
select course_id, room_number
from physics_fall_2017
where building='Watson';

create table person(
    ID char(10),
    primary key ID,
    foreign key father references person
        on update cascade
        on delete restrict,
    foreign key mother references person,
)

create assertion credits_earned_constraint check
(not exists (select ID
            from student
            where tot_cred<>(select coalesce(sum(credits), 0)
                            from takes natural join course
                            where student.ID=takes.ID and
                            grade is not null and
                            grade <> 'F'))
)

create type Dollars ad numeric(12, 2) final
(dept_name varchar(20),
building varchar(15),
budget Dollars);

create domain person_name char(20) not null
    constraint degree_level_test
        check(value in('Bachelors', 'Masters', 'Doctorate')); 

grant select on table to hwang with grant option;
grant all privileges on table to hwang
revoke all on table from public

create role instructor
grant instructor to hwang
create role dean;
grant instructor to dean;
grant dean to Satoshi;

grant reference (dept_name) on department to Mariano;
grant reference (dept_name) on department to Mariano;
grant reference (dept_name) on department to Mariano;

create function dept_count (dept_name varchar(20))
    returns integer
    begin
    declare d_count integer;
    select count(*) into d_count
    from instructor
    where instructor.dept_name=dept_name
    return d_count
    end

create function instructor_of(dept_name char(20))
    returns table(
        ID varchar(5),
        name varchar(20),
        dept_name varchar(20),
        salary numeric(8, 2))
    return table(
        select ID, name, dept_name, salary
        from instructor
        where instructor.dept_name=instructor_of.dept_name)

create procedure dept_count_proc (in dept_name varchar(20), out d_count integer)
    begin
        select count(*) into d_count
        from instructor
        where instructor.dept_name=dept_count_proc.dept_name
    end

declare d_count integer;
call dept_count_proc('Physics', d_count)

create trigger credits_earned after update of takes on (grade)
referencing new row as nrow
referencing old row as orow
for each row
when nrow.grade <> 'F' and nrow.grade is not null
    and orow.grade = 'F' or orow.grade is null
begin atomic
    update student
    set tot_cred=tot_cred+
    (select credits
    from course
    where course.course_id=nrow.course_id)
    where student.id=nrow.id;
end;