SELECT * FROM census.dataset1;
SELECT * FROM census.dataset2;

-- number of rows in our dataset
select count(*) from census.dataset1;
select count(*) from census.dataset2;

-- dataset for bihar and jharkhand
select * from census.dataset1
where state in ('jharkhand','Bihar');

-- avg growth 
select avg(growth)*100  avg_growth from census.dataset1;

-- avg sex ratio
select state,round(avg(sex_ratio),0) from census.dataset1
group by state
order by round(avg(sex_ratio),0) desc;

-- state having avg literacy rate gretaer than 90
select state,round(avg(literacy),0) from census.dataset1
group by state  having round(avg(literacy),0)>90
order by round(avg(literacy),0) desc;

-- Top 3 states showing highest growth ratio
select state,round(avg(growth)*100,0)  avg_growth from census.dataset1
group by state
order by avg_growth desc limit 3;

-- top and bottom 3 states in literacy state
create table census.topstates
( state varchar(255),
  state_rate float
  );
  insert into census.topstates (state, state_rate)
  select state,round(avg(literacy),0) avg_literacy_ratio from census.dataset1
  group by state order by avg_literacy_ratio desc;
  select * from census.topstates
  order by state_rate  desc
  
  create table census.bottomstates
( state varchar(255),
  state_rate float
  );
  insert into census.bottomstates (state, state_rate)
  select state,round(avg(literacy),0) avg_literacy_ratio from census.dataset1
  group by state order by avg_literacy_ratio desc;
  
  select * from(
  select * from census.topstates 
  order by state_rate desc limit 3) a
  union 
  select * from(
   select * from census.bottomstates 
  order by state_rate asc limit 3) b;
  
  
  -- state name starting with letter a
  select distinct(state) from census.dataset1 
  where lower(State) like 'a%';
  
   -- state name starting with letter a or b
  select distinct(state) from census.dataset1 
  where lower(State) like 'a%' or lower(state) like 'b%';
  
 --  joining both tables
 select a.district,a.state,a.sex_ratio,b.population from census.dataset1 a
 inner join census.dataset2 b
 on a.district=b.district;
 
 
 -- uttarpradesh top 10 district with max population
SELECT district
FROM census.dataset2
WHERE state = 'Uttar Pradesh'
ORDER BY population DESC
LIMIT 10;


-- Retrieve the names of all districts in Maharashtra along with their 
-- respective populations 
select District,population from census.dataset2
where State='maharashtra';

-- perform join give all the information about district nagpur in maharashtra

SELECT a.*, b.Area_km2, b.Population
FROM census.dataset1 a
JOIN census.dataset2 b ON a.District = b.District
WHERE a.State = 'Maharashtra' AND a.District LIKE 'nagpur%';


-- window function 
-- top 3 district with highest literacy rate
select a.* from
(select district,state,literacy,rank() over(partition by state order by literacy desc) rnk
from census.dataset1) a
where a.rnk in(1,2,3)
order by state asc


 
 