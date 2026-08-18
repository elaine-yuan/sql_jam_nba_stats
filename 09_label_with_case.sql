-- ============================================================
--LABEL WITH CASE
-- ============================================================

--https://sqljam.dev/?skin=nba&challenge=nba26-case-scoring-bands
--Difficulty: Medium
--Challenge: Sort 2026's scorers into tiers. For players averaging at least 18 points, return `player`, `points_per_game` and `band` — 'elite' at 28 or more, 'star' at 22 or more, otherwise 'starter'. Highest scoring first, ties broken by `player` A-Z.
--My Solution:
SELECT player, points_per_game,
CASE WHEN AVG(points_per_game)>=28 THEN 'elite'
WHEN AVG(points_per_game)>=22 THEN 'star'
ELSE 'starter' END AS band
FROM player_seasons
WHERE season=2026
GROUP BY player, points_per_game
HAVING AVG(points_per_game)>=18
ORDER BY points_per_game DESC, player;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-case-high-scorers-by-position
--Difficulty: Hard
--Challenge: How many scorers does each position produce? For the 2026 season, return `position`, the number of players as `players`, and how many of them averaged at least 20 points as `high_scorers`. Only positions with at least 20 players. Most high scorers first, ties broken by `position` A-Z.
--My Solution:
SELECT position, COUNT(*) AS players, SUM(CASE WHEN points_per_game>=20 THEN 1 ELSE 0 END) AS high_scorers
FROM player_seasons
WHERE season=2026
GROUP BY position
HAVING COUNT(*)>=20
ORDER BY high_scorers DESC, position;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-case-team-outlook
--Difficulty: Medium
--Challenge: Label every 2026 team by how its season went. Return `team_name`, `wins` and `outlook` — 'contender' at 55 wins or more, 'solid' at 45 or more, otherwise 'rebuilding'. Most wins first, ties broken by `team_name` A-Z.
--My Solution:
SELECT team_name, wins, 
CASE WHEN wins>=55 THEN 'contender'
WHEN wins>=45 tHEN 'solid'
ELSE 'rebuilding' END AS outlook
FROM teams
WHERE season=2026
ORDER BY wins DESC, team_name;