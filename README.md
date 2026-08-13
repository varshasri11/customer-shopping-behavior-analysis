# Customer Shopping Behavior Analysis

An end-to-end data analytics project examining customer shopping behavior across 3,900 transactions — combining **Python (EDA & cleaning)**, **SQL (business analysis)**, and **Power BI (dashboard)** to uncover revenue drivers, customer segments, and purchasing patterns.

## 📁 Project Structure

| File | Description |
|---|---|
| `Customer_behaviour_analysis.ipynb` | Data cleaning, EDA, and feature engineering in Python (pandas) |
| `SQL_Queries.sql` | 10 business-question SQL queries (revenue, segmentation, discounts, ratings) |
| `customer_behavior_dashboard.pbix` | Interactive Power BI dashboard |
| `customer_shopping_behavior.csv` | Source dataset (3,900 rows, 18 columns) |

## 🛠️ Tech Stack
Python (pandas) · SQL (PostgreSQL/MySQL) · Power BI · Jupyter Notebook

## 🔍 What This Project Covers

1. **Data Cleaning & Feature Engineering** — handled missing review ratings (median imputation by category), standardized column names, engineered `age_group` (quartile-based) and `purchase_frequency_days` fields, and removed a redundant column after validating `discount_applied` and `promo_code_used` were identical.
2. **SQL Analysis** — 10 queries answering business questions: revenue by gender, discount behavior vs. spend, top-rated products, shipping type comparison, subscriber vs. non-subscriber spend, customer segmentation (new/returning/loyal), best-sellers by category, and revenue by age group.
3. **Power BI Dashboard** — interactive visualization of revenue, customer segments, and product performance for stakeholder-level reporting.

## 📊 Key Insights

- Total revenue across the dataset: **$233,081** from 3,900 customers (avg. order value ≈ **$59.76**)
- **Clothing** is the top revenue category (~$104K), followed by Accessories (~$74K)
- Male customers generated significantly higher total revenue than female customers in this dataset, driven by a larger share of transactions
- **43%** of purchases involved a discount
- Average review rating: **3.75 / 5**
- Revenue is fairly evenly spread across seasons, with Fall slightly leading

*(Full breakdown in the analysis report.)*

## ⚙️ Setup

```bash
pip install pandas sqlalchemy psycopg2-binary pymysql
```

Database credentials are read from environment variables (never hardcoded):

```bash
export DB_PASSWORD="your_password_here"
```

## 📈 Sample SQL Query

```sql
-- Segment customers into new, returning and loyal based on purchase history
with t1 as (
  select customer_id, previous_purchases,
    case when previous_purchases between 2 and 10 then 'Returning Customer'
         when previous_purchases > 10 then 'Loyal Customer'
         else 'New Customer' end as customer_segment
  from customer
)
select customer_segment, count(customer_id) as total_customers
from t1
group by customer_segment
order by total_customers desc;
```

---
*Dataset used for educational/portfolio purposes.*
