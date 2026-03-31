# Brazilian E-Commerce Sales Analysis

## Overview
End-to-end sales and revenue analysis of Olist, Brazil's largest e-commerce marketplace, 
using SQL (PostgreSQL) and Python. This project analyzes over 100,000 orders to extract 
actionable business insights.

## Business Questions Answered
1. What is the total revenue and average order value by payment method?
2. Which product categories generate the most revenue?
3. How does revenue trend month over month?
4. Which states have the highest customer concentration?
5. What is the relationship between delivery time and customer satisfaction?

## Dataset
- **Source:** Brazilian E-Commerce Public Dataset by Olist (Kaggle)
- **Size:** 100,000+ orders | 9 tables | 2016-2018
- **Tables:** customers, orders, order_items, order_payments, products, sellers, reviews

## Tools Used
- **SQL:** PostgreSQL via DBeaver
- **Python:** pandas, matplotlib
- **Version Control:** Git & GitHub

## Project Structure
```
├── queries/
│   ├── 01_revenue_analysis.sql
│   ├── 02_category_analysis.sql
│   ├── 03_monthly_trends.sql
│   └── 04_customer_analysis.sql
├── notebooks/
│   └── ecommerce_analysis.ipynb
└── README.md
```

# Brazilian E-Commerce Sales Analysis 🛒

## Overview
End-to-end sales and revenue analysis of Olist, Brazil's largest e-commerce 
marketplace, using SQL (PostgreSQL) and Python. This project analyzes over 
100,000 orders placed between 2016 and 2018 to extract actionable business 
insights for strategic decision-making.

## Business Questions Answered
1. What is the total revenue and average order value?
2. Which payment methods drive the most revenue?
3. How does revenue trend month over month?
4. What seasonality patterns exist in the data?
5. Which product categories generate the most revenue?

## Dataset
- **Source:** Brazilian E-Commerce Public Dataset by Olist (Kaggle)
- **Size:** 100,000+ orders | 9 tables | 2016–2018
- **Tables:** customers, orders, order_items, order_payments, products, sellers, reviews

## Tools Used
- **SQL:** PostgreSQL via DBeaver
- **Python:** pandas, matplotlib
- **Version Control:** Git & GitHub

## Project Structure
```
├── queries/
│   ├── 01_revenue_analysis.sql
│   ├── 02_category_analysis.sql
│   ├── 03_customer_analysis.sql
│   └── 04_geographic_analysis.sql
├── notebooks/
│   └── ecommerce_analysis.ipynb
└── README.md
```

## Key Findings

### 💰 Overall Revenue
- Total revenue: **$16,008,872** across **103,877 transactions**
- Average order value: **$154.11**
- The business processed over **$16M USD** in a ~2 year period

### 💳 Payment Methods
- **Credit card dominates** with **78.34%** of total revenue ($12,542,084)
- Boleto (Brazilian bank slip) accounts for **17.92%** — relevant because 
  it serves unbanked customers without credit cards
- Debit card represents only **1.36%**, suggesting customers prefer 
  installment options over immediate full payment

### 📦 Installments
- Most customers prefer **2 installments**, indicating **price sensitivity** 
  and preference for flexible payment options
- This suggests Olist's customer base is largely middle-income, 
  leveraging credit to afford purchases

### 📈 Revenue Growth
- The business grew approximately **2,500%** in less than one year 
  (Sep 2016 to Aug 2017)
- **December 2016** shows near-zero activity (1 order), likely due to 
  Brazilian summer holidays — Brazil is in the southern hemisphere, 
  making December a vacation month
- **January 2017** marks the beginning of sustained growth, suggesting 
  a combination of platform expansion and post-holiday demand recovery
- By **August 2017**, monthly orders reached 4,331 with $674,396 in revenue

### 📊 Growth Trend
- Revenue grew consistently from **$59K in October 2016** to 
  **$674K in August 2017**
- This 10x growth in 10 months reflects both organic demand and 
  aggressive seller onboarding by Olist

## Conclusions & Business Recommendations
1. **Double down on credit card experience** — 78% of revenue depends on it. 
   Any friction in the credit card checkout flow directly impacts revenue.
2. **Promote installment options** — customers respond to flexible payments. 
   Offering 3-6 installments could increase average order value.
3. **Plan for December seasonality** — historically the lowest month. 
   Marketing campaigns should focus on November (pre-holiday) and 
   January (post-holiday recovery).

## Author
**Simón Segovia** | Financial & Data Analyst  
📧 [your email]  
💼 [your LinkedIn URL]

## Key Findings
*Coming soon — analysis in progress*

## Author
**Simón Segovia** | Financial & Data Analyst
