-- ============================================================
--NAME A STEP WITH
-- ============================================================

--https://sqljam.dev/?skin=nba&challenge=nba26-cte-2026-twenty-point-scorers
--Difficulty: Medium
--Challenge: Using a CTE (a `WITH` block), gather the 2026 player-seasons averaging at least 20 `points_per_game`, then return the `player` and `points_per_game` of those above the average *of that group*.
--My Solution:
WITH that_group AS
  (SELECT player, points_per_game
  FROM player_seasons
  WHERE season=2026 AND points_per_game>=20)
SELECT *
FROM that_group
GROUP BY player, points_per_game
HAVING points_per_game>(SELECT AVG(points_per_game) FROM that_group);

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-cte-team-scoring-vs-league
--Difficulty: Hard
--Challenge: For the 2026 season, compare each team's scoring to the league. Show `team_name`, `points_per_game`, and how far above or below the league average it is as `diff_from_avg`, rounded to 1 decimal place.
--My Solution:
WITH league AS 
  (SELECT avg(points_per_game) AS avg_points
  FROM teams 
  WHERE season = 2026)
SELECT team_name, points_per_game, round(points_per_game-league.avg_points,1) AS diff_from_avg
FROM teams t, league
WHERE season=2026;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-cte-above-league-scoring
--Difficulty: Hard
--Challenge: Which teams outscored their own league year by the most? Build a CTE of each season's average team scoring from 2020 onward, a second CTE that joins it back to `teams` and keeps the teams above their season's average, then return `season`, `team_name` and `above_avg` — the gap, rounded to 1 decimal. Order by `above_avg` descending, top 10. Ties broken by `team_name` A-Z.
--My Solution:
WITH season_avg AS 
  (SELECT season, AVG(points_per_game) AS lg_ppg 
  FROM teams 
  WHERE season>=2020
  GROUP BY season)
,above_avg AS 
  (SELECT t.season, t.team_name, t.points_per_game, s.lg_ppg 
  FROM teams t JOIN season_avg s ON t.season = s.season
  WHERE t.points_per_game>s.lg_ppg)
SELECT season, team_name, ROUND(points_per_game-lg_ppg, 1) AS above_avg 
FROM above_avg
ORDER BY above_avg DESC, team_name
LIMIT 10;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-cte-share-of-team-scoring
--Difficulty: Hard
--Challenge: How much of their team's offence did each player carry in 2026? Build a CTE of every team's total `points`, join it back to the players, and return `player`, `team` and `pct_of_team` — the player's points as a percentage of the team total, rounded to 1 decimal. Only players who scored at least 1000 points, and only players with a single `team` — a player traded mid-season has no team of their own to be a share of. Order by `pct_of_team` descending. Ties broken by `player` A-Z.
--My Solution:
WITH total_points AS    
  (SELECT team, SUM(points) AS total
  FROM player_seasons
  WHERE season=2026
  GROUP BY team)
SELECT ps.player, ps.team, ROUND((points/total)*100,1) AS pct_of_team
FROM total_points tp JOIN player_seasons ps ON tp.team=ps.team
WHERE points>=1000 AND season=2026
GROUP BY ps.player, ps.team, points, total
HAVING COUNT(ps.team)=1
ORDER BY pct_of_team DESC, player;