/* Script description: add a column, idEvent, to the claims table (daune)*/

/* needed to make group by work */
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

/* first, convert non-MAT and non-VAT claims into MAT claims */
update daune
	set 
		tipEveniment = "Pagube materiale"
	where tipEveniment <> "Pagube materiale" and tipEveniment <> "Vatamari corporale/deces, inclusive pentru prejudi";

/* Create the idEvent column and add values - idPolita + dataEveniment should create unique ids for each
event, thus providing the same event id for multiple claims (idDosar), where possible */
alter table daune
	add column idEvent varchar(30);
update daune
	set idEvent = concat(idPolita, dataEveniment);
        
