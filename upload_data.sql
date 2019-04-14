/*
uploading datasets 
-- first unzip 
gunzip -k PaperAuthorAffiliations.txt.gz
gunzip -k PaperReferences.txt.gz

*/




--\copy mag.conference_series	   from	/home/mike/Downloads/__MAG_DATASET/_frm_zenodo/ConferenceSeries.txt	 with delimiter E'\t' encoding 'UTF8' NULL AS '';
--\copy mag.conference_instances from	/home/mike/Downloads/__MAG_DATASET/_frm_zenodo/ConferenceInstances.txt with delimiter E'\t' encoding 'UTF8' NULL AS '';
--\copy mag.affiliations	       from	/home/mike/Downloads/__MAG_DATASET/_frm_zenodo/Affiliations.txt	     with delimiter E'\t' encoding 'UTF8' NULL AS '';
--\copy mag.journals	           from	/home/mike/Downloads/__MAG_DATASET/_frm_zenodo/Journals.txt	         with delimiter E'\t' encoding 'UTF8' NULL AS '';
--\copy mag.paper_resources	   from	/home/mike/Downloads/__MAG_DATASET/_frm_zenodo/PaperResources.txt	     with delimiter E'\t' encoding 'UTF8' NULL AS '';
--\copy mag.fields_of_study	   from	/home/mike/Downloads/__MAG_DATASET/_frm_zenodo/FieldsOfStudy.txt	     with delimiter E'\t' encoding 'UTF8' NULL AS '';
--\copy mag.authors	           from	/home/mike/Downloads/__MAG_DATASET/_frm_zenodo/Authors.txt	         with delimiter E'\t' encoding 'UTF8' NULL AS '';
-- ERROR  \copy mag.paper_urls	       from	/home/mike/Downloads/__MAG_DATASET/_frm_zenodo/PaperUrls.txt	         with delimiter E'\t' encoding 'UTF8' NULL AS '';
--\copy mag.paper_references	   from	/home/mike/Downloads/__MAG_DATASET/_frm_zenodo/PaperReferences.txt	 with delimiter E'\t' encoding 'UTF8' NULL AS '';
-- ERROR \copy mag.paper_author_affiliations	from	/home/mike/Downloads/__MAG_DATASET/_frm_zenodo/PaperAuthorAffiliations.txt	 with delimiter E'\t' encoding 'UTF8' NULL AS '';
-- THIS DOES NOT WORK 
\copy mag.papers	                from	/home/mike/Downloads/__MAG_DATASET/_frm_zenodo/Papers.txt	                     with delimiter E'\t' encoding 'UTF8';


--- LOGS 
mag.conference_series    :         4.374 rows, Time: 47,220 ms
mag.conference_instances :        15.894 rows, Time: 46,712 ms
mag.affiliations         :        25.496 rows, Time: 80,543 ms
mag.journals             :        48.711 rows, Time: 97,470 ms
mag.paper_resources      :        65.797 rows, Time: 120,288 ms
mag.fields_of_study      :       663.508 rows, Time: 1038,646 ms (00:01,039)
mag.authors              :   256.683.554 rows, Time: 422679,304 ms (07:02,679)
mag.paper_references     : 1.419.880.598 rows, Time: 759675,776 ms (12:39,676)




--ERROS: 
-- mag.paper_urls
\copy mag.paper_urls        from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/PaperUrls.txt         with delimiter E'\t' encoding 'UTF8' NULL AS '';
ERROR:  invalid byte sequence for encoding "UTF8": 0xbb
CONTEXT:  COPY paper_urls, line 7870043: "120161762	3	https://www.awwa.org\\pers75apppcr\Personify\ServerFiles\DCDFiles\27395\jaw_waternet.007..."
Time: 84753,183 ms (01:24,753)

-- mag.paper_author_affiliations
\copy mag.paper_author_affiliations from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/PaperAuthorAffiliations.txt with delimiter E'\t' encoding 'UTF8' NULL AS '';
ERROR:  extra data after last expected column
CONTEXT:  COPY paper_author_affiliations, line 1: "9	2632942543		1Victoriano Perruca Albadalejo	"
Time: 133155,940 ms (02:13,156)

/*
-- THERE SEEMS TO BE A CHANGE IN THE TABLE DEFINITION 
-- the one I use seems not to match the data

CREATE TABLE mag.paper_author_affiliations
(
paper_id bigint,
author_id bigint,
affiliation_id bigint,
author_sequence_number int, 
original_affiliation text
)
;
--
*/

-- mag.papers

(1) “missing data for column "created_date"” 
--  backlash not properly escaped in record 140649167. I could fix this with
sed -e 's/\\/\\\\/g' Papers.txt > Papers_1.txt

(2) “ extra data after last expected column” 
was caused by encodings as it is due to a replacement sign in 
one record “7733807: "2241562762 21644 10.18607/ES31772014�2473635951”
 I tried to force utf-8 but it did not work.


 



