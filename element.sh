#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

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
    echo  "I could not find that element in the database."
  else
  ## Create an array
   ${element_array[@]}
   ## unwrap the output
    IFS='|' read -r -a element_array <<<"$ELEMENT"
    echo  "The element with atomic number ${element_array[0]} is ${element_array[2]} (${element_array[1]}). It's a ${element_array[3]}, with a mass of ${element_array[4]} amu. ${element_array[2]} has a melting point of ${element_array[5]} celsius and a boiling point of ${element_array[6]} celsius."

  fi

}
else
  echo  "Please provide an element as an argument."
fi

