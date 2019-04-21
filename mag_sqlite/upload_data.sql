/*
Uploading datasets 



*/



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
