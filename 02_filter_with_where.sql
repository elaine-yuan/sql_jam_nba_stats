-- ============================================================
--FILTER WITH WHERE
-- ============================================================

--https://sqljam.dev/?skin=nba&challenge=nba26-where-2000-point-seasons
--Challenge: Find every season in which a player scored more than 2000 total `points`. Show `season`, `player` and `points`.
--Difficulty: Easy
--My Solution:
SELECT season, player, points
FROM player_seasons
WHERE points>2000;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-where-2026-workhorses
--Difficulty: Medium
--Challenge: In the 2026 season, find the players who played at least 70 `games` AND averaged at least 20 `points_per_game`. Show `player`, `games` and `points_per_game`.
--My Solution:
SELECT player, games, points_per_game
FROM player_seasons
WHERE season=2026 AND games>=70
GROUP BY 1,2,3
HAVING AVG(points_per_game) >=20;
-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-where-good-team-missed
--Difficulty: Medium
--Challenge: Some very good teams still missed the playoffs — the 2008 Warriors won 48 games and stayed home. Return the `season`, `team_name` and `wins` of every team that won at least 45 games and did NOT make the playoffs, before the 2026 season.
--My Solution:
SELECT season, team_name, wins
FROM teams 
WHERE made_playoffs=FALSE AND wins>=45 AND season<2026;

