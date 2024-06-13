#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
#year,round,winner,opponent,winner_goals,opponent_goals
echo $($PSQL "TRUNCATE TABLE games, teams")
cat games.csv | while IFS=",", read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  #echo 'Here are the variables:' $YEAR $ROUND $WINNER  $OPPONENT $WINNER_GOALS $OPPONENT_GOALS
  # Get the winner id
  if [[ $WINNER != "winner" ]]
  then
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    echo 'WINNER ID' $WINNER_ID
  if [[ -z $WINNER_ID ]]
  then
    INSERT_WINNER=$($PSQL "INSERT INTO teams(name)VALUES('$WINNER')")
    echo "INSERT RESULT" $INSERT_WINNER
  if [[ $INSERT_WINNER == "INSERT 0 1" ]]
  then 
    echo Inserted into team, $WINNER
  fi
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  fi
  fi
  #Get the opponent id
  if [[ $OPPONENT != "opponent" ]]
  then
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    echo 'opponent ID' $OPPONENT_ID
  if [[ -z $OPPONENT_ID ]]
  then
    INSERT_OPPONENT=$($PSQL "INSERT INTO teams(name)VALUES('$OPPONENT')")
  if [[ $INSERT_OPPONENT == "INSERT 0 1" ]]
  then 
    echo Inserted into team, $OPPONENT
  fi
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
  fi
  fi
  #Insert the data into the tables
  if [[ $YEAR != 'year' ]]
  then
    INSERTED_GAME=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
     if [[ $INSERTED_GAME == "INSERT 0 1" ]]
      then
      echo "INSERTED INTO GAMES" $ROUND $WINNER $OPPONENT
  fi
  fi

done