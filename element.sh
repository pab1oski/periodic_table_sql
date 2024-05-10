#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

echo -e "Please provide an element as an argument."

if [[ $1 ]]
then
{
  ## Check if it is number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ## Do a query for string
  ELEMENT=$($PSQL "SELECT atomic_number,symbol,name,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1 ")
  else
  ## Do a query for string
  ELEMENT=$($PSQL "SELECT atomic_number,symbol,name,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$1' OR name = '$1' ")
  
  fi

  ## Check if the element exixts
  if [[ -z $ELEMENT ]]
  then
    echo "\nI could not find that element in the database."
  else

  ## unwrap the output

  echo "$ELEMENT" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR TYPE BAR ATOMIC_MASS BAR MELTING BAR BOILING
  do
    echo "\nThe element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  done

  fi

}
else
  echo -e "Please provide an element as an argument."
fi

