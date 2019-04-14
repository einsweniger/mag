/*
create postgresql tables 
in ascending order of size 

--428103	ConferenceSeries.txt
--2224843	ConferenceInstances.txt
--4564007	Affiliations.txt
--5689662	Journals.txt
--7763592	PaperResources.txt
--55188690	FieldsOfStudy.txt
--16528778635	Authors.txt
-- 23096534376	PaperUrls.txt
--32446006785	PaperReferences.txt
-40976541540	PaperAuthorAffiliations.txt
60213784152	Papers.txt

--some modifications : maybe this can be optimized 
long => bigint 
text => text
text => text 
*/

drop table if exists mag.conference_series;
drop table if exists mag.conference_instances;
drop table if exists mag.affiliations;
drop table if exists mag.journals;
drop table if exists mag.paper_resources;
drop table if exists mag.fields_of_study;
drop table if exists mag.authors;
drop table if exists mag.paper_urls;
drop table if exists mag.paper_references;
drop table if exists mag.paper_author_affiliations;
drop table if exists mag.papers;


\copy mag.papers from /home/mike/Downloads/__MAG_DATASET/__additional_myaccout/xPapers_1.txt with delimiter E'\t' encoding 'UTF8';



CREATE TABLE  mag.conference_series
(
conference_series__id bigint,
x_rank bigint,
normalized_name text, 
display_name    text,
paper_count  bigint, 
citation_count bigint,
create_date text
)
;

CREATE TABLE mag.conference_instances
(
conference_instance__id  bigint,
normalized_name text,
display_name text,
conference_series__id bigint,
x_location text,
official_url text,
start_date text,
end_date text,
abstract_registration_date text,
submission_deadline_date text,
notification_due_date text,
final_version_due_date text,
paper_count bigint,
citation_count bigint,
create_date text
)
;


CREATE TABLE mag.affiliations
(
affiliation__id bigint,
x_rank bigint,
normalized_name text,
display_name text,
gr_id__id text,
official_page text,
wiki_page text,
paper_countCount bigint,
citation_count bigint,
created_date text
)
;


CREATE TABLE mag.journals
(
journal__id bigint,
x_rank bigint,
normalized_name text,
display_name text,
issn text,
publisher text,
webpage text,
paper_count bigint,
citation_count bigint,
created_date text
 );
 

CREATE TABLE mag.paper_resources
(
paper__id bigint,
resource_type int,
resource_url text,
source_url text,
relationship_type int
)
;


CREATE TABLE mag.fields_of_study
(
field_of_study__id bigint,
x_rank bigint,
normalized_name text,
display_name text,
main_type text,
x_level int,
paper_count bigint,
citation_count bigint,
created_date text
)
;

    
CREATE TABLE mag.authors
(
author__id bigint,
x_rank bigint,
normalized_name text,
display_name text,
last_known_affiliation_id bigint,
paper_count bigint,
citation_count bigint,
created_date text
)
;
  
 
CREATE TABLE mag.paper_urls
(
paper_id bigint,
source_type int,
source_url text
)
;


CREATE TABLE mag.paper_references
(
paper_id bigint,
paper_reference_id bigint
);
  


CREATE TABLE mag.paper_author_affiliations
(
paper_id bigint,
author_id bigint,
affiliation_id bigint,
author_sequence_number int, 
original_affiliation text
)
;


-- problems with field type, we default to text for testing 
create table mag.papers
(
paper_id  bigint,
x_rank    bigint,
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



