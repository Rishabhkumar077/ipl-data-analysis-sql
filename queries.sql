-- 1. Top run scorers
SELECT batsman, SUM(runs) AS total_runs
FROM deliveries
GROUP BY batsman
ORDER BY total_runs DESC;

-- 2. Most wickets
SELECT bowler, COUNT(*) AS wickets
FROM deliveries
WHERE is_wicket = 1
GROUP BY bowler
ORDER BY wickets DESC;

-- 3. Team with most wins
SELECT winner, COUNT(*) AS wins
FROM matches
GROUP BY winner
ORDER BY wins DESC;

-- 4. Strike rate (min balls)
SELECT batsman,
       SUM(runs)*1.0/COUNT(*) AS strike_rate
FROM deliveries
GROUP BY batsman
HAVING COUNT(*) >= 2
ORDER BY strike_rate DESC;

-- 5. Death over performance
SELECT batsman, SUM(runs) AS death_runs
FROM deliveries
WHERE over_number >= 16
GROUP BY batsman
ORDER BY death_runs DESC;

-- 6. Match-wise team score
SELECT match_id, batting_team, SUM(runs) AS total_runs
FROM deliveries
GROUP BY match_id, batting_team;

-- 7. Consistent players (avg per match)
SELECT batsman, AVG(match_runs) AS avg_runs
FROM (
    SELECT match_id, batsman, SUM(runs) AS match_runs
    FROM deliveries
    GROUP BY match_id, batsman
) t
GROUP BY batsman
ORDER BY avg_runs DESC;

-- 8. Powerplay vs Death comparison
SELECT 
  CASE 
    WHEN over_number <= 6 THEN 'Powerplay'
    WHEN over_number >= 16 THEN 'Death'
    ELSE 'Middle'
  END AS phase,
  SUM(runs) AS total_runs
FROM deliveries
GROUP BY phase;
