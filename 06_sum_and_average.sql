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