-- =====================================================
-- PulseBoard Week 1 - SQL Analysis
-- =====================================================


-- 1. Top 10 countries by average life expectancy
SELECT
    country,
    ROUND(AVG(life_expectancy), 2) AS avg_life_expectancy
FROM life_expectancy_data
GROUP BY country
ORDER BY avg_life_expectancy DESC
LIMIT 10;


-- 2. Bottom 10 countries by average life expectancy
SELECT
    country,
    ROUND(AVG(life_expectancy), 2) AS avg_life_expectancy
FROM life_expectancy_data
GROUP BY country
ORDER BY avg_life_expectancy ASC
LIMIT 10;


-- 3. Year-over-year life expectancy trend for 3 countries
-- Countries selected: India, Japan and United States of America

SELECT
    country,
    year,
    ROUND(life_expectancy, 2) AS life_expectancy
FROM life_expectancy_data
WHERE country IN ('India', 'Japan', 'United States of America')
ORDER BY country, year;


-- 4. Average life expectancy by status
-- Compares Developed and Developing countries

SELECT
    status,
    ROUND(AVG(life_expectancy), 2) AS avg_life_expectancy
FROM life_expectancy_data
GROUP BY status;


-- 5. Countries with the highest average years of schooling
SELECT
    country,
    ROUND(AVG(schooling), 2) AS avg_schooling
FROM life_expectancy_data
GROUP BY country
ORDER BY avg_schooling DESC
LIMIT 10;


-- 6. Average schooling vs average life expectancy by country
SELECT
    country,
    ROUND(AVG(schooling), 2) AS avg_schooling,
    ROUND(AVG(life_expectancy), 2) AS avg_life_expectancy
FROM life_expectancy_data
GROUP BY country
ORDER BY avg_schooling DESC;


-- 7. Top 5 countries by average GDP with life expectancy
SELECT
    country,
    ROUND(AVG(gdp), 2) AS avg_gdp,
    ROUND(AVG(life_expectancy), 2) AS avg_life_expectancy
FROM life_expectancy_data
GROUP BY country
ORDER BY avg_gdp DESC
LIMIT 5;


-- 8. Year with the biggest jump in global average life expectancy
WITH yearly_average AS (
    SELECT
        year,
        AVG(life_expectancy) AS avg_life_expectancy
    FROM life_expectancy_data
    GROUP BY year
),
yearly_change AS (
    SELECT
        year,
        avg_life_expectancy,
        avg_life_expectancy -
        LAG(avg_life_expectancy) OVER (ORDER BY year) AS change_from_previous_year
    FROM yearly_average
)
SELECT
    year,
    ROUND(avg_life_expectancy, 2) AS avg_life_expectancy,
    ROUND(change_from_previous_year, 2) AS increase
FROM yearly_change
WHERE change_from_previous_year IS NOT NULL
ORDER BY increase DESC
LIMIT 1;


-- 9. Countries with average immunization coverage below 50%
-- Using Hepatitis B, Polio and Diphtheria coverage

SELECT
    country,
    ROUND(AVG(hepatitis_b), 2) AS avg_hepatitis_b,
    ROUND(AVG(polio), 2) AS avg_polio,
    ROUND(AVG(diphtheria), 2) AS avg_diphtheria,
    ROUND(AVG(life_expectancy), 2) AS avg_life_expectancy
FROM life_expectancy_data
GROUP BY country
HAVING AVG(hepatitis_b) < 50
    OR AVG(polio) < 50
    OR AVG(diphtheria) < 50
ORDER BY avg_life_expectancy ASC;


-- 10. Average life expectancy by region/income group
-- If the dataset does not contain a region column,
-- Status is used as the available grouping variable.

SELECT
    status,
    ROUND(AVG(life_expectancy), 2) AS avg_life_expectancy,
    ROUND(AVG(schooling), 2) AS avg_schooling,
    ROUND(AVG(gdp), 2) AS avg_gdp
FROM life_expectancy_data
GROUP BY status
ORDER BY avg_life_expectancy DESC;