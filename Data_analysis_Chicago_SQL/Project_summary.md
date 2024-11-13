# Chicago Socioeconomic, Public Schools, and Crime Data Analysis

## Project Summary

| **Aspect**                     | **Details**                                                                                                                                     |
|--------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| **Objective**                  | Analyze relationships between socioeconomic factors, public school performance, and crime rates across neighborhoods in Chicago.               |
| **Data Sources**               | Socioeconomic data, public school performance metrics, and crime statistics for Chicago neighborhoods.                                         |
| **Key Features Analyzed**      | Socioeconomic indicators (income, employment rates), school performance (test scores, graduation rates), and crime rates (violent vs. non-violent). |
| **Technologies Used**          | SQL for data extraction, manipulation, and advanced querying; Python (optional) for further analysis and visualization.                        |
| **Analysis Techniques**        | Data cleaning, aggregation, correlation analysis, and SQL joins to identify relationships between features.                                    |
| **Findings**                   | Areas with higher income and employment tend to have better school performance and lower crime rates, highlighting socioeconomic impact.        |
| **Future Enhancements**        | Add data visualizations, apply machine learning for predictive insights, and perform a more granular analysis by specific crime and school metrics. |
| **Example SQL Query**          | `SELECT neighborhood, COUNT(crime_id) AS crime_count FROM crime_data WHERE crime_type = 'Violent' GROUP BY neighborhood ORDER BY crime_count DESC;` |
