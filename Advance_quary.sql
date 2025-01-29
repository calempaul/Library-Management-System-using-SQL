
### Advanced SQL Operations

/* Task 13: Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 30-day return period). 
Display the member's name, book title, issue date, and days overdue.*/

select current_date();

SELECT DATEDIFF(current_date(), issued_status.issued_date) AS difference_in_days
FROM issued_status;

select 
ist . issued_member_id,
m.member_name,
 b.book_title,
 ist.issued_date,
 rs.return_date,
 DATEDIFF(current_date(), ist.issued_date) AS over_dues
 from 
issued_status ist 
join members m
on ist.issued_member_id=m.member_id
join
books b
on ist.issued_book_isbn= b.isbn
left join 
return_status rs
on rs.issued_id=ist.issued_id
where  rs.return_date is NULL;

/*Task 14: Update Book Status on Return
Write a query to update the status of books in the books table to "available" when they are returned
 (based on entries in the return_status table).*/


SELECT * FROM issued_status
WHERE issued_book_isbn = '978-0-451-52994-2';
-- IS104

SELECT * FROM books
WHERE isbn = '978-0-451-52994-2';

UPDATE books
SET status = 'no'
WHERE isbn = '978-0-451-52994-2';

SELECT * FROM return_status
WHERE issued_id = 'IS130';

UPDATE books
SET status = 'yes'
WHERE isbn = '978-0-451-52994-2';

-- 
INSERT INTO return_status(return_id, issued_id, return_date)
VALUES
('RS125', 'IS130', CURRENT_DATE);
SELECT * FROM return_status
WHERE issued_id = 'IS130';

/*Task 15: Branch Performance Report
Create a query that generates a performance report for each branch, showing the number of books issued, 
the number of books returned, and the total revenue generated from book rentals.*/
CREATE TABLE branch_reports
AS
SELECT 
    b.branch_id,
    b.manager_id,
    COUNT(ist.issued_id) as number_book_issued,
    COUNT(rs.return_id) as number_of_book_return,
    SUM(bk.rental_price) as total_revenue
FROM issued_status as ist
JOIN 
employees as e
ON e.emp_id = ist.issued_emp_id
JOIN
branch as b
ON e.branch_id = b.branch_id
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
JOIN 
books as bk
ON ist.issued_book_isbn = bk.isbn
GROUP BY 1, 2;

SELECT * FROM branch_reports;

/*Task 16: Find Employees with the Most Book Issues Processed
Write a query to find the top 3 employees who have processed the most book issues. 
Display the employee name, number of books processed, and their branch.*/

SELECT 
    e.emp_name,
    b.*,
    COUNT(ist.issued_id) as no_book_issued
FROM issued_status as ist
JOIN
employees as e
ON e.emp_id = ist.issued_emp_id
JOIN
branch as b
ON e.branch_id = b.branch_id
GROUP BY 1, 2;

-- END OF THE PROJECT

