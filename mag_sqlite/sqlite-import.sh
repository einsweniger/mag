DBFILE=mag.sqlite3
sqlite3 $DBFILE < sqlite-create-tables.sql
# import in the order stated in the table creation process to satisfy depencies
for i in $(sed -n 's|create table \(.*\)|\1|p' < sqlite-create-tables.sql) 
do 
	echo ${i} 
	# cat gzip -> replace \r\n with \n -> sqlite import from stdin as ascii
	zcat ${i}.txt.gz | sed 's/\r$//' | sqlite3 $DBFILE -init sqlite-ascii-import-init ".import /dev/stdin ${i}" 
done
