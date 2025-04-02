#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
  exit 0
else

  # if $1 is number
  if [[ $1 =~ [0-9]+ ]]
  then
    REQUEST=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements e JOIN properties p ON e.atomic_number = p.atomic_number JOIN types t ON p.type_id = t.type_id WHERE e.atomic_number = $1;")

    # if element not in db
    if [[ -z $REQUEST ]]
    then
      echo I could not find that element in the database.
    else
      echo "$REQUEST" | while IFS="|" read NUMBER SYMBOL NAME MASS MELT BOIL TYPE
      do
        echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      done
    fi
  
  # if $1 is symbol
  elif [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]
  then
    REQ_SYMBOL=$(echo "$1" | sed -E 's/^(.)(.)?/\U\1\L\2/')
    REQUEST=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements e JOIN properties p ON e.atomic_number = p.atomic_number JOIN types t ON p.type_id = t.type_id WHERE e.symbol = '$REQ_SYMBOL';")

    # if element not in db
    if [[ -z $REQUEST ]]
    then
      echo I could not find that element in the database.
    else
      echo "$REQUEST" | while IFS="|" read NUMBER SYMBOL NAME MASS MELT BOIL TYPE
      do
        echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      done
    fi

  # else $1 is name
  else
    
    REQ_NAME=$(echo "$1" | sed -E 's/^(.)(.+)?/\U\1\L\2/')
    REQUEST=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements e JOIN properties p ON e.atomic_number = p.atomic_number JOIN types t ON p.type_id = t.type_id WHERE e.name = '$REQ_NAME';")

    # if element not in db
    if [[ -z $REQUEST ]]
    then
      echo I could not find that element in the database.
    else
      echo "$REQUEST" | while IFS="|" read NUMBER SYMBOL NAME MASS MELT BOIL TYPE
      do
        echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      done
    fi

  fi
fi
