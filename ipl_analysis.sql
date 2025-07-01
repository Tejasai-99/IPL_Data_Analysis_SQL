SET GLOBAL local_infile = 1;

CREATE DATABASE ipl_analysis;
USE ipl_analysis;
DROP TABLE IF EXISTS matches;

CREATE TABLE matches (
    id INT PRIMARY KEY,
    season INT,
    city VARCHAR(50),
    date DATE,
    match_type VARCHAR(50),   
    venue VARCHAR(100),
    player_of_match VARCHAR(100),
    team1 VARCHAR(50),
    team2 VARCHAR(50),
    toss_winner VARCHAR(50),  
    toss_decision VARCHAR(10),
    winner VARCHAR(50),
    result VARCHAR(20),
    result_margin INT,         
    target_runs INT,  
    target_overs INT, 
    super_over VARCHAR(5), 
    method VARCHAR(10),
    umpire1 VARCHAR(50),
    umpire2 VARCHAR(50)
    );
SELECT COUNT(*) FROM matches;
SELECT * FROM matches ;




DROP TABLE IF EXISTS deliveries;

CREATE TABLE deliveries (
    match_id INT,           
    inning INT,
    batting_team VARCHAR(50),  
    bowling_team VARCHAR(50),  
    over_number INT,   
    ball_number INT,
    batter VARCHAR(100),
    bowler VARCHAR(100),
    non_striker VARCHAR(100),
    extra_runs INT,
    runs_extras INT,               
    runs_total INT,              
    extra_type VARCHAR(20),       
    is_wicket TINYINT(1),        
    player_dismissed VARCHAR(100),   
    dismissal_kind VARCHAR(50),  
    fielder VARCHAR(100),
	PRIMARY KEY (match_id, inning, over_number, ball_number),
    FOREIGN KEY (match_id) REFERENCES matches(id)
    );
    
select * from deliveries;

SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE 'D:/SQL/matches.csv'
INTO TABLE matches
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'D:/SQL/deliveries.csv'
INTO TABLE deliveries
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

#Qureies

#TOTAL MATCHES
SELECT COUNT(*) AS total_matches
FROM matches;

#Matches Per Season:
SELECT season, COUNT(*) AS matches_played
FROM matches
GROUP BY season
ORDER BY season;

#Matches Per Venue/City
SELECT venue, COUNT(*) AS matches_hosted
FROM matches
GROUP BY venue
ORDER BY matches_hosted DESC;

#Team Performance (Basic - Total Wins)
SELECT winner, COUNT(*) AS total_wins
FROM matches
WHERE winner IS NOT NULL
GROUP BY winner
ORDER BY total_wins DESC;

#Toss Decisions
SELECT toss_decision, COUNT(*) AS decision_count
FROM matches
GROUP BY toss_decision;

#the percentage of 'bat' vs 'field' decisions
SELECT
    toss_decision,
    COUNT(*) AS decision_count,
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM matches WHERE toss_decision IS NOT NULL)) AS percentage
FROM matches
WHERE toss_decision IS NOT NULL
GROUP BY toss_decision;


SELECT
    CASE
        WHEN toss_decision = 'bat' AND winner = toss_winner THEN 'Toss Win & Bat & Match Win'
        WHEN toss_decision = 'field' AND winner = toss_winner THEN 'Toss Win & Field & Match Win'
        ELSE 'Other'
    END AS outcome_category,
    COUNT(*) AS num_matches
FROM matches
WHERE winner IS NOT NULL AND toss_winner IS NOT NULL AND result != 'no result'
GROUP BY outcome_category;


SELECT target_runs FROM matches
ORDER BY target_runs DESC;

SELECT COUNT(distinct team) FROM ( SELECT team1 as team from matches union SELECT team2 as team from matches) AS all_teams;


#Total runs scored in each match
SELECT m.season, m.id AS match_id, m.team1, m.team2, sum(d.runs_total) AS total_runs_match
FROM matches m
JOIN deliveries d ON m.id = d.match_id
GROUP BY m.season, m.id, m.team1, m.team2
ORDER BY m.id;

#Total wickets taken in each match
SELECT m.season, m.id AS match_id, m.team1, m.team2, SUM(d.is_wicket) AS total_wickets_match
FROM matches m
JOIN deliveries d ON m.id = d.match_id
GROUP BY m.season, m.id, m.team1, m.team2
ORDER BY m.id;
    
#Top 10 Run Scorers
SELECT batter, SUM(runs_total - extra_runs) AS total_runs_scored 
FROM deliveries
GROUP BY batter
ORDER BY total_runs_scored DESC
LIMIT 10;

#Team runs per inning
SELECT match_id, inning, batting_team, SUM(runs_total) AS total_runs_inning
FROM deliveries
WHERE match_id = (SELECT id FROM matches LIMIT 1) 
GROUP BY match_id, inning, batting_team
ORDER BY inning;

#Most Fours and Sixes by a Player
SELECT batter,
SUM(CASE WHEN runs_total = 4 THEN 1 ELSE 0 END) AS total_fours,
SUM(CASE WHEN runs_total = 6 THEN 1 ELSE 0 END) AS total_sixes
FROM deliveries
GROUP BY batter
ORDER BY total_sixes DESC, total_fours DESC
LIMIT 10;

#Average runs scored per over by a team
SELECT batting_team, ROUND(SUM(runs_total) / COUNT(DISTINCT match_id, inning, over_number), 2) AS avg_runs_per_over
FROM deliveries
GROUP BY batting_team
ORDER BY avg_runs_per_over DESC;