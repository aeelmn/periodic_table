#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"


#If you run ./element.sh, it should output only Please provide an element as an argument. and finish running.

  if [[ -z $1 ]]
  then
echo -e "Please provide an element as an argument."

else 
ARGUMENT=$1

#check if integer
if [[ $ARGUMENT =~ ^[0-9]+$ ]]
then


RESULT=$($PSQL "select atomic_number, symbol, name from elements where atomic_number = '$ARGUMENT';")

if [[ -z $RESULT ]]
then
echo -e "I could not find that element in the database."
else
#echo -e "atomic number result"
echo "$RESULT" | while IFS="|" read -r atomic_number symbol name

#DATA=$($PSQL "select type, weight, melting_point, boiling_point from properties where atomic_number = $atomic_number;")
#echo "$DATA" | while IFS="|" read -r type weight melting_point boiling_point
      do
      atomic_number=$(echo "$atomic_number" | sed 's/^ *//;s/ *$//')
      symbol=$(echo "$symbol" | sed 's/^ *//;s/ *$//')
      name=$(echo "$name" | sed 's/^ *//;s/ *$//')
      DATA=$($PSQL "select type, atomic_mass, melting_point_celsius, boiling_point_celsius from properties where atomic_number = $atomic_number;")
      
echo "$DATA" | while IFS="|" read -r type atomic_mass melting_point_celsius boiling_point_celsius
do
type=$(echo "$type" | sed 's/^ *//;s/ *$//')
          atomic_mass=$(echo "$atomic_mass" | sed 's/^ *//;s/ *$//')
          melting_point_celsius=$(echo "$melting_point_celsius" | sed 's/^ *//;s/ *$//')
          boiling_point_celsius=$(echo "$boiling_point_celsius" | sed 's/^ *//;s/ *$//')
        echo "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point_celsius celsius and a boiling point of $boiling_point_celsius celsius."
      done
      done
fi

else
RESULT=$($PSQL "select atomic_number, symbol, name from elements where symbol = '$ARGUMENT' OR name = '$ARGUMENT';")
if [[ -z $RESULT ]]
then
echo -e "I could not find that element in the database."
else
#echo -e "symbol or name result"

echo "$RESULT" | while IFS="|" read -r atomic_number symbol name
       do
      atomic_number=$(echo "$atomic_number" | sed 's/^ *//;s/ *$//')
      symbol=$(echo "$symbol" | sed 's/^ *//;s/ *$//')
      name=$(echo "$name" | sed 's/^ *//;s/ *$//')
     # DATA=$($PSQL "select type, weight, melting_point, boiling_point from properties where atomic_number = $atomic_number;")
      
DATA=$($PSQL "select type, atomic_mass, melting_point_celsius, boiling_point_celsius from properties where atomic_number = $atomic_number;")
      
echo "$DATA" | while IFS="|" read -r type atomic_mass melting_point_celsius boiling_point_celsius
do
type=$(echo "$type" | sed 's/^ *//;s/ *$//')
          atomic_mass=$(echo "$atomic_mass" | sed 's/^ *//;s/ *$//')
          melting_point_celsius=$(echo "$melting_point_celsius" | sed 's/^ *//;s/ *$//')
          boiling_point_celsius=$(echo "$boiling_point_celsius" | sed 's/^ *//;s/ *$//')
        echo "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point_celsius celsius and a boiling point of $boiling_point_celsius celsius."
      done
      done

fi

fi

fi
  
