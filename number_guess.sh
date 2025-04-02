#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -q -c"

guess_number() {
  RUN=1
  COUNT=1
  SECRET_NUMBER=$(( $RANDOM % 1000 + 1 ))
  echo "Guess the secret number between 1 and 1000:"
  while [[ $RUN -eq 1 ]]
  do
    read NUMBER
    
    if [[ $NUMBER =~ ^[0-9]+$ ]]
    then
      # if NUMBER is int number
      if [[ $NUMBER -gt $SECRET_NUMBER ]]
      then
        echo "It's lower than that, guess again:"
      elif [[ $NUMBER -lt $SECRET_NUMBER ]]
      then
        echo "It's higher than that, guess again:"
      else
        $PSQL "INSERT INTO games(user_id,guesses) VALUES('$USER_ID',$COUNT)"
        echo "You guessed it in $COUNT tries. The secret number was $SECRET_NUMBER. Nice job!"
        RUN=0
      fi
      COUNT=$(( $COUNT + 1 ))
    else
      # if NUMBER is not int number
      echo "That is not an integer, guess again:"
    fi
  done
}

echo "Enter your username:"
read USERNAME

USER_ID="$($PSQL "SELECT user_id FROM users WHERE name='$USERNAME'")"

if [[ -z $USER_ID ]]
then
  # if it is first game of user
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  $PSQL "INSERT INTO users(name) VALUES('$USERNAME')"
  USER_ID="$($PSQL "SELECT user_id FROM users WHERE name='$USERNAME'")"
  guess_number
else
  # if user already played
  GAMES_PLAYED="$($PSQL "SELECT COUNT(*) FROM games WHERE user_id = $USER_ID")"
  BEST_GAME="$($PSQL "SELECT MIN(guesses) FROM games WHERE user_id = $USER_ID")"
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  guess_number
fi
