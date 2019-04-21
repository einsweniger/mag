
/*

-- we use sqlite 3.26.0 (coming with anaconda) 
but for the pre-processing, might be better to use the latest version 
3.28 which has better windows functions 

installed in /opt/sqlite328/sqlite3
verify 
/opt/sqlite328/sqlite3 --version


*/

--sqlite3 /home/mike/__DtaInfrastructure/__MAG/_mag_sqlite/mag.db
sqlite3 /media/mike/x_ssd/mag/mag.db

.timer on

drop table if exists conference_series;
drop table if exists conference_instances;
drop table if exists affiliations;
drop table if exists journals;
drop table if exists paper_resources;
drop table if exists fields_of_study;
drop table if exists authors;
drop table if exists paper_urls;
drop table if exists paper_references;
drop table if exists paper_author_affiliations;
drop table if exists papers;



CREATE TABLE  conference_series
(
conference_series_id integer,
x_rank integer,
normalized_name text, 
display_name    text,
paper_count  integer, 
citation_count integer,
create_date text
)
;

CREATE TABLE conference_instances
(
conference_instance_id  integer,
normalized_name text,
display_name text,
conference_series_id integer,
x_location text,
official_url text,
start_date text,
end_date text,
abstract_registration_date text,
submission_deadline_date text,
notification_due_date text,
final_version_due_date text,
paper_count integer,
citation_count integer,
create_date text
)
;


CREATE TABLE affiliations
(
affiliation_id integer,
x_rank integer,
normalized_name text,
display_name text,
gr_id_id text,
official_page text,
wiki_page text,
paper_countCount integer,
citation_count integer,
created_date text
)
;


CREATE TABLE journals
(
journal_id integer,
x_rank integer,
normalized_name text,
display_name text,
issn text,
publisher text,
webpage text,
paper_count integer,
citation_count integer,
created_date text
 );
 

CREATE TABLE paper_resources
(
paper_id integer,
resource_type int,
resource_url text,
source_url text,
relationship_type integer
)
;


CREATE TABLE fields_of_study
(
field_of_study_id integer,
x_rank integer,
normalized_name text,
display_name text,
main_type text,
x_level int,
paper_count integer,
citation_count integer,
created_date text
)
;

    
CREATE TABLE authors
(
author_id integer,
x_rank integer,
normalized_name text,
display_name text,
last_known_affiliation_id integer,
paper_count integer,
citation_count integer,
created_date text
)
;
  
 
CREATE TABLE paper_urls
(
paper_id integer,
source_type integer,
source_url text
)
;


CREATE TABLE paper_references
(
paper_id integer,
paper_reference_id integer
);
  


CREATE TABLE paper_author_affiliations
(
paper_id integer,
author_id integer,
affiliation_id integer,
author_sequence_number integer,
original_author text, 
original_affiliation text
)
;



-- problems with field type, we default to text for testing 
create table papers
(
paper_id  integer,
x_rank    integer,
doi        text, 
doc_type       text,
paper_title    text,
original_title text,
book_title text,
pub_year   text,
pub_date   text,
publisher  text,
journal_id             text,
conference_series_id   text,
conference_instance_id text,
volume text, 
issue  text,
first_page text,
last_page  text,
reference_count text,
citation_count text,
estimated_citation text,
original_venue  text,
created_date text
)
;


