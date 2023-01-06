/* Script description: create table with policy id (idPolita), start and end dates, maturity and yearly exposure */

create table id_dates_exposures
	as select
		id, dataStart, dataEnd
		from polite_rca;

alter table id_dates_exposures
rename column id to idPolita;

create index idx_polita on id_dates_exposures(idPolita);
    
/* add Maturity */
alter table id_dates_exposures
	add column maturity INT default NULL;
update id_dates_exposures
	set
		maturity = round((datediff (dataEnd, dataStart))/30.5);
        
/* add Exposures */
alter table id_dates_exposures
add column exp_2015 decimal(5, 4),
add column exp_2016 decimal(5, 4),
add column exp_2017 decimal(5, 4),
add column exp_2018 decimal(5, 4),
add column exp_2019 decimal(5, 4),
add column exp_2020 decimal(5, 4),
add column exp_2021 decimal(5, 4),
add column exp_2022 decimal(5, 4);

update id_dates_exposures
   set  
		exp_2015 = case 
				when year(dataStart) = 2015 then
					case 
						when year(dataStart) = year(dataEnd) then 
							datediff(dataEnd, dataStart)/365
						else 
							datediff(str_to_date("2015-12-31", '%Y-%m-%d'), dataStart)/365
					end
				else 
					0 
                end,
		exp_2016 = case 
				when year(dataStart) = 2016 then
					case 
						when year(dataStart) = year(dataEnd) then 
							datediff(dataEnd, dataStart)/365
						else 
							datediff(str_to_date("2016-12-31", '%Y-%m-%d'), dataStart)/365
					end
				else 
					0 
                end,
		exp_2017 = case 
				when year(dataStart) = 2017 then
					case 
						when year(dataStart) = year(dataEnd) then 
							datediff(dataEnd, dataStart)/365
						else 
							datediff(str_to_date("2017-12-31", '%Y-%m-%d'), dataStart)/365
					end
				else 
					0 
                end,
		exp_2018 = case 
				when year(dataStart) = 2018 then
					case 
						when year(dataStart) = year(dataEnd) then 
							datediff(dataEnd, dataStart)/365
						else 
							datediff(str_to_date("2018-12-31", '%Y-%m-%d'), dataStart)/365
					end
				else 
					0 
                end,
		exp_2019 = case 
				when year(dataStart) = 2019 then
					case 
						when year(dataStart) = year(dataEnd) then 
							datediff(dataEnd, dataStart)/365
						else 
							datediff(str_to_date("2019-12-31", '%Y-%m-%d'), dataStart)/365
					end
				else 
					0 
                end,
		exp_2020 = case 
				when year(dataStart) = 2020 then
					case 
						when year(dataStart) = year(dataEnd) then 
							datediff(dataEnd, dataStart)/365
						else 
							datediff(str_to_date("2020-12-31", '%Y-%m-%d'), dataStart)/365
					end
				else 
					0 
                end,
		exp_2021 = case 
				when year(dataStart) = 2021 then
					case 
						when year(dataStart) = year(dataEnd) then 
							datediff(dataEnd, dataStart)/365
						else 
							datediff(str_to_date("2021-12-31", '%Y-%m-%d'), dataStart)/365
					end
				else 
					0 
                end,
		exp_2022 = case 
				when year(dataStart) = 2022 then
					case 
						when year(dataStart) = year(dataEnd) then 
							datediff(dataEnd, dataStart)/365
						else 
							datediff(str_to_date("2022-12-31", '%Y-%m-%d'), dataStart)/365
					end
				else 
					0 
                end;
                
update id_dates_exposures
   set  
		exp_2016 = case when (year(dataStart) = 2015 and year(dataEnd) = 2016) then datediff(dataEnd, str_to_date("2016-01-01", '%Y-%m-%d'))/365 else exp_2016 end,
        exp_2017 = case when (year(dataStart) = 2016 and year(dataEnd) = 2017) then datediff(dataEnd, str_to_date("2017-01-01", '%Y-%m-%d'))/365 else exp_2017 end,
        exp_2018 = case when (year(dataStart) = 2017 and year(dataEnd) = 2018) then datediff(dataEnd, str_to_date("2018-01-01", '%Y-%m-%d'))/365 else exp_2018 end,
        exp_2019 = case when (year(dataStart) = 2018 and year(dataEnd) = 2019) then datediff(dataEnd, str_to_date("2019-01-01", '%Y-%m-%d'))/365 else exp_2019 end,
        exp_2020 = case when (year(dataStart) = 2019 and year(dataEnd) = 2020) then datediff(dataEnd, str_to_date("2020-01-01", '%Y-%m-%d'))/365 else exp_2020 end,
        exp_2021 = case when (year(dataStart) = 2020 and year(dataEnd) = 2021) then datediff(dataEnd, str_to_date("2021-01-01", '%Y-%m-%d'))/365 else exp_2021 end,
        exp_2022 = case when (year(dataStart) = 2021 and year(dataEnd) = 2022) then datediff(dataEnd, str_to_date("2022-01-01", '%Y-%m-%d'))/365 else exp_2022 end;	
