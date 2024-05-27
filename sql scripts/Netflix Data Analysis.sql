select *
from netflix_movies_tvshows nmt 

--1.Number of TV Shows vs Movies 
select type, count(*) as count
from netflix_movies_tvshows nmt 
group by type

--as percentage
SELECT
    type,
    COUNT(*) AS count,
    round(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_movies_tvshows),2 ) AS percentage_total
FROM
    netflix_movies_tvshows nmt 
group by type

--2. Country
--Most overall on netflix
select country, count(*) as count
from netflix_movies_tvshows nmt 
where country <> ''
group by country 
order by count desc

--Most TV shows on netflix
select country, count(*) as count
from netflix_movies_tvshows nmt 
where type= 'TV Show' and country <> '' 
group by country
order by count desc

--Most Movie on netflix
select country, count(*) as count
from netflix_movies_tvshows nmt 
where type = 'Movie' and country <> ''
group by country
order by count desc

--Separated by Type
select country,type, count(*) as count
from netflix_movies_tvshows nmt 
where country <> ''
group by country, type
order by count desc

--3. The number of movies and tv shows added on netflix each year
--Overall
select EXTRACT(year from date_added) as year, count(*) as count
from netflix_movies_tvshows nmt 
where date_added is not null 
group by year
order by year 

--Movies and TV shows separated
select EXTRACT(year from date_added) as year,type, count(*) as count
from netflix_movies_tvshows nmt 
where date_added is not null 
group by year,type
order by year

--4. Average duration of movies in netflix
select round(avg(cast(left(duration, length(duration) -3 ) as integer)),2) as avg_minutes
from netflix_movies_tvshows nmt 
where duration like '%min%'

--for distribution
select duration, cast(left(duration, length(duration) -3 ) as integer) as minutes
from netflix_movies_tvshows nmt 
where duration like '%min%'

--5. Average season of tv shows in netflix
select 
	round(avg(cast(case 
		when duration like '%Season' then left(duration, length(duration) - 6)
		when duration like '%Seasons' then left(duration, length(duration) - 7)
	end as integer)),2) as avg_seasons
from netflix_movies_tvshows nmt 
where duration like '%Season%'

--for distribution
select 
	duration,
	cast(case 
		when duration like '%Season' then left(duration, length(duration) - 6)
		when duration like '%Seasons' then left(duration, length(duration) - 7)
	end as integer) as seasons
from netflix_movies_tvshows nmt 
where duration like '%Season%'

--6. Top Genres in netflix
select listed_in, count(*) as count
from netflix n 
group by listed_in 
order by count desc