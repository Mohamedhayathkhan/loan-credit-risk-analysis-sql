create database Loan_Credit_Analysis;
use Loan_Credit_Analysis;
select * 
from Current_loans;
Select * from current_loans;
select count(*) as total_rows from demographics;
use Loan_Credit_Analysis;
show tables;

describe traindemographics;
describe trainperf;


select * from trainperf limit 10;
describe trainprevious;
select * from trainprevious limit 10;
describe trainprevious;
select * from trainprevious limit 10;

select count(*) as total_loans from trainperf;
select sum(loanamount) as total_loans_amount from trainperf;
select avg(loanamount) as total_loans_amount from trainperf;
select sum(totaldue) as total_amount_due from trainperf;
select good_bad_flag,
count(*) as number_of_loans
from trainperf group by good_bad_flag;
select good_bad_flag,
count(*) as number_of_loans,
round(count(*) * 100.0 / (select count(*) from trainperf), 2) as percentage
from trainperf group by good_bad_flag;

select 
good_bad_flag,
count(*) as number_of_loans,
round(avg(loanamount), 2) as average_loan_amount,
round(avg(totaldue), 2) as average_amount_due
from trainperf
group by good_bad_flag;

select
loannumber,
count(*) as number_of_loans,
sum(case when good_bad_flag = 'Good' then 1 else 0 end) as good_loans,
sum(case when good_bad_flag = 'Bad' then 1 else 0 end) as bad_loans
from trainperf
group by loannumber
order by loannumber;

select
loannumber,
count(*) as total_loans,
sum(case when good_bad_flag = 'Bad' then 1 else 0 end) as bad_loans,
round(
sum(case when good_bad_flag = 'Bad' then 1 else 0 end)
*100.0 / count(*),
2
) as bad_loan_rate
from trainperf
group by loannumber
order by loannumber;

select
loannumber,
count(*) as total_loans,
sum(case when good_bad_flag = 'Bad' then 1 else 0 end) as bad_loans,
round(
sum(case when good_bad_flag = 'Bad' then 1 else 0 end)
* 100.0 / count(*),
2
) as bad_loan_rate
from trainperf
group by loannumber
order by bad_loan_rate desc;

select
customerid,
count(*) as total_loans,
sum(case when good_bad_flag = 'Good' then 1 else 0 end) as good_lonas,
sum(case when good_bad_flag = 'Bad' then 1 else 0 end) as bad_loans
from trainperf
group by customerid
having count(*) > 1
order by bad_loans desc;

select
customerid,
count(*) as previous_loans
from trainprevious
group by customerid
order by previous_loans desc
limit 10;

select 
round(avg(previous_loan_count), 2) as average_previous_loans
from (
select
customerid,
count(*) as previous_loan_count
from trainprevious
group by customerid) as customer_history;

select 
p.customerid,
count(p.systemloanid) as previous_loans,
c.good_bad_flag
from trainprevious p
join trainperf c
on p.customerid = c.customerid
group by
p.customerid,
c.good_bad_flag
limit 20;

select
case 
when previous_loans between 1 and 3 then ' 1-3 previous loans'
when previous_loans between 4 and 6 then ' 4-6 previous loans'
else '7+ previous loans'
end as loan_history_group,
good_bad_flag,
count(*) as number_of_customers
from (
select
p.customerid,
count(p.systemloanid) as previous_loans,
c.good_bad_flag
from trainprevious p
join trainperf c
on p.customerid = c.customerid
group by p.customerid, c.good_bad_flag)
as customer_history
group by loan_history_group, good_bad_flag
order by loan_history_group, good_bad_flag;

select
case 
when previous_loans = 0 then 'No previous loans'
when previous_loans between 1 and 3 then ' 1-3 previous loans'
when previous_loans between 4 and 6 then ' 4-6 previous loans'
else '7+ previous loans'
end as loan_history_group,
count(*) as total_customers,
sum(case when good_bad_flag = 'Bad' then 1 else 0 end) as bad_customers,
round(
sum(case when good_bad_flag = 'Bad' then 1 else 0 end)
* 100.0 / count(*),
2
) as bad_loans_rate
from (
select
p.customerid,
count(p.systemloanid) as previous_loans,
c.good_bad_flag
from trainprevious p
join trainperf c
on p.customerid = c.customerid
group by p.customerid, c.good_bad_flag
) as customer_history
group by laon_history_group
order by bad_loan_rate desc;

SELECT
    CASE
        WHEN previous_loans BETWEEN 1 AND 3 THEN '1-3 previous loans'
        WHEN previous_loans BETWEEN 4 AND 6 THEN '4-6 previous loans'
        ELSE '7+ previous loans'
    END AS loan_history_group,

    COUNT(*) AS total_customers,

    SUM(CASE
        WHEN good_bad_flag = 'Bad' THEN 1
        ELSE 0
    END) AS bad_customers,

    ROUND(
        SUM(CASE
            WHEN good_bad_flag = 'Bad' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS bad_loan_rate

FROM (
    SELECT
        p.customerid,
        COUNT(p.systemloanid) AS previous_loans,
        c.good_bad_flag
    FROM trainprevious p
    JOIN trainperf c
        ON p.customerid = c.customerid
    GROUP BY p.customerid, c.good_bad_flag
) AS customer_history

GROUP BY loan_history_group
ORDER BY bad_loan_rate DESC;

SELECT
    d.employment_status_clients,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN p.good_bad_flag = 'Bad' THEN 1 ELSE 0 END) AS bad_customers,
    ROUND(
        SUM(CASE WHEN p.good_bad_flag = 'Bad' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS bad_loan_rate
FROM traindemographics d
JOIN trainperf p
    ON d.customerid = p.customerid
GROUP BY d.employment_status_clients
ORDER BY bad_loan_rate DESC;

select
d.bank_account_type,
count(*) as total_customers,
sum(case
when p.good_bad_flag = 'Bad' then 1 else 0
end) as bad_customers,
round(
sum(case
when p.good_bad_flag = 'Bad' then 1 else 0 
end)  * 100.0 / count(8),
2
) as bad_loan_rate
from traindemographics d
join trainperf p
on d.customerid = p.customerid
group by d.bank_account_type
order by bad_loan_rate desc;

with customer_loan_summary as (
select
customerid,
count(*) as total_loans,
sum(loanamount) as total_loan_amount,
sum(totaldue) as total_amount_due,
sum(case
when good_bad_flag = 'Bad' then 1 else 0
end) as bad_loans
from trainperf
group by customerid
)
select
customerid,
total_loans,
total_loan_amount,
total_amount_due,
bad_loans,
round(
total_amount_due - total_loan_amount,
2
) as total_interest_or_charges
from customer_loan_summary
order by total_loan_amount desc
limit 10;
