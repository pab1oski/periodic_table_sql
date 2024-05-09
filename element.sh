#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

echo -e "Please provide an element as an argument."

if[[ $1 ]]
then
{
  ## Do a query
  ELEMENT=$($PSQL "SELECT atomic_number,symbol,name,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INENR JOIN typer USING(type_id) WHERE atomic_number = '$1' OR symbol = '$1' OR name = '$1' ")
}

