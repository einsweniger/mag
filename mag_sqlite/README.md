# MAG DB in sqlite3 

copy all files in this folder to the gz compressed files and execute `bash sqlite-import.sh`

the resulting database is about 160 GiB without and about 215 GiB with an index.
Indexing will complete faster without foreign keys/database index, but access will be sped up considerably. 

