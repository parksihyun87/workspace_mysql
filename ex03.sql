desc departments;  -- dp/ dept_name dept_no

desc dept_emp;  -- em/ emp_no, dept_no, from,to_date

desc dept_manager; -- ma/ dept_no, emp_no, from,to_date

desc employees; -- ey/ emp_no, birth_date, first,last_name,gender, hire_date

desc salaries; -- sa/emp_no, salary, from,to_date

desc titles; -- ti/emp_no, title, from,to_date

-- 각 부서별 매니저들의 현재 연봉
select sa.salary
from dept_manager ma
inner join salaries sa
on ma.emp_no = sa.emp_no
where sa.to_date='9999-01-01'
group by ma.emp_no;

-- 부서별로 매니저가 바뀐 횟수를 조회(부서명, 역대매니저 수)










-- development 부서 근무하는 직원의 이름 생년월일(1)
select dp.dept_name, ey.birth_date
from departments dp
inner join dept_emp em
on dp.dept_no =em.dept_no
inner join employees ey
on em.emp_no=ey.emp_no
where dp.dept_name='Development';

-- name이 Christ Muchinsky인 직원의 현재 소속 부서명과 현재 연봉(2)
select dp.dept_name, sa.salary
from departments dp
inner join dept_emp em
on dp.dept_no =em.dept_no
inner join employees ey
on em.emp_no=ey.emp_no
inner join salaries sa
on em.emp_no=sa.emp_no
where ey.last_name='Muchinsky' and ey.first_name='Christ' and sa.to_date='9999-01-01';

-- 현재 title이 Senior Engineer로 일하고 있는 직원의 이름과 연봉(3)
select ey.last_name , ey.first_name, sa.salary -- concat(ey.last_name , ey.first_name)
from employees ey
inner join salaries sa
on ey.emp_no=sa.emp_no
inner join titles ti
on ey.emp_no=ti.emp_no
where ti.title='Senior Engineer' and sa.to_date='9999-01-01';
