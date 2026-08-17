-- ============================================================
--SELECT BASICS
-- ============================================================

--https://sqljam.dev/?skin=nba&challenge=nba26-select-team-records
--Challenge: Show the `season`, `team_name`, `wins` and `losses` columns for every row in the `teams` table.
--Difficulty: Easy
--My Solution:
SELECT season, team_name, wins, losses
FROM teams;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-select-distinct-leagues
--Difficulty: Easy
--Challenge: This dataset covers more than one professional league. List each distinct value in the `lg` column of `player_seasons` — you should get three rows.
--My Solution:
SELECT DISTINCT(lg) 
FROM player_seasons;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-select-aliases
--Difficulty: Easy
--Challenge: Rename the columns in your output: for the 2026 season, return `player` as `name`, `points_per_game` as `ppg` and `rebounds_per_game` as `rpg`.
--My Solution:
SELECT player AS name, points_per_game AS ppg, rebounds_per_game AS rpg
FROM player_seasons
WHERE season=2026;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-select-player-label
--Difficulty: Medium
--Challenge: Build a display label for the 2026 season's top scorers. For every player averaging at least 28 `points_per_game` in 2026, return a single column `label` reading like `Luka Dončić (LAL)`, plus their `points_per_game`.
--My Solution:
SELECT player || ' ('||team||')' AS label, points_per_game
FROM player_seasons
WHERE season=2026 AND points_per_game>=28;
