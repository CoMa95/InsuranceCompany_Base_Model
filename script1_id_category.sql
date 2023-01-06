/* Script description: create a table with only the policy id (idPolita) and the car category */

create table id_categ
	as select
		idPolita, categorie
		from obiecte;
        
alter table id_categ
	add primary key (idPolita);