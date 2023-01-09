/* Script description: create table for each attribute, plus the policy id (idPolita) */

/* A Attributes from CLIENTS */

/* TABLE CLIENTS CONTAINS DUPLICATES IN THE FORM OF THE SAME POLICY HAVING ONE 'INSURED' CLIENT AND 
A SECOND 'USER' CLIENT, AS ONLY ONE IS NEEDED, THE 'INSURED' ONE WILL BE DROPPED */

/* needed to make group by work */
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

create temporary table temp
as
select * 
from clienti
	where tipClient = "UTILIZATOR";
  
/* Creates table for each attribute */
create table att1_type
	as select
		idPolita, tip
		from temp;

create table att2_age
	as select
		idPolita, varsta
		from temp;

create table att3_judet
	as select
		idPolita, judet
		from temp;
        
create table att4_localitate
	as select
		idPolita, localitate
		from temp;

create table att5_sex
	as select
		idPolita, sex
		from temp;
/* **************************************** */ 

/* B Attributes from OBJECTS */
create index idx_polita on obiecte(idPolita);

create table att6_category_type
	as select
		idPolita, categorie, tipVehicul
		from obiecte;

create table att7_make
	as select
		idPolita, marca, model
		from obiecte;

create table att8_capacity
	as select
		idPolita, capacitate
		from obiecte;
        
create table att9_power
	as select
		idPolita, putere
		from obiecte;

create table att10_seats
	as select
		idPolita, locuri
		from obiecte;
        
create table att11_year
	as select
		idPolita, anFabricatie
		from obiecte;
        
create table att12_weight
	as select
		idPolita, masaTehnica
		from obiecte;
/* **************************************** */

/* C Attributes from POLICIES */
alter table polite_rca
	rename column id to idPolita;
create index idx_polita on polite_rca(idPolita);

create table att13_bonus_malus
	as select
		idPolita, clasaBM
		from polite_rca;

create table att14_no_rates
	as select
		idPolita, nrRate
		from polite_rca;
/* **************************************** */

/* D Attributes from CLAIMS */
/* These won't be treated separately, as such I will only drop the unnecessary one and transfer
the table to Python */

alter table daune
	drop column oraEveniment, 
    drop column locEveniment, 
    drop column daunaTotala, 
    drop column regres;