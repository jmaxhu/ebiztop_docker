#!/bin/bash
# this scripts is for export school test data sql

HOST=localhost
DB=ebiztop
DB_USER=homestead
DB_PWD=secret

read -p "School Id: " school_id

echo  -e "\nbegin dump school test data, Id: $school_id ...."

filename="school_$school_id.sql"
touch $filename

# dump table partial rows
mysqldump -h $HOST -u $DB_USER -p$DB_PWD $DB schools --where="id=$school_id" > "${filename}"
mysqldump -h $HOST -u $DB_USER -p$DB_PWD $DB school_tests --where="school_id=$school_id" >> "${filename}"
mysqldump -h $HOST -u $DB_USER -p$DB_PWD --skip-lock-tables $DB tests --where="id in (select test_id from school_tests where school_id=$school_id)" >> "${filename}"
mysqldump -h $HOST -u $DB_USER -p$DB_PWD --skip-lock-tables $DB test_evaluations --where="school_id=0" >> "${filename}"
mysqldump -h $HOST -u $DB_USER -p$DB_PWD --skip-lock-tables $DB product_attr_catalogs --where="test_id in (select test_id from school_tests where school_id=$school_id)" >> "${filename}"
mysqldump -h $HOST -u $DB_USER -p$DB_PWD --skip-lock-tables $DB product_attr_values --where="test_id in (select test_id from school_tests where school_id=$school_id)" >> "${filename}"
mysqldump -h $HOST -u $DB_USER -p$DB_PWD --skip-lock-tables $DB product_spec_catalogs --where="test_id in (select test_id from school_tests where school_id=$school_id)" >> "${filename}"
mysqldump -h $HOST -u $DB_USER -p$DB_PWD --skip-lock-tables $DB product_spec_values --where="test_id in (select test_id from school_tests where school_id=$school_id)" >> "${filename}"

mysqldump -h $HOST -u $DB_USER -p$DB_PWD --skip-lock-tables $DB test_cases --where="school_id = 0 and type = 0 and test_id in (select test_id from school_tests where school_id=$school_id)" >> "${filename}"
mysqldump -h $HOST -u $DB_USER -p$DB_PWD --skip-lock-tables $DB test_case_attrs --where="test_case_id in (select id from test_cases where (school_id = 0 and type = 0 and test_id in (select test_id from school_tests where school_id=$school_id)))" >> "${filename}"
mysqldump -h $HOST -u $DB_USER -p$DB_PWD --skip-lock-tables $DB test_case_specs --where="test_case_id in (select id from test_cases where (school_id = 0 and type = 0 and test_id in (select test_id from school_tests where school_id=$school_id)))" >> "${filename}"
mysqldump -h $HOST -u $DB_USER -p$DB_PWD --skip-lock-tables $DB test_case_pics --where="test_case_id in (select id from test_cases where (school_id = 0 and type = 0 and test_id in (select test_id from school_tests where school_id=$school_id)))" >> "${filename}"
mysqldump -h $HOST -u $DB_USER -p$DB_PWD --skip-lock-tables $DB test_case_spec_prices --where="test_case_id in (select id from test_cases where (school_id = 0 and type = 0 and test_id in (select test_id from school_tests where school_id=$school_id)))" >> "${filename}"

echo -e "\nfinshed"

exit 0

