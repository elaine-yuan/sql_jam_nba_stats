-- ============================================================
--FILTER GROUPS
-- ============================================================

--https://sqljam.dev/?skin=nba&challenge=nba26-having-college-factories
--Difficulty: Medium
--Challenge: Which colleges have had more than 60 players drafted? Show `college` and the count as `picks`. Ignore picks with no college recorded.
--My Solution:
SELECT college, COUNT(player) AS picks
FROM draft_picks
WHERE college IS NOT NULL
GROUP BY college
HAVING COUNT(player)>60;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-having-all-star-legends
--Difficulty: Hard
--Challenge: Which players were selected as All-Stars at least 13 times? Show `player`, the number of selections as `selections`, and the season of their first selection as `first_selection`.
--My Solution:
SELECT player, COUNT(*) AS selections, MIN(season) AS first_selection
FROM all_star_selections
GROUP BY player
HAVING COUNT(*)>=13;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-having-first-team-legends
--Difficulty: Medium
--Challenge: First Team All-NBA is the hardest annual honour to earn. Which players earned it at least 8 times? Return `player` and the number of times as `first_teams`.
--My Solution:
SELECT player, COUNT(*) AS first_teams
FROM all_league_teams
WHERE honor='All-NBA' AND team_number=1 
GROUP BY player 
HAVING COUNT(*)>=8;