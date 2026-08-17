-- ============================================================
--MISSING VALUES
-- ============================================================

--https://sqljam.dev/?skin=nba&challenge=nba26-null-traded
--Challenge: A player traded mid-season has no single team, so their `team` is blank. Return the `player` and `season` for every such row in the 2026 season.
--Difficulty: Easy
--My Solution:
SELECT player, season
FROM player_seasons
WHERE team IS NULL AND season=2026;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-null-pre-three
--Difficulty: Medium
--Challenge: The 3-point line didn't always exist, so `fg3_attempted` is blank for older seasons. Return each distinct `season` where it is blank.
--My Solution:
SELECT DISTINCT season
FROM player_seasons
WHERE fg3_attempted IS NULL;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-null-college-fallback
--Difficulty: Medium
--Challenge: Not every player went to college — some came straight from high school or from overseas, and their `colleges` is empty. For every player whose career spanned at least 18 seasons, return the `player` and their `colleges`, showing the text 'None' where there isn't one.
--My Solution:
SELECT player, COALESCE(colleges, 'None') AS colleges
FROM players
WHERE seasons_span>=18;