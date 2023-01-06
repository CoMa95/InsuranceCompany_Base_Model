/* Script description: create table with number of events for each policy id per each year, plus total */

/* needed to make group by work */
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

/* General table with all events (VAT and MAT) per policy id */
create table no_events
	as select
		idPolita, count(distinct dataEveniment) as total_ev,
        case when year(dataEveniment) = 2015 then count(distinct dataEveniment) else 0 end as ev_2015,
        case when year(dataEveniment) = 2016 then count(distinct dataEveniment) else 0 end as ev_2016,
        case when year(dataEveniment) = 2017 then count(distinct dataEveniment) else 0 end as ev_2017,
        case when year(dataEveniment) = 2018 then count(distinct dataEveniment) else 0 end as ev_2018,
        case when year(dataEveniment) = 2019 then count(distinct dataEveniment) else 0 end as ev_2019,
        case when year(dataEveniment) = 2020 then count(distinct dataEveniment) else 0 end as ev_2020,
        case when year(dataEveniment) = 2021 then count(distinct dataEveniment) else 0 end as ev_2021
	from daune group by idPolita;

