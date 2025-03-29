#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -t -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"

MAIN_MENU() {
  # error massage
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  # available service
  echo "$($PSQL "SELECT service_id, name FROM services")" | while read SERVICE_ID BAR SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done

  # select service
  read SERVICE_ID_SELECTED
  SELECTED_SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")

  if [[ -z $SELECTED_SERVICE_NAME ]]
  then
    # if service is not available
    MAIN_MENU "I could not find that service. What would you like today?"
  else
    # if service is available
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    SELECTED_PHONE=$($PSQL "SELECT phone FROM customers WHERE phone='$CUSTOMER_PHONE'")

    if [[ -z $SELECTED_PHONE ]]
    then
      # if customer is not in DB
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME

      # add customer to DB
      SEND_DATA_TO_CUSTOMERS=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
      # get customer ID
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name='$CUSTOMER_NAME'")
    else
      # if customer is in DB
      IFS='|' read -r CUSTOMER_ID CUSTOMER_NAME < <($PSQL "SELECT customer_id, name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    fi

    echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"
    read SERVICE_TIME

    echo -e "\nI have put you down for a $SELECTED_SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME." | sed 's/  */ /g'

    # add appointment to DB
    SEND_DATA_TO_APPOINTMENTS=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
  fi
}

MAIN_MENU