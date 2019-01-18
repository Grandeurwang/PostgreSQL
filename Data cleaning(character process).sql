#####functions: LEFT,RIGHT,POSITION,STRPOS,LOWER,UPPER,
CONCAT(||),CAST(::),COALESCE,REPLACE,TRIM,SUBSTR

#QUIZ

#3.
SELECT RIGHT(website,3) last_digits,COUNT(RIGHT(website,3))
FROM accounts
GROUP BY 1
ORDER BY 2

SELECT LEFT(name,1) initial,COUNT(LEFT(name,1))
FROM accounts
GROUP BY 1
ORDER BY 2 DESC

SELECT CASE WHEN initial IN ('0','1','2','3','4','5','6','7','8','9') THEN 'number initial'
ELSE 'letter initial' END AS initial_type,
SUM(count)
FROM (SELECT LEFT(name,1) initial,COUNT(LEFT(name,1))
FROM accounts
GROUP BY 1
ORDER BY 2 DESC) a
GROUP BY 1
ORDER BY 2

SELECT CASE WHEN initial IN ('a','e','i','o','u','A','E','I','O','U') THEN 'vowels initial'
            ELSE 'non-vowels initial' END AS vowels,
SUM(count)
FROM (SELECT LEFT(name,1) initial,COUNT(LEFT(name,1))
FROM accounts
GROUP BY 1
ORDER BY 2 DESC) a
GROUP BY 1
ORDER BY 2 DESC

#6.
SELECT DISTINCT LEFT(primary_poc,STRPOS(primary_poc,' ')-1) first_name,
RIGHT(primary_poc,LENGTH(primary_poc)-STRPOS(primary_poc,' ')) second_name
FROM accounts

SELECT DISTINCT LEFT(name,STRPOS(name,' ')-1) first_name,
RIGHT(name,LENGTH(name)-STRPOS(name,' ')) second_name
FROM sales_reps

#9.
SELECT company,
first_name||' '||last_name AS name,
first_name||'.'||last_name||'@'||company||'.com' AS email
FROM
(SELECT LEFT(primary_poc,STRPOS(primary_poc,' ')-1) first_name,
RIGHT(primary_poc,LENGTH(primary_poc)-STRPOS(primary_poc,' ')) last_name,
name AS company
FROM accounts) sub

SELECT LOWER(REPLACE(email,' ','')) AS email,company,name
FROM
(SELECT company,
first_name||' '||last_name AS name,
first_name||'.'||last_name||'@'||company||'.com' AS email
FROM
(SELECT LEFT(primary_poc,STRPOS(primary_poc,' ')-1) first_name,
RIGHT(primary_poc,LENGTH(primary_poc)-STRPOS(primary_poc,' ')) last_name,
name AS company
FROM accounts) sub) sub2

SELECT LOWER(LEFT(first_name,1)||RIGHT(first_name,1)||LEFT(last_name,1)||RIGHT(last_name,1))||LENGTH(first_name)||LENGTH(last_name)||REPLACE(company,' ','') AS password
FROM (SELECT LEFT(primary_poc,STRPOS(primary_poc,' ')-1) first_name,
RIGHT(primary_poc,LENGTH(primary_poc)-STRPOS(primary_poc,' ')) last_name,
UPPER(name) company
FROM accounts) sub

#12.
1
SELECT *
FROM sf_crime_data
LIMIT 10

2
SELECT (RIGHT(time1,4)||'-'||LEFT(time1,5))::date date1
FROM (SELECT REPLACE(SUBSTR(s.date,1,10),'/','-') time1
FROM sf_crime_data s) sub

#15.
SELECT COALESCE(id,1) id,COALESCE(account_id,1) account_id,COALESCE(qty,0) qty,COALESCE(usd,0) usd,
FROM (SELECT *
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL) sub
