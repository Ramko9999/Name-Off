
If you would like to build the schema in your own instance of PostgreSQL, you can use the below command to run .sql files.

psql -h hostname -d database_name -U user_name -p 5432 -a -q -f filepath

Example:

psql -U postgres -d name_off_db -h localhost  -p 5432 -f FILENAME

Disclaimer: 

Be sure to replace the hostname, database_name, user_name and port with the details of YOUR OWN instance. The above is simply an example.

Setup:

run the schema.sql and game_user.sql with postgres