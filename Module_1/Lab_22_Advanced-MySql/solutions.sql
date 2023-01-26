use publications;

# most profiting authors

# CHALLENGE 1
# Step 1 Calculating royalty of each sale for each author
SELECT sales.title_id, titleauthor.au_id, titles.advance * titleauthor.royaltyper / 100 as advance, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
FROM sales
LEFT JOIN titleauthor
ON sales.title_id = titleauthor.title_id
LEFT JOIN titles
ON sales.title_id = titles.title_id;

# Step 2 : aggregating total royalties for each title and author
SELECT title_id, au_id, sum(advance) as total_advance, sum(sales_royalty) as total_royalty
FROM (SELECT sales.title_id, titleauthor.au_id, titles.advance * titleauthor.royaltyper / 100 as advance, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
	FROM sales
	LEFT JOIN titleauthor
	ON sales.title_id = titleauthor.title_id
	LEFT JOIN titles
	ON sales.title_id = titles.title_id
) summary
GROUP BY title_id, au_id
;

# Step 3:Calculate the total profits of each author
SELECT au_id, sum(total_advance+total_royalty) as total_profit
FROM (
	SELECT title_id, au_id, sum(advance) as total_advance, sum(sales_royalty) as total_royalty
	FROM (SELECT sales.title_id, titleauthor.au_id, titles.advance * titleauthor.royaltyper / 100 as advance, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
		FROM sales
		LEFT JOIN titleauthor
		ON sales.title_id = titleauthor.title_id
		LEFT JOIN titles
		ON sales.title_id = titles.title_id
	) summary
	GROUP BY title_id, au_id
) summary
GROUP by au_id
;

# CHALLENGE 2
# Step 1 Calculating royalty of each sale for each author
CREATE TEMPORARY TABLE publications.royalty_book_summary
SELECT sales.title_id, titleauthor.au_id, titles.advance * titleauthor.royaltyper / 100 as advance, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
FROM sales
LEFT JOIN titleauthor
ON sales.title_id = titleauthor.title_id
LEFT JOIN titles
ON sales.title_id = titles.title_id;

SELECT * FROM publications.royalty_book_summary;

# Step 2 : aggregating total royalties for each title and author
CREATE TEMPORARY TABLE publications.royalty_aggreg
SELECT title_id, au_id, sum(advance) as total_advance, sum(sales_royalty) as total_royalty
FROM publications.royalty_book_summary
GROUP BY title_id, au_id
;

SELECT * FROM publications.royalty_aggreg;

# Step 3: Calculate the total profits of each author
CREATE TEMPORARY TABLE publications.profits
SELECT au_id, sum(total_advance+total_royalty) as total_profit
FROM publications.royalty_aggreg
GROUP by au_id
;

SELECT * FROM publications.profits;

CREATE TABLE publications.most_profiting_authors
SELECT * 
FROM publications.profits;

SELECT * FROM publications.most_profiting_authors;