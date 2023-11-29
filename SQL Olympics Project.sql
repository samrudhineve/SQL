-- Importing large data more than lakhs of rows
use ravet;
-- 1. Create the table athletes
create table athletes(
	Id int,
    Name varchar(200),
    Sex char(1),
    Age int,
    Height float,
    Weight float,
    Team varchar(200),
    NOC char(3),
    Games varchar(200),
    Year int,
    Season varchar(200),
    City varchar(200),
    Sport varchar(200),
    Event varchar(200),
    Medal Varchar(50));

-- View the blank Athletes table
select * from athletes;

-- Location to add the csv
SHOW VARIABLES LIKE "secure_file_priv";

-- Load the data from csv file after saving to above location
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Athletes_Cleaned.csv'
into table athletes
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

-- View the table
select * from athletes;

/* SQL Olympics Project */

-- Q1. Show how many medal counts present for entire data.
select medal, count(medal) from athletes
group by medal;

-- Q2. Show count of unique Sports are present in olympics.
select count(distinct sport)
as unique_sports 
from athletes;

-- Q3. Show how many different medals won by Team India in data.
select count(medal) 
as diff_medals_by_India 
from athletes
where team = 'india' and medal != 'NoMedal';

select Medal, team, count(Medal)
as diff_medals_by_India 
from athletes
where team = 'india' and medal != 'NoMedal'
group by Medal;

-- Q4. Show event wise medals won by india show from highest to lowest medals won in order.
select event, count(medal) as medal_count from athletes
where team = 'india' and medal != 'NoMedal'
group by event
order by medal_count desc;

-- Q5. Show event and yearwise medals won by india in order of year.
select event, count(medal) as medal_count, year from athletes
where team = 'india' and medal != 'NoMedal'
group by event, year
order by year;

-- Q6. Show the country with maximum medals won gold, silver, bronze
select team, count(Medal) as medal_count from athletes
where medal != 'nomedal'
group by team
order by medal_count desc
limit 1;

-- Q7. Show the top 10 countries with respect to gold medals
select team, count(Medal) as gold_medal_count from athletes
where medal = 'gold'
group by team
order by count(medal) desc
limit 10;

-- Q8. Show in which year did United States won most medals
select team, year, count(Medal) from athletes
where medal != 'nomedal' and team = 'united states'
group by year
order by count(medal) desc
limit 1;

-- Q9. In which sports United States has most medals
select team, sport, count(medal) as medal_count from athletes
where team = 'united states' and medal!='nomedal'
group by sport 
order by medal_count desc
limit 1;

-- Q10. Find top 3 players who have won most medals along with their sports and country.
select name, team, sport, count(medal) as medal_count from athletes
where medal != 'nomedal'
group by name, sport, team
order by medal_count desc
limit 3;

-- Q11. Find player with most gold medals in cycling along with his country.
select name, team, sport, count(medal) as gold_medal_count from athletes
where Medal='gold' and Sport= 'cycling'
group by name, team, sport
order by gold_medal_count desc
limit 1;

-- Q12. Find player with most medals (Gold + Silver + Bronze) in Basketball also show his country.
select name, team, sport, count(medal) as medal_count
from athletes
where Medal != 'nomedal' and sport = 'basketball'
group by name, team, sport
order by medal_count desc
limit 1;

-- Q13. Find out the count of different medals of the top basketball player.
select name, sport, medal, count(medal) as medal_count
from athletes
where Medal != 'nomedal' and name = 'Teresa Edwards'
group by medal,name, sport;

-- Q14. Find out medals won by male, female each year.
select year, sex, count(medal) as medal_count
from athletes
where medal != 'nomedal'
group by year, sex
order by year;