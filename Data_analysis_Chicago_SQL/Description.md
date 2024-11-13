# Chicago Socioeconomic, Public Schools, and Crime Data Analysis

## Overview
The **Chicago Socioeconomic, Public Schools, and Crime Data Analysis** project involves examining diverse datasets to uncover relationships between **socioeconomic factors**, **public school performance**, and **crime statistics** across neighborhoods in Chicago. By analyzing these connections, the project offers insights into how community conditions impact educational outcomes and crime rates.

## Project Objectives
- **Identify Correlations**: Explore relationships between socioeconomic indicators, school performance metrics, and crime rates.
- **Data-Driven Insights**: Provide data-driven insights into factors affecting public safety and educational outcomes in Chicago.
- **SQL Proficiency**: Demonstrate advanced SQL skills for data extraction, manipulation, and analysis.

## Project Stages
1. **Data Extraction**: Retrieved data on socioeconomic status, school performance, and crime statistics for different Chicago neighborhoods.
2. **Data Cleaning**: Cleaned and standardized datasets, handling missing values, duplicates, and inconsistencies to ensure reliable analysis.
3. **Data Aggregation**: Aggregated data by neighborhood to enable comparisons and uncover patterns.
4. **Advanced SQL Querying**: Leveraged SQL for filtering, grouping, and joining datasets to extract meaningful information and perform complex analyses.
5. **Data Analysis**: Analyzed relationships between datasets to reveal patterns and identify potential correlations.

## Key Features Analyzed
- **Socioeconomic Indicators**: Metrics such as median household income, employment rates, and educational attainment levels by neighborhood.
- **School Performance**: Public school performance indicators, including test scores, graduation rates, and funding levels.
- **Crime Rates**: Crime statistics broken down by type (e.g., violent vs. non-violent crimes) and neighborhood.

## Technology Stack
- **SQL**: Used for data extraction, transformation, aggregation, and advanced querying.
- **Python** : Used for additional data analysis and visualization.
- **Database Management**: Utilized relational database systems to manage and query large datasets.

## Analysis and Findings
- **Correlation Analysis**: Examined correlations between socioeconomic factors (e.g., income level) and school performance, as well as between crime rates and socioeconomic conditions.
- **Neighborhood Comparisons**: Identified neighborhoods with high crime rates and low school performance scores, which correlated with lower socioeconomic status.
- **Data-Driven Insights**: Observed that areas with higher median income and employment rates tended to have better school performance and lower crime rates, indicating potential socioeconomic impact.

## Example SQL Queries
- **Identify High Crime Neighborhoods**:
  ```sql
  SELECT neighborhood, COUNT(crime_id) AS crime_count
  FROM crime_data
  WHERE crime_type = 'Violent'
  GROUP BY neighborhood
  ORDER BY crime_count DESC;
  ```
  
- **Socioeconomic and School Performance Correlation**:
```sql
SELECT s.neighborhood, s.average_test_score, e.median_income
FROM school_data s
JOIN socioeconomic_data e ON s.neighborhood = e.neighborhood
WHERE e.median_income > 50000;
```

## Future Enhancements
- **Visualization**: Use tools like Python's Matplotlib or Seaborn to visualize trends and correlations.
- **Machine Learning**: Apply predictive modeling to forecast crime rates or school performance based on socioeconomic data.
- **Granular Analysis**: Break down analysis by crime type and specific school metrics for a more detailed view.

## Conclusion
The Chicago Socioeconomic, Public Schools, and Crime Data Analysis project demonstrates the power of data in understanding community challenges. By leveraging SQL to manage and analyze complex datasets, the project provides meaningful insights into how socioeconomic factors influence public safety and educational outcomes, potentially guiding policy and community support efforts.
