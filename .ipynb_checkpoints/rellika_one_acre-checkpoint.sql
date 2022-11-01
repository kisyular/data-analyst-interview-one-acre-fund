-- Please run the code on the jupiter notebook to write the data from CSV to the MySQL table
-- Please dont forget to change the values for 'psw' and 'db' to your own values. Else the code will not work
use DataAnalysis; -- Change the database name to your own database name

-- Select data from table
SELECT * FROM rellika_one_acre;

-- calculate how many days ago or in the future a date is from today. Write the result to a new column called 'days_ago'
SELECT 
    next_contract_payment_due_date,
    DATEDIFF(NOW(), next_contract_payment_due_date) AS days_ago
FROM rellika_one_acre;

-- If value is less than 0, then add column and indicate value is 'On Time'
-- If value is between 0 and 7, then add column and indicate value is 'PAR0-7'
-- If value is between 8 and 30, then add column and indicate value is 'PAR8-30'
-- If value is between 31 and 90, then add column and indicate value is 'PAR31-90'
-- If value is greater than 90, then add column and indicate value is 'PAR90+'

SELECT 
   *,
    DATEDIFF(NOW(), next_contract_payment_due_date) AS days_ago,
    CASE
        WHEN DATEDIFF(NOW(), next_contract_payment_due_date) < 0 THEN 'On Time'
        WHEN DATEDIFF(NOW(), next_contract_payment_due_date) BETWEEN 0 AND 7 THEN 'PAR0-7'
        WHEN DATEDIFF(NOW(), next_contract_payment_due_date) BETWEEN 8 AND 30 THEN 'PAR8-30'
        WHEN DATEDIFF(NOW(), next_contract_payment_due_date) BETWEEN 31 AND 90 THEN 'PAR31-90'
        WHEN DATEDIFF(NOW(), next_contract_payment_due_date) > 90 THEN 'PAR90+'
    END AS payment_status
FROM rellika_one_acre;
