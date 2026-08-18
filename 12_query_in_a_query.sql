-- ============================================================
--QUERY IN A QUERY
-- ============================================================

--https://sqljam.dev/?skin=nba&challenge=nba26-sub-mvp-club-2026
--Difficulty: Medium
--Challenge: Of the players active in the 2026 season, which ones have won an MVP at some point in their career? Show `player` and `points_per_game`. The MVP winners live in `award_voting`.
--My Solution:
SELECT player, points_per_game
FROM player_seasons
WHERE season=2026 AND player_id IN(
  SELECT player_id
  FROM award_voting
  WHERE award='MVP' AND won=TRUE);

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-sub-above-average-2026
--Difficulty: Hard
--Challenge: In the 2026 season, which players outscored the average for their *own position*? Show `player`, `position` and `points`.
--My Solution:
SELECT player, position, points
FROM player_seasons ps1 
WHERE season=2026 AND points>(SELECT AVG(points) FROM player_seasons ps2 WHERE season=2026 AND ps1.position=ps2.position);

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-sub-never-all-star
--Difficulty: Hard
--Challenge: Which 2026 scorers have never been picked for an All-Star game? Return `player` and `points_per_game` for players averaging at least 18 points in 2026 whose `player_id` appears nowhere in `all_star_selections`. Order by `points_per_game` descending. Use NOT EXISTS. Ties broken by `player` A-Z.
--My Solution:
SELECT player, points_per_game
FROM player_seasons ps
WHERE season=2026 AND points_per_game>=18 AND NOT EXISTS(SELECT player_id FROM all_star_selections ass WHERE ps.player_id=ass.player_id)
ORDER BY points_per_game DESC, player;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-sub-team-leading-scorer
--Difficulty: Hard
--Challenge: Who led each team in total points in 2026? Return `player`, `team` and `points` for the player on each team with the highest `points` that season. Order by `points` descending and show the top 10. Compare each row against its own team with a correlated subquery.
--My Solution:
SELECT player, team, points
FROM player_seasons ps1
WHERE season=2026 AND points=(SELECT MAX(points) FROM player_seasons ps2 WHERE season=2026 AND ps1.team=ps2.team)
ORDER BY points DESC
LIMIT 10;