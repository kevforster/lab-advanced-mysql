#challenge 1

#1st query
SELECT titles.title_id, titleauthor.au_id, (titles.advance * titleauthor.royaltyper / 100) AS advance, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty
FROM titles
JOIN titleauthor ON titles.title_id=titleauthor.title_id
JOIN sales ON titles.title_id=sales.title_id;

#1st and 2nd query
SELECT title_id, au_id, sum(input1.sales_royalty) AS sum_royalty, sum(input1.advance) AS sum_advance
FROM (SELECT titles.title_id, titleauthor.au_id, (titles.advance * titleauthor.royaltyper / 100) 	AS 	advance, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) 	AS 	sales_royalty
	FROM titles
	JOIN titleauthor ON titles.title_id=titleauthor.title_id
	JOIN sales ON titles.title_id=sales.title_id) AS input1
GROUP BY au_id, title_id;

#1st 2nd and 3rd query
SELECT au_id, (output2.sum_royalty + output2.sum_advance) AS profit
FROM (SELECT title_id, au_id, sum(input1.sales_royalty) AS sum_royalty, sum(input1.advance) AS 		sum_advance
	FROM (SELECT titles.title_id, titleauthor.au_id, (titles.advance * titleauthor.royaltyper / 		100) 	AS 	advance, (titles.price * sales.qty * titles.royalty / 100 * 						titleauthor.royaltyper / 100) 	AS 	sales_royalty
		FROM titles
		JOIN titleauthor ON titles.title_id=titleauthor.title_id
		JOIN sales ON titles.title_id=sales.title_id) AS input1
		GROUP BY au_id, title_id) AS output2
ORDER BY profit DESC
LIMIT 3;

#challenge 2 - result: creating a temporary table with the results from challenge 1:
CREATE A TEMPORARY TABLE results SELECT au_id, (output2.sum_royalty + output2.sum_advance) AS profit FROM (SELECT title_id, au_id, sum(input1.sales_royalty) AS sum_royalty, sum(input1.advance) AS sum_advance FROM (SELECT titles.title_id, titleauthor.au_id, (titles.advance * titleauthor.royaltyper / 100) AS advance, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) 	AS 	sales_royalty FROM titles JOIN titleauthor ON titles.title_id=titleauthor.title_id JOIN sales ON titles.title_id=sales.title_id) AS input1 GROUP BY au_id, title_id) AS output2 ORDER BY profit DESC LIMIT 3;

#challenge3: 
CREATE TABLE most_profiting_authros SELECT au_id, (output2.sum_royalty + output2.sum_advance) AS profit FROM (SELECT title_id, au_id, sum(input1.sales_royalty) AS sum_royalty, sum(input1.advance) AS sum_advance FROM (SELECT titles.title_id, titleauthor.au_id, (titles.advance * titleauthor.royaltyper / 100) AS advance, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty FROM titles JOIN titleauthor ON titles.title_id=titleauthor.title_id JOIN sales ON titles.title_id=sales.title_id) AS input1 GROUP BY au_id, title_id) AS output2 ORDER BY profit DESC;