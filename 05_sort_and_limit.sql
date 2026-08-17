-- ============================================================
--SORT AND LIMIT
-- ============================================================

--https://sqljam.dev/?skin=nba&challenge=nba26-order-top10-scoring-seasons
--Difficulty: Easy
--Challenge: What are the 10 highest-scoring individual seasons in history? Show `season`, `player` and `points`, highest first.
--My Solution:
SELECT season, player, points
FROM player_seasons
ORDER BY points DESC
LIMIT 10;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-order-top5-ppg-2026
--Difficulty: Medium
--Challenge: Who were the 5 highest scorers per game in the 2026 season? Show `player` and `points_per_game`, highest first — break ties with `player` so the order is definite.
--My Solution:
SELECT player, points_per_game
FROM player_seasons
WHERE season=2026
ORDER BY points_per_game DESC, player
LIMIT 5;