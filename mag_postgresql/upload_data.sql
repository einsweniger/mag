/*
uploading datasets 
-- first unzip 
gunzip -k PaperAuthorAffiliations.txt.gz
gunzip -k PaperReferences.txt.gz

*/


-- we test the tables which gave errors before 

\copy mag.paper_author_affiliations from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/PaperAuthorAffiliations_1.txt	 with delimiter E'\t' encoding 'UTF8' NULL AS '';

\copy mag.papers                    from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/Papers_2.txt   with delimiter E'\t' encoding 'UTF8' NULL AS '';



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

eris=# \copy mag.paper_author_affiliations from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/PaperAuthorAffiliations.txt with delimiter E'\t' encoding 'UTF8' NULL AS '';
ERROR:  literal newline found in data
HINT:  Use "\n" to represent newline.
CONTEXT:  COPY paper_author_affiliations, line 137238
Time: 251410,906 ms (04:11,411)
eris=# 

/*
-- try to fix it by removing non utf-8 signs 
iconv -f utf-8 -t utf-8 -c PaperUrls.txt > PaperUrls_x.txt
\copy mag.paper_urls        from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/PaperUrls_x.txt         with delimiter E'\t' encoding 'UTF8' NULL AS '';

STILL DOES NOT WORK 
ERROR:  invalid byte sequence for encoding "UTF8": 0xbb
CONTEXT:  COPY paper_urls, line 7870043: "120161762	3	https://www.awwa.org\\pers75apppcr\Personify\ServerFiles\DCDFiles\27395\jaw_waternet.007..."
Time: 78517,427 ms (01:18,517)


--another attempt 
sed -e 's/\\0//g' PaperUrls.txt > PaperUrls_x.txt
-- does not work 


*/






-- mag.papers
-- several errors mainly linked to titles 


-- one solution could be to split the files in parts to localize and fix the problems
-- https://linoxide.com/linux-how-to/split-large-text-file-smaller-files-linux/


[1] unzip file 
gunzip -k Papers.txt.gz

[2] fix backlash escape 
sed -e 's/\\/\\\\/g' Papers.txt > Papers_1.txt

[3] split file in chunks with lines 
split -d -l 10000000 Papers_1.txt  xPapers


\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers00  with delimiter E'\t' encoding 'UTF8' NULL AS '';
\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers01  with delimiter E'\t' encoding 'UTF8' NULL AS '';

\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers02  with delimiter E'\t' encoding 'UTF8' NULL AS '';
\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers03  with delimiter E'\t' encoding 'UTF8' NULL AS '';

\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers04  with delimiter E'\t' encoding 'UTF8' NULL AS '';
\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers05  with delimiter E'\t' encoding 'UTF8' NULL AS '';

\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers06  with delimiter E'\t' encoding 'UTF8' NULL AS '';
\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers07  with delimiter E'\t' encoding 'UTF8' NULL AS '';

\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers08  with delimiter E'\t' encoding 'UTF8' NULL AS '';
\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers09  with delimiter E'\t' encoding 'UTF8' NULL AS '';

\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers10  with delimiter E'\t' encoding 'UTF8' NULL AS '';
\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers11  with delimiter E'\t' encoding 'UTF8' NULL AS '';
 
\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers12  with delimiter E'\t' encoding 'UTF8' NULL AS '';
\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers13  with delimiter E'\t' encoding 'UTF8' NULL AS '';
  
\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers14  with delimiter E'\t' encoding 'UTF8' NULL AS '';
\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers15  with delimiter E'\t' encoding 'UTF8' NULL AS '';


\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers16  with delimiter E'\t' encoding 'UTF8' NULL AS '';
\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers17  with delimiter E'\t' encoding 'UTF8' NULL AS '';


\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers18  with delimiter E'\t' encoding 'UTF8' NULL AS '';
\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers19  with delimiter E'\t' encoding 'UTF8' NULL AS '';


\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers20  with delimiter E'\t' encoding 'UTF8' NULL AS '';
\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers21  with delimiter E'\t' encoding 'UTF8' NULL AS '';

select count(paper_id) from mag.papers;
-- 110.000.000




--try remove non utf characters 
--https://stackoverflow.com/questions/30312361/

iconv -f utf-8 -t utf-8 -c xPapers00 > xPapers00x

iconv -f utf-8 -t UTF-8 -c < xPapers01 > xPapers01x




\copy mag.papers  from /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/xPapers01x  with delimiter E'\t' encoding 'UTF8' NULL AS '';

-- DOES NOT WORK BECAUSE the replacement characters seems to be a valid utf-8 characters 


----- ERRORS 
--errors in several files, seems to be linked to the replacement symbol 

CONTEXT:  COPY papers, line 7733807: "2241562762	21644	10.18607/ES31772014�2473635951	24753		Patent	controller for opening and closing m..."
CONTEXT:  COPY papers, line 4921563: "1744521669	24957	10.18607/ES16062014�2563707391	26813			review franco moretti signs taken for wond..."
CONTEXT:  COPY papers, line 1912081: "1588223716	24957	10.18607/ES16022014�2059255114	19962	10.1016/j.drugpo.2014.05.003	Journal	disrupt..."
CONTEXT:  COPY papers, line 2263613: "2117836654	23985	10.18607/ES16072014�2050986127	20712	10.1590/S0100-40422002000300017	Journal	sele..."
CONTEXT:  COPY papers, line 2802674: "1937356293	24615	10.18607/ES20662014�2061025617	24421	10.1016/0022-3468(70)90008-4	Journal	vascula..."
CONTEXT:  COPY papers, line 3169886: "1519121811	24493	10.18607/ES16012014�2784901510	25468	10.1594/pangaea.723932		basic measurements o..."
CONTEXT:  COPY papers, line 2675090: "1926311984	24848	10.18607/ES25502014�2047907261	19992	10.1590/S0102-311X2004000300005	Journal	rela..."
CONTEXT:  COPY papers, line 9667351: "2165279575	24523	10.18607/ES19152014�173653697	25060			pola perilaku pencarian informasi mahasiswa..."
CONTEXT:  COPY papers, line 5214771: "1606591211	24957	10.18607/ES19942014�2347740281	23561			place of hunting tourism in the structure ..."
CONTEXT:  COPY papers, line 6175375: "1569010064	24445	10.18607/ES25532014�2113002504	19927	10.5194/gmd-6-469-2013	Journal	port a cesm t..."
CONTEXT:  COPY papers, line 2412187: "1543575333	24537	10.18607/ES16082014�2889017687	24484			tasa de captura y composicion de tamanos d..."


-- TRYING WITH line endings ? 
-- DOES NOT WORK either 
--sed -i.bak 's/\r$//' xPapers00

--try another dumps 
iconv -f utf-8 -t UTF-8 -c < xPapers.txt > xPapers_1.txt

\copy mag.papers_x  from /home/mike/Downloads/__MAG_DATASET/__additional_myaccout/xPapers_1.txt  with delimiter E'\t' encoding 'UTF8' NULL AS '';


