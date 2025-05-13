-- NETFLIX
-- Step 1. Create the Data Base
CREATE database MOVIES;
SELECT * FROM netflix_titles;

-- Step 2.Bussiness Problems?
-- 1. Count the number of Movies vs TV Shows
select type,count(*) as Count_of_Movie_TV
from netflix_titles
group by type;

-- 2. Find the most common rating for movies and TV shows
with RatingCounts as (
select type,rating ,count(*) as rating_count
from netflix_titles
group by type,rating
),
Rating_Rank as(
select type,rating,
rating_count, rank() over(partition by type order by rating_count) as rnk
from RatingCounts) select type,rating as most_frequent_rating
from Rating_Rank
where rnk=1;


-- 3. List all movies released in a specific year (e.g., 2020)
select * 
from netflix_titles
where release_year=2020;

-- 4. Find the top 5 countries with the most content on Netflix
select country,count(*) as most_content
from netflix_titles
where country is not null
group by country
order by count(*) 
limit 5;

-- 5. Identify the longest movie
select title,duration
from netflix_titles
where type='Movie'
order by duration asc;

-- 6. Find content added in the last 5 years
select * from netflix_titles;
SELECT *
FROM netflix_titles
WHERE release_year>= DATE_SUB(2021, INTERVAL 5 YEAR);

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
select *
from netflix_titles
where director like '%Rajiv Chilaka%';

-- 8. List all TV shows with more than 5 seasons
with Durations as(
select title,type,duration,rank() over(partition by type order by duration) as dur
from netflix_titles
where type='TV Show')
select title,type,duration as More_Seasons
from Durations
order by dur desc
limit 5;
select * from netflix_titles;
-- 9. Count the number of content items in each genre
SELECT listed_in AS genre_combo, COUNT(*) AS content_count
FROM netflix_titles
GROUP BY listed_in
ORDER BY content_count DESC
limit 5;

-- 10.Find each year and the average numbers of 
-- content release in India on netflix. 
-- return top 5 year with highest avg content release!
select avg(length(listed_in)) as average_content,country,release_year,title
from netflix_titles
group by country,release_year,title
having country='India'
order by average_content desc
limit 5;

-- 11. List all movies that are documentaries
select * from netflix_titles;
select *
from netflix_titles
where listed_in like '%Documentaries%';

-- 12. Find all content without a director
select *
from netflix_titles
where director is null or director='';

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
select *
from netflix_titles
where 
type='Movie'
and country='India'
and cast like 'Salman Khan'
and release_year>=date_sub(curdate(),interval 10 year);

-- 14. Find the top 10 actors who have appeared in the 
-- highest number of movies produced in India.
SELECT cast, COUNT(*) AS movie_count
FROM netflix_titles
WHERE country LIKE '%India%' AND type = 'Movie' AND cast IS NOT NULL
GROUP BY cast
ORDER BY movie_count DESC
LIMIT 10;

-- 15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.
select * from netflix_titles;
select 
case
when lower(description) like '%kill%' or lower(description) like '%violence%' then 'Bad'
else 'Good'
end as content_label,
count(*) as total_count
from netflix_titles
group by content_label;














