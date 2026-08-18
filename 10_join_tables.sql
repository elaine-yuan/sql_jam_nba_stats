-- ============================================================
--JOIN TABLES
-- ============================================================

--https://sqljam.dev/?skin=nba&challenge=nba26-join-2026-scorer-heights
--Difficulty: Medium
--Challenge: For the 2026 season, show each player who averaged at least 25 `points_per_game`, along with how tall he is. Return `player`, `points_per_game` and `height_inches`.
--My Solution:
SELECT ps.player, ps.points_per_game, p.height_inches
FROM player_seasons ps JOIN players p ON ps.player_id=p.player_id
WHERE season=2026 AND points_per_game>=25;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-join-65-win-team-scorers
--Difficulty: Hard
--Challenge: Find every player-season where the player's team won at least 65 games. Show `season`, `player`, `points` and the team's `wins`.
--My Solution:
SELECT ps.season, player, points, wins
FROM player_seasons ps JOIN teams t ON ps.team=t.abbrev AND ps.season=t.season
WHERE wins>=65;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-join-allnba-2025-scoring
--Difficulty: Hard
--Challenge: The `all_league_teams` table holds All-NBA, All-Defense and All-Rookie selections. Show the five players named to the 2025 All-NBA First Team (`honor = 'All-NBA'`, `team_number = 1`) alongside what they averaged that year. Return `player` and `points_per_game`.
--My Solution:
SELECT ps.player, ps.points_per_game
FROM all_league_teams alt JOIN player_seasons ps ON alt.season=ps.season AND alt.player_id=ps.player_id
WHERE honor='All-NBA' AND team_number=1 AND ps.season=2025;

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-join-two-way-2025
--Difficulty: Hard
--Challenge: A two-way star is one the league honours at both ends of the floor. Which players made an All-NBA team AND an All-Defense team in the same 2025 season? Return `player` and `season`.
SELECT ps.player, ps.season
FROM all_league_teams alt JOIN player_seasons ps ON alt.season=ps.season AND alt.player_id=ps.player_id
WHERE ps.season=2025 
GROUP BY ps.player, ps.season
HAVING SUM(CASE WHEN honor='All-NBA' THEN 1 ELSE 0 END)=1 AND SUM(CASE WHEN honor='All-Defense' THEN 1 ELSE 0 END)=1;