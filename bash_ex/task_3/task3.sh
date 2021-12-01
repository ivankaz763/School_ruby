#/bin/bash
echo $VARIABLE_TMP2
echo $LOGNAME
echo $TEST
echo $TEST2

file_name="$1"
while read line; do export "$line";
done < "$file_name"

echo "________new env________"
echo $VARIABLE_TMP2
echo $LOGNAME
echo $TEST
echo $TEST2