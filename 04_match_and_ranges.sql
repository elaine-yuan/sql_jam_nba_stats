-- ============================================================
--MATCH AND RANGES
-- ============================================================

--https://sqljam.dev/?skin=nba&challenge=nba26-match-duke-players
--Challenge: Find every player whose `colleges` value mentions Duke. Show `player` and `colleges`. (Some players attended more than one school, so the value isn't always exactly 'Duke'.)
--Difficulty: Easy
--My Solution:
SELECT player, colleges
FROM players
WHERE colleges LIKE '%Duke%';

-- ------------------------------------------------------------

--https://sqljam.dev/?skin=nba&challenge=nba26-null-pre-three
--Difficulty: Medium
--Challenge: The ABA and BAA were rival leagues the NBA absorbed. Who were their big scorers? Return each distinct `player` from `player_seasons` whose `lg` is one of 'ABA' or 'BAA', in a season between 1968 and 1976, averaging at least 25 points per game.
--My Solution:
SELECT DISTINCT player
FROM player_seasons
WHERE lg IN('ABA', 'BAA') AND (1968<=season AND season <=1976) AND points_per_game>=25;