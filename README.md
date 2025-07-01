# IPL Data Analysis using SQL

This repository contains a comprehensive SQL project for analyzing Indian Premier League (IPL) match and ball-by-ball data. The project utilizes MySQL to set up the database, load data from CSV files, and perform various queries to extract insights into team performance, player statistics, and match outcomes across different IPL seasons.

## Project Goal & Objectives

The primary goal of this project is to provide a robust SQL-based framework for IPL data analysis. Specific objectives include:

* Setting up a relational database schema for IPL matches and deliveries data.
* Loading large CSV datasets efficiently into MySQL tables.
* Performing various aggregations and analytical queries to understand:
    * Overall match statistics (total matches, matches per season/venue).
    * Team performance (total wins, runs scored, economy rates).
    * Player performance (top run-scorers, wicket-takers, fours/sixes).
    * Impact of toss decisions on match outcomes.

## Technologies Used

* **Database:** MySQL
* **Client:** MySQL Workbench (or any MySQL client)
* **Version Control:** Git / GitHub

## Data Source

This project uses two primary datasets, typically found as CSV files:

1.  `matches.csv`: Contains high-level information about each IPL match (season, winner, venue, toss decision, etc.).
2.  `deliveries.csv`: Contains ball-by-ball data for all matches, including runs scored, wickets, bowler, batter, etc.

*(Note: Ensure `matches.csv` and `deliveries.csv` are placed in the specified path `D:/SQL/` or update the `LOAD DATA INFILE` paths in the script accordingly.)*

## Setup & Execution

Follow these steps to set up the database and run the analysis queries on your local machine:

1.  **Install MySQL:** Ensure you have MySQL Server installed and running.
2.  **Install MySQL Workbench:** Or your preferred MySQL client.
3.  **Enable `LOCAL INFILE`:**
    * Open your MySQL client (e.g., MySQL Workbench).
    * Execute the following command to allow local file loading (required for `LOAD DATA LOCAL INFILE`):
        ```sql
        SET GLOBAL local_infile = 1;
        ```
    * You might need to restart your MySQL server for this change to take full effect, or re-establish your connection in Workbench.
4.  **Place CSV Files:**
    * Download `matches.csv` and `deliveries.csv`.
    * Place them in the `D:/SQL/` directory on your system. If you use a different path, remember to update the paths in the `LOAD DATA LOCAL INFILE` commands within the SQL script.
5.  **Execute the SQL Script:**
    * Open the `ipl_analysis.sql` file (provided in this repository) in MySQL Workbench.
    * Run the entire script. It will perform the following actions:
        * Create the `ipl_analysis` database.
        * Use the `ipl_analysis` database.
        * Drop `matches` and `deliveries` tables if they already exist (for clean setup).
        * Create the `matches` table with defined schema.
        * Create the `deliveries` table with defined schema, including a composite primary key and foreign key relationship to `matches`.
        * Load data from `matches.csv` into the `matches` table.
        * Load data from `deliveries.csv` into the `deliveries` table.
        * Execute a series of analytical queries.

## Key Analysis & Queries

The `ipl_analysis.sql` script includes various SQL queries designed to extract valuable insights from the IPL data. Some of the key analyses performed are:

* **Total Matches:** Counting the total number of matches played.
* **Matches Per Season/Venue:** Analyzing the distribution of matches across seasons and venues.
* **Team Performance (Wins):** Identifying teams with the most wins.
* **Toss Decisions Analysis:** Understanding toss decisions and their correlation with match outcomes.
* **Total Runs/Wickets Per Match:** Aggregating match-level statistics from ball-by-ball data.
* **Top Run Scorers:** Identifying leading batsmen by total runs.
* **Player Boundary Count:** Calculating the number of fours and sixes hit by players.
* **Team Batting Performance:** Analyzing runs scored per inning and average runs per over for teams.

##  Insights (Examples)

By running the queries, you can uncover insights such as:

* Which seasons had the most matches?
* Which venues hosted the most IPL games?
* Do teams prefer to bat or field after winning the toss?
* Does winning the toss significantly increase the chances of winning the match?
* Who are the highest-scoring batsmen in IPL history?
* Which team maintains the best scoring rate per over?

##  Future Enhancements

* **Player Wicket-Taking Stats:** Add queries for top wicket-takers and bowling averages/economy rates.
* **Partnership Analysis:** Analyze batting partnerships.
* **Venue-Specific Performance:** Dive deeper into how teams and players perform at specific venues.
* **Year-wise Player Stats:** Track player performance across different seasons.
* **Integration with Visualization Tools:** Use Python (Pandas, Matplotlib/Seaborn) or a BI tool (Tableau, Power BI) to create interactive dashboards based on these SQL queries.
