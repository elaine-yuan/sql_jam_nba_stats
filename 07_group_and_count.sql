-- ============================================================
--GROUP AND AVERAGE
-- ============================================================

--https://sqljam.dev/?skin=nba&challenge=nba26-group-players-per-position
--Difficulty: Easy
--Challenge: How many players are listed at each `position` in the `players` table? Show `position` and the count, naming the count `players`.
--My Solution:
SELECT position, COUNT(player) AS players
FROM players
GROUP BY position;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-group-picks-per-team-2025
--Difficulty: Medium
--Challenge: Which teams drafted the most players in 2025? Return `team_abbrev` and the count as `picks`, most first, breaking ties by `team_abbrev`.--My Solution:
SELECT team_abbrev, COUNT(player) AS picks
FROM draft_picks
WHERE season=2025
GROUP BY team_abbrev
ORDER BY COUNT(DISTINCT player) DESC, team_abbrev;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-agg-height-by-position
--Difficulty: Medium
--Challenge: For each `position` in the `players` table, show the position, how many players have it as `players`, and their average `height_inches` rounded to 2 decimals as `avg_height`.
--My Solution:
SELECT team_name, COUNT(DISTINCT season) AS seasons, SUM(CASE WHEN made_playoffs=TRUE THEN 1 ELSE 0 END) AS playoff_seasons
FROM teams
WHERE season <> 2026
GROUP BY team_name
HAVING seasons>=40;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-group-win-tiers
--Difficulty: Hard
--Challenge: Sort every team season since 2000 by how many games it won: 60 or more is 'juggernaut', 50 to 59 is 'contender', 41 to 49 is 'winning', and anything else is 'losing'. Return the label as `tier` and how many team seasons fall in it as `n`.
SELECT CASE WHEN wins>=60 THEN 'juggernaut'
WHEN wins >=50 THEN 'contender'
WHEN wins >=41 THEN 'winning'
ELSE 'losing' END AS tier,
COUNT(season) AS n
FROM teams
WHERE season>=2000
GROUP BY tier;