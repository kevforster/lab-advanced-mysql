
SELECT titles.title_id, titleauthor.au_id, (titles.advance * titleauthor.royaltyper / 100) AS advance, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty
FROM titles
JOIN titleauthor ON titles.title_id=titleauthor.title_id
JOIN sales ON titles.title_id=sales.title_id;

SELECT title_id, au_id, sum(input1.sales_royalty) AS sum_royalty, sum(input1.advance) AS sum_advance
FROM (SELECT titles.title_id, titleauthor.au_id, (titles.advance * titleauthor.royaltyper / 100) 	AS 	advance, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) 	AS 	sales_royalty
	FROM titles
	JOIN titleauthor ON titles.title_id=titleauthor.title_id
	JOIN sales ON titles.title_id=sales.title_id) AS input1
GROUP BY au_id, title_id;

SELECT au_id, (output2.sum_royalty + output2.sum_advance) AS profit
FROM (SELECT title_id, au_id, sum(input1.sales_royalty) AS sum_royalty, sum(input1.advance) AS 		sum_advance
	FROM (SELECT titles.title_id, titleauthor.au_id, (titles.advance * titleauthor.royaltyper / 		100) 	AS 	advance, (titles.price * sales.qty * titles.royalty / 100 * 						titleauthor.royaltyper / 100) 	AS 	sales_royalty
		FROM titles
		JOIN titleauthor ON titles.title_id=titleauthor.title_id
		JOIN sales ON titles.title_id=sales.title_id) AS input1
		GROUP BY au_id, title_id) AS output2
ORDER BY profit DESC
LIMIT 3;