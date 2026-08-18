-- ============================================================
--RANK WITHIN GROUPS
-- ============================================================

--https://sqljam.dev/?skin=nba&challenge=nba26-win-number-td-leaders
--Difficulty: Medium
--Challenge: Number the 2026 triple-double leaders. For players with at least 5 triple-doubles that season, return `player`, `triple_doubles`, and the row number as `rn` (order by `triple_doubles` descending, then `player`). Use ROW_NUMBER().
--My Solution:
SELECT player, triple_doubles, ROW_NUMBER() OVER(ORDER BY triple_doubles DESC, player) AS rn
FROM player_seasons
WHERE season=2026 AND triple_doubles>=5;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-win-rank-2026-scorers
--Difficulty: Hard
--Challenge: Within each `position`, rank the 2026 players by `triple_doubles`. Show `player`, `position`, `triple_doubles` and the rank as `td_rank`, for players with at least 1 triple-double. Players who tie should share a rank — that's what RANK() does.
--My Solution:
SELECT player, position, triple_doubles, RANK() OVER(PARTITION BY position ORDER BY triple_doubles DESC) AS td_rank
FROM player_seasons
WHERE season=2026 AND triple_doubles>=1;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-win-jokic-year-over-year
--Difficulty: Hard
--Challenge: Track how Nikola Jokić's scoring changed year to year. Filter with `player_id = 'jokicni01'` and show `season`, `points_per_game`, and his previous season's `points_per_game` as `prev_ppg`, in season order.
--My Solution:
SELECT season, points_per_game, LAG(points_per_game,1) OVER(ORDER BY season ASC) AS prev_ppg
FROM player_seasons
WHERE player_id='jokicni01'
ORDER BY season;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-win-career-running-total
--Difficulty: Hard
--Challenge: Watch LeBron James's career points pile up. For `player_id = 'jamesle01'`, return `season`, `points`, and the running total of his points as `career_points`, oldest season first.
--My Solution:
SELECT season, points, SUM(points) OVER(ORDER BY season) AS career_points
FROM player_seasons
WHERE player_id='jamesle01'
ORDER BY season;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-win-rolling-scoring-average
--Difficulty: Hard
--Challenge: Smooth out Stephen Curry's scoring. For `player_id = 'curryst01'`, return `season`, `points_per_game`, and a three-season rolling average as `rolling3` — this season plus the two before it — rounded to 1 decimal, oldest season first.
--My Solution:
SELECT season, points_per_game, ROUND(AVG(points_per_game) OVER(ORDER BY season ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),1) AS rolling3
FROM player_seasons
WHERE player_id='curryst01'
ORDER BY season;