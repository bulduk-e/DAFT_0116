USE publications;

# Challenge 1
SELECT authors.au_id, authors.au_lname, authors.au_fname, titles.title, publishers.pub_name
FROM authors
INNER JOIN titleauthor
ON authors.au_id = titleauthor.au_id
LEFT JOIN titles
ON titleauthor.title_id = titles.title_id
LEFT JOIN publishers
ON titles.pub_id = publishers.pub_id;

SELECT * FROM publications.titleauthor;

# Challenge 2
SELECT authors.au_lname, authors.au_fname, publishers.pub_name, count(titles.title) as Num_Title
FROM authors
INNER JOIN titleauthor
ON authors.au_id = titleauthor.au_id
LEFT JOIN titles
ON titleauthor.title_id = titles.title_id
LEFT JOIN publishers
ON titles.pub_id = publishers.pub_id
GROUP BY authors.au_id, publishers.pub_name;

# Challenge 3
SELECT authors.au_id as Author_ID, authors.au_lname as Last_Name, authors.au_fname as First_Name, sum(sales.qty) as Num_sold
FROM authors
INNER JOIN titleauthor
ON authors.au_id = titleauthor.au_id
INNER JOIN sales
ON  titleauthor.title_id = sales.title_id
GROUP BY authors.au_id
ORDER BY Num_sold DESC
LIMIT 3;

# Challenge 4
SELECT authors.au_id as Author_ID, authors.au_lname as Last_Name, authors.au_fname as First_Name, IFNULL(SUM(sales.qty),0) as Num_sold
FROM authors
LEFT JOIN titleauthor
ON authors.au_id = titleauthor.au_id
LEFT JOIN sales
ON  titleauthor.title_id = sales.title_id
GROUP BY authors.au_id
ORDER BY Num_sold DESC;
