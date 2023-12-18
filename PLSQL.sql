================================================================================

                                    PLSQL

================================================================================
Sql:Structured Query Language
PL/SQL is procedural language extension for SQL
It is the combination of Procedureal & Data Manupulation language
Oracle 6.0 introduced PL/SQL

------------------------
PL/SQL is block structured

Syntax:

Declare [optional]
    variables,cursors,undefined exceptions
Begin [Mandatory]
    DML,TCL
    select into clause
    conditional,control statements;
Exceptions [optional]
    Handling exception
End;

-----------------------
Types of Blocks:
1) Named Block
2) Anonymous block

1) Named Block
- Having name
- Automatically stored in database
- Procedures,Functions,Triggers,Packages etc.

2) Anonymous block
- No Name
- Not stored in database
- Allowed to call these blocks in another blocks or in client application
- ex
        Declare
        ---------
        Begin
        -----
        -----
        End;
        
-------------------------------------------------------------------------------
                            VARIABLE

- Used to store a single value into memory location
- Syntax to declare
        variable_name datatype (size);
        a number(10);
        v_name varhar2(30);

- Variables declared in Declare Section.
- Display Message or Variable Value
        dbms_output.put_line(variable_name);
        
-------------------------------------------------------------------------------        
set serveroutput on;

Begin
   dbms_output.put_line('Pramod');
End;

-----------Basic Code----------------
Declare 
a number(10);

Begin
a:=60;
dbms_output.put_line('Value of a-->'||a);
End;

--------------------------------------------------------------------------------
                            SELECT INTO CLAUSE

- SELECT INTO CLAUSE is used to retrieve data from table & storing into PL/SQL 
variables.
- It always returns single record or value at a time.

================================================================================
                                 EXAMPLES
================================================================================
1) Write a PL/SQL program for user entered empno, display name of the employee
and salary from emp table.

select * from emp1;

Declare
v_ename varchar2(20);
v_sal number(10);

begin
select ename,sal into v_ename,v_sal from emp1
where empno=&no;

dbms_output.put_line('Name of Employee is '||v_ename);
dbms_output.put_line('Employee Salary is '||v_sal);

end;


--------------------------------------------------------------------------------
2) Assigning value at the time of declaration for not null,default & constant values.

declare
a number(10) not null :=30;
b constant number(10) :=20;
c number(10) default 10;
d number(10);

Begin
dbms_output.put_line(a);
dbms_output.put_line(b);
dbms_output.put_line(c);
dbms_output.put_line(a+b+c);

d:=greatest(a,b,c);
dbms_output.put_line('Greatest is '||d);
end;

--------------------------------------------------------------------------------
3) Write a PL/SQL program to display maximum slary from emp1 table

select * from emp1;

Declare 
v_maxsal number(10);

Begin
select max(sal) into v_maxsal from emp1;
dbms_output.put_line('Max salary is '||v_maxsal);
end;

-------------
Note: We are not allowed to use group function, decode conversion functions in PL/SQL expression

--------------------------------------------------------------------------------
4) Get details of employee whose empno=7902 and incremented salary by 50% from emp1 table.

select * from emp1; --7902

Declare
v_ename varchar2(50);
v_job varchar2(50);
v_sal number(10);
v_sal_inc number(10);

Begin
select ename,
       job,
       sal,
       sal*1.5
into v_ename,
     v_job,
     v_sal,
     v_sal_inc
from emp1
where empno=7902;

/*select v_sal*1.5 
into v_sal_inc
from dual;*/

dbms_output.put_line('Employee Name is --> '||v_ename);
dbms_output.put_line('Employee Job is --> '||v_job);
dbms_output.put_line('Employee Salary is --> '||v_sal);
dbms_output.put_line('Employee Increased Salary is --> '||v_sal_inc);

End;

--------------------------------------------------------------------------------

Declare
v_ename varchar2(50);
v_job varchar2(50);
v_sal number(10);
v_sal_inc number(10);

Begin
select ename,
       job,
       sal
into v_ename,
     v_job,
     v_sal
from emp1
where empno=7902;

select v_sal*1.5 
into v_sal_inc
from dual;

