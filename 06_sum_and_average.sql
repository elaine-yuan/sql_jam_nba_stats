-- ============================================================
--SUM AND AVERAGE
-- ============================================================

--https://sqljam.dev/?skin=nba&challenge=nba26-agg-2026-scoring-summary
--Difficulty: Easy
--Challenge: Summarise scoring in the 2026 season in a single row: the total of all `points` as `total_points`, the average `points_per_game` rounded to 2 decimals as `avg_ppg`, and the highest single value of `points` as `most_points`.
--My Solution:
SELECT SUM(points) AS total_points, ROUND(AVG(points_per_game),2) AS avg_ppg, MAX(points) AS most_points
FROM player_seasons
WHERE season=2026;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-agg-2026-regulars
--Difficulty: Medium
--Challenge: Summarise the 2026 regulars in a single row: for players with at least 50 `games` that season, return how many there are as `players` and their average `points_per_game` rounded to 2 decimals as `avg_ppg`.
--My Solution:
SELECT COUNT(DISTINCT player) AS players, ROUND(AVG(points_per_game),2) AS avg_ppg
FROM player_seasons
WHERE season=2026 AND games>=50;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-agg-franchise-playoff-rate
--Difficulty: Hard
--Challenge: For every franchise with at least 40 completed seasons, return the `team_name`, how many seasons it has as `seasons`, and how many of those ended in the playoffs as `playoff_seasons`. Exclude the 2026 season, whose playoff field isn't final yet.
--My Solution:
SELECT team_name, COUNT(DISTINCT season) AS seasons, SUM(CASE WHEN made_playoffs=TRUE THEN 1 ELSE 0 END) AS playoff_seasons
FROM teams
WHERE season <> 2026
GROUP BY team_name
HAVING seasons>=40;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-agg-shooting-by-position
--Difficulty: Hard
--Challenge: Whose shots go in most often in 2026? Work it out from the TOTALS, not by averaging players. Return `position` and `fg_pct` — SUM of `fg_made` times 100 divided by SUM of `fg_attempted`, rounded to 1 decimal — for positions that attempted at least 3000 shots. Order by `fg_pct` descending.
--My Solution:
SELECT position, ROUND(SUM(fg_made) * 100.0 / SUM(fg_attempted), 1) AS fg_pct 
FROM player_seasons 
WHERE season=2026
GROUP BY position
HAVING SUM(fg_attempted) >= 3000
ORDER BY fg_pct DESC;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-agg-season-census
--Difficulty: Hard
--Challenge: Summarise every season from 2020 onward. Return `season`, the number of different players as `players`, the number of different teams as `teams`, and the average points per game as `avg_ppg` rounded to 1 decimal. One row per season, oldest first.
--My Solution:
SELECT season, COUNT(DISTINCT player) AS players, COUNT(DISTINCT team) AS teams, ROUND(AVG(points_per_game),1) AS avg_ppg
FROM player_seasons
WHERE season>=2020
GROUP BY season
ORDER BY season ASC;