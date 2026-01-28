# DATA-ANALYST-INTERNSHIP-Elevate-Labs-Task-8

# Global Superstore – Advanced SQL Window Functions Project

## Dataset
**Global Superstore Dataset (CSV)**

The dataset contains order-level retail sales data including:
- Customers
- Products
- Categories
- Regions
- Order dates
- Sales and profit metrics

---

## SQL Concepts Used
- `GROUP BY` aggregations
- Window Functions:
  - `ROW_NUMBER()`
  - `RANK()`
  - `DENSE_RANK()`
  - `SUM() OVER`
  - `LAG()`
- `PARTITION BY`
- Common Table Expressions (CTEs)
- Time-series analysis using `DATE_TRUNC`
- Exporting query outputs to CSV

---

## Analysis Performed

### 1. Data Import & Validation
- Imported CSV into PostgreSQL
- Ensured correct data types for dates and numeric columns

### 2. Customer Sales Analysis
- Calculated total sales per customer using `GROUP BY`
- Identified high-value customers

### 3. Regional Customer Ranking
- Ranked customers by total sales within each region
- Used `ROW_NUMBER()` for strict ranking

### 4. Ranking Comparison
- Compared `RANK()` vs `DENSE_RANK()`
- Analyzed how ties affect rankings

### 5. Running Total Sales
- Calculated cumulative sales over time
- Used window `SUM()` ordered by order date

### 6. Month-over-Month Growth
- Aggregated monthly sales
- Used `LAG()` to calculate MoM growth percentage

### 7. Top 3 Products per Category
- Ranked products within each category
- Extracted top 3 using `DENSE_RANK()` and CTEs

---

## Business Insights

1. **A small group of customers contributes a disproportionately high share of total sales**, indicating strong customer concentration and opportunities for loyalty programs.

2. **Top-performing customers consistently rank high within specific regions**, suggesting regional enterprise clients or localized buying behavior.

3. **Technology and Office Supplies frequently dominate top product rankings**, making them strong candidates for targeted promotions and inventory prioritization.
