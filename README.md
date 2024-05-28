# Netflix Movies and TV Shows
 
# Introduction
This project contains the analysis of the Netflix Movies and TV Shows dataset from Kaggle. The dataset includes information about various movies and TV shows available on Netflix, including their genres, ratings, release dates, and more. The analysis aims to uncover insights and trends in the Netflix catalog. In addition, this project is to increase my comfortability with SQL, Tableau, and Microsoft Excel


# Dataset
The dataset used for this analysis can be found here: 
[Netflix Movies and TV Shows](https://www.kaggle.com/datasets/rahulvyasm/netflix-movies-and-tv-shows)

It contains the following columns:

1. ***show_id***: Unique ID for each show
2. ***type***: Type of the show (Movie or TV Show)
3. ***title***: Title of the show
4. ***director***: Director of the show
5. ***cast***: Main cast of the show
6. ***country***: Country where the show was produced
7. ***date_added***: Date when the show was added to Netflix
8. ***release_year***: Release year of the show
9. ***rating***: Rating of the show
10. ***duration***: Duration of the show (minutes for movies, number of seasons for TV shows)
11. ***listed_in***: Genre of the show
12. ***description***: Brief description of the show

# Tools I Used
1. ***SQL***
2. ***PostgreSQL***
3. ***Tableau***
4. ***Microsoft Excel***
5. ***Visual Studio Code***

# Data Cleaning
All data cleaning queries can be found on:
[Data Cleaning](/sql%20scripts/Data%20Cleaning.sql)

The steps I took to clean the dataset is:

1. Removed the "s" from show_id column and turned the column into integer datatype.
```sql
update netflix_movies_tvshows  set show_id = cast(substring(show_id from 2) as integer);

alter table netflix_movies_tvshows alter column show_id type integer using show_id::integer;
```

2. Removed extra columns at the end of the dataset 
```sql
alter table netflix_movies_tvshows 
drop column column13,
drop column column14,
drop column column15,
drop column column16,
drop column column17,
drop column column18,
drop column column19,
drop column column20,
drop column column21,
drop column column22,
drop column column23,
drop column column24,
drop column column25,
drop column column26;
```

3. Turned the date_added column into date datatype
```sql
update netflix_movies_tvshows  set date_added = null where date_added = '';

alter table netflix_movies_tvshows  alter column date_added type date using date_added::date;
```


# Analysis
All data analysis queries can be found on:
[Netflix Data Analysis](/sql%20scripts/Netflix%20Data%20Analysis.sql)

Question I wanted to answer:
 * What is percentage of TV Shows vs Movies 
 * Which countries have the most films produced on Netflix?
		Which countries have the most TV shows produced on Netflix?
		Which countries have the most products on Netflix?

 *  How many movies and tv shows are added on netflix each year?
 * What is the typical duration of movies in netflix?
 * What is the average number of seasons of the tv shows in netflix?
 * What are the top genres in netflix?

### 1. What is the percentage of TV Shows vs Movies?

```sql
select type, count(*) as count
from netflix_movies_tvshows nmt 
group by type
```

This showed that 2677, or about 30.39%, of products in Netflix are TV shows, while 6132 products, or about 69.61%, are movies.

### 2. Which countries have the most products on Netflix?
```sql
select country,type, count(*) as count
from netflix_movies_tvshows nmt 
where country <> ''
group by country, type
order by count desc
```

The top producer of movies and TV shows is United States. India is 2nd most on movies produced, but they are lacking in the TV show production. United Kingdom is 2nd on TV shows and also ranks high on movies.


### 3. How many movies and tv shows are added on Netflix each year?
```sql
select EXTRACT(year from date_added) as year,type, count(*) as count
from netflix_movies_tvshows nmt 
where date_added is not null 
group by year,type
order by year
```

The number of movies and tv shows sharply increased from 2015 to 2019, but decreased rapidly from 2020 to 2024. This might be because of the pandemic and other factors closely related to it. 

### 4. What is the typical duration of movies on Netflix?
```sql
select round(avg(cast(left(duration, length(duration) -3 ) as integer)),2) as avg_minutes
from netflix_movies_tvshows nmt 
where duration like '%min%'
```

The typical duration of movies is around 100 minutes, with the highest number of movies being 90 minutes long.

### 5. What is the average number of seasons of the TV shows on Netflix?
```sql
select duration, cast(left(duration, length(duration) -3 ) as integer) as minutes
from netflix_movies_tvshows nmt 
where duration like '%min%'
```

The average number of seasons is 1.76 seasons, with the most number of TV shows being 1 season.

### 6. What are the top genres on Netflix?
```sql
select listed_in, count(*) as count
from netflix n 
group by listed_in 
order by count desc
```

The top genre is Dramas, International Movies. Second place and following closely from 1st place is Documentaries. The third most popular genre is Stand-up Comedy.

# Data Visualization
It is easier to understand data visualized than just pure numbers, so I put all my findings into a Tableau dashboard. This is a simple dashboard using bar charts, line graphs, and pie chart.

![Tableau Dashboard Image](/images/netflix%20tableau%20dashboard.png)
*Data Visualization of Netflix Movies and TV Shows data*

This is the link to the [Tableau Data Visualization](https://public.tableau.com/views/NetflixDashboard_17167795961720/Dashboard1?:language=en-US&publish=yes&:sid=&:display_count=n&:origin=viz_share_link)

# Microsoft Excel
I also used Excel as an extra way to understand the data. I made pivot tables to answer the same questions as above and used pivot chart to visualize the analysis.

The Microsoft Excel Sheet can be found here: [Excel Sheet](/Excel/netflix_movies_tvshows.xlsx)