dbms_output.put_line('Employee Name is --> '||v_ename);
dbms_output.put_line('Employee Job is --> '||v_job);
dbms_output.put_line('Employee Salary is --> '||v_sal);
dbms_output.put_line('Employee Increased Salary is --> '||v_sal_inc);

End;

--------------------------------------------------------------------------------

================================================================================
                            VARIABLE ATTRIBUTE
================================================================================

-Used in place of datatypes in variable or procedure parameter declaration in PL/SQL block
- Types A) Column Level B) Row level Attribute

--------------------------------------------------------------------------------
1) COLUMN LEVEL ATTRIBUTE(%type)
--------------------------------------------------------------------------------

- This Attribute is defined for individual columns
- Syntax : varible_Name table_name.column_name%type
           v_empno emp1.empno%
           
-------------PRACTICAL SCENARIO-------------------

desc emp1;

While table creation time [ename varchar2(10)]

After 1 year some business logic changed and size was increases [ename vrchar2(50

alter table emp1
modify ename varchar2(50);

rollback;

select * from emp1;

update emp1
set ename='Pramod Sutar'
where empno=0;

-------
Declare 
v_ename varchar2(10);
Begin
select ename into v_ename
from emp1
where empno=0;
dbms_output.put_line(v_ename);
End;
---------
--------Problem can be solved by %type----

Declare 
v_ename emp1.ename%type;
Begin
select ename into v_ename
from emp1
where empno=0;
dbms_output.put_line(v_ename);
End;

-------------PRACTICAL SCENARIO-------------------

1) Write a PL/SQL program for user entered empno, display name of the employee
and salary from emp table using %type.

set serverout on;

select * from emp1;

Declare
v_ename emp1.ename%type;
v_sal emp1.sal%type;

Begin
select ename,sal into v_ename,v_sal
from emp1 
where empno=&no;

dbms_output.put_line('Ename --> '||v_ename||', Salary-->'||v_sal);
End;

--------------------------------------------------------------------------------
                            2) Row Level Attribute(%rowtype)
--------------------------------------------------------------------------------

- In this a single variable represents all different datatypes in entire row in a
table.
- Also called as RECORD TYPE VARIBLE
- Syntax :
            variable_name table_name%rowtype
            i emp%rowtype;


Write a PL/SQL program for user entered empno, display name of the employee,
salary,hiredate from emp table using %type.

Declare
i emp1%rowtype;

Begin
select ename,sal,hiredate into i.ename,i.sal,i.hiredate
from emp1
where empno=&no;

dbms_output.put_line('Name-->'||i.ename||', salary-->'||i.sal||', Hiredate-->'||i.hiredate);
end;

--------------------------------------------------------------------------------

                                CONTROL STATEMENTS(LOOPS)

--------------------------------------------------------------------------------

1)Simple Loop

--------------------------------------------------------------------------------
Begin
loop
dbms_output.put_line('Welcome');
end loop;
end;

To exit from infinite loop
 a) Method 1: exit when true condition
 b) Method 2: using if
 
                        a) Method 1: exit when true condition

Declare
a number(10) :=1;

Begin
loop
dbms_output.put_line(a);
a:=a+1;
exit when a>10;
end loop;
end;

-----------------------------

                            b) Method 2: using if

Declare
a number(10) :=1;

Begin
loop
dbms_output.put_line(a);
a:=a+1;
if a>10 then
exit;
end if;
end loop;
end;

--------------------------------------------------------------------------------

2) While Loop

--------------------------------------------------------------------------------

Declare
a number(10) :=1;
Begin
while a<=10
loop
dbms_output.put_line(a);
a:=a+1;
end loop;
end;

--------------------------------------------------------------------------------

3) For Loop

--------------------------------------------------------------------------------

- Syntax :
            for index_varible_name in lower_bound..upper_bound
            for i in 1..10;

-- With declaring index variable
Declare
i number(10);

Begin
for i in 1..10
loop
dbms_output.put_line(i);
end loop;
end;

-- Without declaring
Begin
for a in 1..10
loop
dbms_output.put_line(a);
end loop;
end;

--Reverse order
Begin
for a in reverse 1..10
loop
dbms_output.put_line(a);
end loop;
end;

================================================================================
