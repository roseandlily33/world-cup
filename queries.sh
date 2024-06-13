#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

#Correct 68
echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

#Correct 90
echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"

#Correct 2.1250000000000000
echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

#Correct 2.13
echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games")"

#Correct 2.8125000000000000
echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games")"

#Correct 7
echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games")"

#Correct 6
echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2 ")"

#Correct France
echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT name FROM teams LEFT JOIN games ON teams.team_id = games.winner_id WHERE year=2018 ORDER BY winner_goals DESC LIMIT 1 ")"

#Correct Algeria Argentina Belgium Brazil Chile Colombia Costa Rica France Germany Greece Mexico Netherlands Nigeria Switzerland United States Uruguay
echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT name FROM teams LEFT JOIN games ON teams.team_id = games.winner_id OR teams.team_id = games.opponent_id WHERE year=2014 AND round='Eighth-Final' ORDER BY name")"

#Correct 
echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT(name) FROM teams RIGHT JOIN games ON teams.team_id = games.winner_id ORDER BY name  ")"

#Correct 2014 | Germany && 2018 | France
echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT DISTINCT(year), name FROM games LEFT JOIN teams ON games.winner_id = teams.team_id WHERE round='Final'")"

#Correct Colombia && Costa Rica
echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%'")"
