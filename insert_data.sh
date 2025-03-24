#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# ================= Insert teams =================
cat "games.csv" | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    
    EXIST_TEAM_WINNER_ANS="$($PSQL "SELECT name FROM teams WHERE name = '$WINNER'")"
    EXIST_TEAM_OPPONENT_ANS="$($PSQL "SELECT name FROM teams WHERE name = '$OPPONENT'")"

    if [[ -z "$EXIST_TEAM_WINNER_ANS" ]]
    then
      echo "$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")"
    fi

    if [[ -z "$EXIST_TEAM_OPPONENT_ANS" ]]
    then
      echo "$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")"
    fi

  fi
done

# ================= Insert games =================
cat "games.csv" | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    
    WINNER_ID="$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")"
    OPPONENT_ID="$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")"

    echo "$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")"

  fi
done