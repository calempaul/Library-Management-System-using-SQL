
-- Project TASK

-- Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

create table books
(
            isbn varchar(50) primary key,
            book_title varchar(80),
            category varchar(30),
            rental_price decimal(10,2),
            status varchar(10),
            author varchar(30),
            publisher varchar(30)
);
insert into books(isbn,book_title,category,rental_price,status,author,publisher)
values ('978-1-60129-456-2','To Kill a Mockingbird','Classic',6.00,'yes','Harper Lee','J.B. Lippincott & Co.');


-- Task 2: Update an Existing Member's Address
update members
set member_address ='125 main St'
where member_id = "C101";


-- Task 3: Delete a Record from the Issued Status Table
delete from issued_status
where issued_id = "IS109";
-- Objective: Delete the record with issued_id = 'IS104' from the issued_status table.

-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
select issued_book_name,issued_emp_id from issued_status
where issued_emp_id = "E101";

-- Task 5: List Members Who Have Issued More Than One Book
select count(s.issued_id) count ,m.member_name from
issued_status s
join
members m
on s.issued_member_id = m.member_id
group by m.member_name
having count>1
order by count desc;
-- Objective: Use GROUP BY to find members who have issued more than one book.


-- ### 3. CTAS (Create Table As Select)


-- Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt
create table book_count
as
select b.book_title, count(b.isbn) as c from 
books b
join 
issued_status ist
on b.isbn = ist.issued_book_isbn
group by b.book_title
order by  c desc;

select * from  book_count;

-- ### 4. Data Analysis & Findings

-- Task 7. **Retrieve All Books in a Specific Category:
select count(book_title),category
from books
group by category;
-- Task 8: Find Total Rental Income by Category:
select sum(rental_price),ist.issued_book_name from
books b 
join issued_status ist
on b.isbn = ist.issued_book_isbn
group by issued_book_name;

-- Task 9: List Employees with Their Branch Manager's Name and their branch details**:
select 
    e1.*,
    b.manager_id,
    e2.emp_name as manager
from employees as e1
join  
branch as b
on b.branch_id = e1.branch_id
join
employees as e2
on b.manager_id = e2.emp_id;

-- Task 10. Create a Table of Books with Rental Price Above a Certain Threshold
create table price_greater_then
as (select * from books
where rental_price >7);

select * from  price_greater_then;

-- Task 11: Retrieve the List of Books Not Yet Returned
select
 ist.issued_book_name from
issued_status ist
left join
return_status rs 
on ist.issued_id = rs.issued_id
where rs.return_id is null;

