-- ============================================================
--KEEP UNMATCHED ROWS
-- ============================================================

--https://sqljam.dev/?skin=nba&challenge=nba26-left-drafted-never-played
--Difficulty: Medium
--Challenge: Since the 2000 draft, which first-round picks never played a single season? Show `season`, `overall_pick` and `player` from `draft_picks` for players with no matching row in `player_seasons`.
--My Solution:
SELECT dp.season, dp.overall_pick, dp.player
FROM draft_picks dp LEFT JOIN player_seasons ps ON dp.player_id=ps.player_id
WHERE dp.round=1 AND dp.season>=2000 AND ps.player_id IS NULL;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-left-25ppg-no-all-star
--Difficulty: Hard
--Challenge: Since 2000, find the seasons where a player averaged at least 25 `points_per_game` but was NOT picked as an All-Star that same season. Show `season`, `player` and `points_per_game`.
--My Solution:
SELECT ps.season, ps.player, ps.points_per_game
FROM player_seasons ps LEFT JOIN  all_star_selections ass ON ps.season=ass.season AND ps.player_id=ass.player_id
WHERE ps.season>=2000 AND ps.points_per_game>=25 AND ass.player_id IS NULL;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-left-dpoy-never-allnba
--Difficulty: Hard
--Challenge: Some of the greatest defenders were never top-15 offensive players. Which Defensive Player of the Year winners (`award = 'DPOY'` and `won`) were never once named to an All-NBA team? Return each `player` once.
--My Solution:
SELECT DISTINCT av.player
FROM award_voting av LEFT JOIN (SELECT * FROM all_league_teams WHERE honor='All-NBA') alt ON av.player_id=alt.player_id
WHERE award='DPOY' AND won=TRUE  AND alt.player_id IS NULL;