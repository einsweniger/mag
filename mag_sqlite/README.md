# MAG DB in sqlite3 

some tables have problems notably of unescaped " character we try to fix it first . 
This would have as consequence that the fields will be text (even if defined as integer or float) 





cd /home/mike/Downloads/__MAG_DATASET/_frm_zenodo/

**[1] FieldsOfStudy**

sed 's/"/""/g;s/[^\t]*/"&"/g' FieldsOfStudy.txt > FieldsOfStudy_1.txt

**[2] Authors **
sed 's/"/""/g;s/[^\t]*/"&"/g' Authors.txt > Authors_1.txt

**[3] Papers **

- first fix the unescaped backlash 
sed -e 's/\\/\\\\/g' Papers.txt > Papers_1.txt

- the the unescaped quore 

sed 's/"/""/g;s/[^\t]*/"&"/g' Papers_1.txt > Papers_2.txt

**[4] paper_author_affiliations ** 

sed 's/"/""/g;s/[^\t]*/"&"/g' PaperAuthorAffiliations.txt > PaperAuthorAffiliations_1.txt


the resulting database is *173,1 GB* big without any index 

