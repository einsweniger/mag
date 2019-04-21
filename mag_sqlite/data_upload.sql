/*
Uploading datasets 

- some tables have problems notably of unescaped " character
we try to fix it first 

*/


--- FIX DATASETS 
cd /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/

-- tables with problems 
--[1] FieldsOfStudy
sed 's/"/""/g;s/[^\t]*/"&"/g' FieldsOfStudy.txt > FieldsOfStudy_1.txt
--[2] Authors 
sed 's/"/""/g;s/[^\t]*/"&"/g' Authors.txt > Authors_1.txt
--[3] Papers 
---- first fix the unescaped backlash 
sed -e 's/\\/\\\\/g' Papers.txt > Papers_1.txt
---- the the unescaped quore 
sed -e 's/\\/\\\\/g' Papers.txt > Papers_1.txt
sed 's/"/""/g;s/[^\t]*/"&"/g' Papers_1.txt > Papers_2.txt

--[4] paper_author_affiliations 
sed 's/"/""/g;s/[^\t]*/"&"/g' PaperAuthorAffiliations.txt > PaperAuthorAffiliations_1.txt


--- IMPORT 



---- IMPORT DATASETS 
on sqlite>

.mode tabs
.import /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/ConferenceSeries.txt 	   conference_series    
.import /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/ConferenceInstances.txt	   conference_instances 
.import /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/Affiliations.txt     	   affiliations        
.import /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/Journals.txt         	   journals   
.import /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/PaperResources.txt     	   paper_resources    
.import /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/FieldsOfStudy_1.txt     	   fields_of_study    
.import /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/Authors_1.txt         	   authors       
.import /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/PaperUrls.txt         	   paper_urls  
.import /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/PaperReferences.txt 	   paper_references 
.import /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/Papers_2.txt               papers
.import /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/PaperAuthorAffiliations_1.txt paper_author_affiliations 

SELECT date('now');



--results : 173,1 GB 
