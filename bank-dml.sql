/*|1-1|Find the name, loan number and loan amount of all customers; rename the column name loan_number as loan_id.*/
select c1.customer_name,b1.loan_number as loan_id, amount
from customer as c1,borrower as b1,loan as l1
where c1.customer_name = b1.customer_name and b1.loan_number = l1.loan_number
order by c1.customer_name;

/*|1-2|Find the names of all customers whose street includes the substring “Main”.*/
select c1.customer_name
from customer as c1
where c1.customer_street = 'Main';

/*|1-3|Find all customers who have a loan, an account, or both:*/
select distinct c1.customer_name
from customer as c1, borrower as b1, depositor as d1
where  c1.customer_name = b1.customer_name or c1.customer_name = d1.customer_name;

/*|1-4|Find all customers who have both a loan and an account.*/
select distinct c1.customer_name
from customer as c1,borrower as b1,depositor as d1
where c1.customer_name = b1.customer_name and c1.customer_name = d1.customer_name;

/*|1-5|Find all customers who have an account but no loan.*/
select c1.customer_name
from customer as c1
where c1.customer_name in 
(select customer_name
	from depositor) and c1.customer_name not in
(select customer_name
	from borrower);
/*
select c1.customer_name
from customer as c1
where c1.customer_name not in (select customer_name
from depositor) and c1.customer_name  in
(select customer_name from borrower);*/

/*|1-6|Find the average account balance at the Perryridge branch.*/
select avg(assets)
from branch
where branch_name = 'Perryridge';

/*|1-7|ind the number of tuples in the customer relation.*/
select count(customer_name)
from customer;

/*|1-8|Find the number of depositors in the bank.*/
select count(customer_name)
from depositor;

/*|1-9|Find the number of depositors for each branch.*/
select branch_name,count(customer_name)
from depositor,account
where depositor.account_number = account.account_number
group by branch_name;

/*|1-10|Find the names of all branches where the average account balance is more than $1,200.*/

select branch_name,avg_balance
from (select branch_name,avg(balance)
	  from account
	  group by branch_name)
as branch_avg(branch_name,avg_balance)
where avg_balance>1200;

/*|1-11|Find all loan number which appear in the loan relation with null values for amount.*/
select loan_number
from loan
where amount is null;

/*|1-12|Find all customers who have both an account and a loan at the bank.*/
select distinct customer_name
from borrower
where customer_name in
(select customer_name from depositor);

/*|1-13|Find all customers who have a loan at the bank but do not have an account at the bank*/
select distinct customer_name
from borrower
where customer_name not in (select customer_name from depositor);

/*|1-14|Find all customers who have both an account and a loan at the Perryridge branch*/
select distinct customer_name
from borrower,loan
where borrower.loan_number = loan.loan_number
and branch_name = 'Perryridge' and
(branch_name,customer_name)in (select branch_name,customer_name
from depositor,account
where depositor.account_number = account.account_number);

/*|1-15|Find all branches that have greater assets than some branch located in Brooklyn.*/
select branch_name
from branch
where assets > some(select assets
from branch
where branch_city='Brooklyn');

/*|1-16|Find the names of all branches that have greater assets than all branches located in Brooklyn.*/
select branch_name
from branch
where assets>all(select assets
from branch
where branch_city = 'Brooklyn');


/*|2-1|Find all customers who have both an account and a loan at the bank.*/
select distinct customer_name
from borrower
where customer_name in
(select customer_name from depositor);

/*|2-2|Find all customers who have a loan at the bank but do not have an account at the bank*/
select distinct customer_name
from borrower
where customer_name not in (select customer_name from depositor);

/*|2-3|Find all customers who have both an account and a loan at the Perryridge branch*/
select distinct customer_name
from borrower,loan
where borrower.loan_number = loan.loan_number
and branch_name = 'Perryridge' and
(branch_name,customer_name)in (select branch_name,customer_name
from depositor,account
where depositor.account_number = account.account_number);

/*|2-4|Find all branches that have greater assets than some branch located in Brooklyn.*/
select branch_name
from branch
where assets > some(select assets
from branch
where branch_city='Brooklyn');

/*|2-5|Find the names of all branches that have greater assets than all branches located in Brooklyn.*/
select branch_name
from branch
where assets>all(select assets
from branch
where branch_city = 'Brooklyn');

/*|2-6|Find all customers who have an account at all branches located in Brooklyn.*/
select customer.customer_name
from customer join depositor on customer.customer_name = depositor.customer_name
join account on account.account_number = depositor.account_number
join branch on branch.branch_name = account.branch_name
and branch_city = 'Brooklyn';

/*
select distinct S.customer_name
from depositor as S
where not exists(
(select branch_name
from branch
where branch_city = 'Brooklyn')
except
(select R.branch_name
	from depositor as T,account as R
	where T.account_number = R.account_number
	and S.customer_name = T.customer_name));
*/
/*|2-7|Create a view consisting of branches and their customers*/
/*create view all_customer as
	(select branch_name,customer_name
	from depositor,account
	where depositor.account_number = account.account_number)
	union 
	(select branch_name,customer_name
	from borrower,loan
	where borrower.loan_number = loan.loan_number);*/

select customer.customer_name,branch.branch_name
from customer join depositor on customer.customer_name = depositor.customer_name
join account on account.account_number = depositor.account_number
join branch on branch.branch_name = account.branch_name;

/*|2-8|Delete all account tuples at the Perryridge branch*/
use bank;
SET FOREIGN_KEY_CHECKS = 0;
delete from account
where branch_name = 'Perryridge';
SET FOREIGN_KEY_CHECKS = 1;

/*|2-9|Delete all accounts at every branch located in the city ‘Needham’.*/
delete from account
where branch_name in(select branch_name
from branch
where branch_city = 'Needham');

/*|2-10|Delete the record of all accounts with balances below the average at the bank.*/
delete from account
	where balance<(select avg(balance));

/*|2-11|Add a new tuple ('A-9732', 'Perryridge', 1200) to account*/
insert into account
	values('A-9732', 'Perryridge', 1200);

/*|2-12|Add a new tuple ('A-777','Perryridge' ) to account with balance set to null*/
insert into account
	values('A-777', 'Perryridge', null);

/*|2-13|Provide as a gift for all loan customers of the Perryridge branch, a $200 savings account. Let the loan number serve as the account number for the new savings account*/
insert into account
	select loan_number,branch_name,200
	from loan
	where branch_name = 'Perryridge';

/*|2-14|Increase all accounts with balances over $10,000 by 6%, all other accounts receive 5%.*/  
update account
	set balance = balance * 1.06
	where balance > 10000;
update account
	set balance = balance * 1.05
	where balance <= 10000;
/*|2-15|Find the names of all customers whose street match the name “Main%”*/
select customer_name
from customer
where customer_street like '%Main%';

/*|2-16|List in alphabetic order the names of all customers having a loan in Perryridge branch*/
select distinct customer_name
from borrower,loan
where borrower.loan_number = loan.loan_number 
and branch_name = 'Perryridge'
order by customer_name;




