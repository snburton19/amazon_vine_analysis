-- Recreate the vine_table
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

-- Filter the data and create a new table (1) to retrieve all the rows where the total_votes count is ≥20.

SELECT *
INTO table_1
FROM vine_table
WHERE (total_votes >= 20);

SELECT * FROM table_1;


-- Filter the new table and create a new table (2) to retrieve all the rows where the number of helpful_votes divided by total_votes is ≥50%.

SELECT *
INTO table_2
FROM table_1
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5;

SELECT * FROM table_2;


-- Filter the new table and create a new table (3) that retrieves all the rows where a review was written as part of the Vine program (paid).

SELECT *
INTO table_3
FROM table_2
WHERE (vine = 'Y');

SELECT * FROM table_3;


-- Filter table (2) and create a new table (4) that retrieves all the rows where the review was not part of the Vine program (unpaid).

SELECT *
INTO table_4
FROM table_2
WHERE (vine = 'N');

SELECT * FROM table_4;


-- Determine the total number of reviews, the number of 5-star reviews, and the percentage of 5-star reviews for the two types (paid vs. unpaid).

-- Paid
-- Total number of reviews
SELECT COUNT(review_id) AS count_total_reviews FROM table_3;
-- Number of 5-star reviews
SELECT COUNT(review_id) AS count_five_star_reviews FROM table_3
WHERE (star_rating = 5);
-- Percentage of 5-star reviews
SELECT CAST(t5.five_star_reviews AS FLOAT) / CAST(t6.total_reviews AS FLOAT) * 100 AS percent_five_star_reviews
FROM
(SELECT count(review_id) as five_star_reviews FROM table_3 WHERE(star_rating = 5)) as t5, 
(SELECT count(review_id) as total_reviews FROM table_3) as t6;

-- Unpaid
-- Total number of reviews
SELECT COUNT(review_id) FROM table_4;
-- Number of 5-star reviews
SELECT COUNT(review_id) FROM table_4
WHERE (star_rating = 5);
-- Percentage of 5-star reviews
SELECT CAST(t5.five_star_reviews AS FLOAT) / CAST(t6.total_reviews AS FLOAT) * 100 AS percent_five_star_reviews
FROM
(SELECT count(review_id) as five_star_reviews FROM table_4 WHERE(star_rating = 5)) as t5, 
(SELECT count(review_id) as total_reviews FROM table_4) as t6;