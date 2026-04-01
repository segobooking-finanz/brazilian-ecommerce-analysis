# Brazilian E-Commerce Sales Analysis 🛒

## Overview
End-to-end sales and revenue analysis of Olist, Brazil's largest e-commerce 
marketplace, using SQL (PostgreSQL) and Python. This project analyzes over 
100,000 orders placed between 2016 and 2018 to extract actionable business 
insights for strategic decision-making.

## Business Questions Answered
1. What is the total revenue and average order value by payment method?
2. Which payment methods and installment preferences drive revenue?
3. How does revenue trend month over month — and what drives seasonality?
4. Which product categories and sellers generate the most value?
5. What is the relationship between delivery time and customer satisfaction?
6. Where are customers concentrated geographically, and where is the opportunity?

## Dataset
- **Source:** Brazilian E-Commerce Public Dataset by Olist (Kaggle)
- **Size:** 100,000+ orders | 9 tables | 2016–2018
- **Tables:** customers, orders, order_items, order_payments, products, sellers, reviews

## Tools Used
- **SQL:** PostgreSQL via DBeaver
- **Python:** pandas, matplotlib, seaborn
- **Version Control:** Git & GitHub

## Project Structure
```
├── queries/
│   ├── 01_revenue_analysis.sql
│   ├── 02_category_analysis.sql
│   ├── 03_customer_analysis.sql
│   └── 04_delivery_analysis.sql
├── notebooks/
│   └── ecommerce_analysis.ipynb
└── README.md
```

---

## Key Findings

### 💰 Overall Revenue
- Total revenue: **$16,008,872** across **103,877 transactions**
- Average order value: **$154.11**
- The business processed over **$16M USD** in approximately 2 years

### 💳 Payment Methods
- **Credit card dominates** with **78.34%** of total revenue ($12,542,084)
- Boleto (Brazilian bank slip) accounts for **17.92%** — serves unbanked 
  customers without credit cards, a key inclusion segment
- Debit card represents only **1.36%**, suggesting strong preference for 
  installment options over immediate full payment
- Most customers prefer **2 installments** — signals price sensitivity and 
  middle-income customer base leveraging credit to afford purchases

### 📈 Revenue Growth & Seasonality
- The business grew approximately **2,500%** in less than one year 
  (Sep 2016 to Aug 2017)
- **December 2016** shows near-zero activity — Brazil's summer holiday 
  season (southern hemisphere) drove the dip
- **November 2017: +53% MoM growth** — directly correlated with Black Friday
- **December consistently drops** after November peak (-26% in 2017), 
  confirming customers pull forward purchases to Black Friday
- By 2018, monthly revenue **stabilized between $1M–$1.16M**, 
  indicating business maturity and predictable demand

### 🛍️ Top Product Categories
- **Health & Beauty leads** with $5,034,725 (9.39% revenue share) across 
  8,836 orders and 2,444 unique products — most diverse category
- **Watches & Gifts** has the highest average price ($201.14) with only 
  1,329 unique products — fewer SKUs, premium positioning
- **Computers** averages $1,098 per item — ultra-premium niche segment
- **Bed, Bath & Table** drives the most orders (9,417) at $93 avg — 
  high volume, lower margin category
- Top 10 categories represent approximately **62% of total revenue**
- **November 2017 Black Friday effect** across categories:
  - Watches & Gifts: $390,898 (+48% vs October)
  - Bed, Bath & Table: $357,650 (+93% vs October)
  - Computers & Accessories: $290,624 (+65% vs October)

### 📦 Freight Efficiency
- **Home Comfort, Flowers and Furniture** have the worst freight-to-price 
  ratios (54%, 44%, 37%) — shipping costs eat significantly into margins
- **Electronics** has a 29% freight ratio across 11,068 items — 
  logistics optimization is critical at this volume
- **Health & Beauty and Watches** have low freight ratios — 
  most profitable categories to ship

### 🏪 Seller Performance
- Top seller (Guariba, SP): **$229,472** from 1,132 orders at $198 avg — 
  high volume strategy
- Second seller (Lauro de Freitas, BA): **$222,776** from only 358 orders 
  at **$543 avg** — premium product strategy
- Only **18 Platinum sellers** (>$100K) generate $2,683,686 combined
- **Gold sellers outperform Platinum in satisfaction** (4.14 vs 4.04) — 
  larger sellers sacrifice service quality for volume
- **2,801 Bronze sellers** average $1,635 each but collectively generate 
  $4,582,342 — the long tail matters

### 🔄 Customer Retention
- **96.88% of customers buy only once** — classic e-commerce challenge
- Only **2.86% return for a second purchase**
- Massive retention opportunity: moving 5% of one-time buyers to repeat 
  customers would significantly impact revenue
- **November 2017: 7,430 new customers** — biggest acquisition month
- Growth from 3 customers (Sep 2016) to 7,000+ monthly by 2018

### 🗺️ Geographic Distribution
- **São Paulo: 41.98% of customers, 37.47% of revenue** ($5,998,226)
- Top 3 states (SP, RJ, MG) = **62.56% of total revenue**
- **Bahia** has the highest avg order value in top 10 ($170.82) — 
  premium buyers despite lower volume
- **Divinópolis MG** leads city avg order value at $276 — outperforming 
  São Paulo ($137) despite being a much smaller city
- States like BA, GO, DF and ES show emerging demand — underserved 
  markets with real purchasing power

### 🚚 Delivery Performance & Customer Satisfaction
- Average actual delivery: **12.1 days** vs estimated **23.4 days** — 
  Olist underpromises and overdelivers by 11 days on average
- **91.89% on-time rate** — industry-leading operational performance
- Delivery time directly correlates with review scores:

| Delivery Range | Orders | Share | Avg Review |
|----------------|--------|-------|------------|
| 0–7 days | 33,685 | 34.96% | ⭐ 4.41 |
| 8–14 days | 36,396 | 37.77% | ⭐ 4.29 |
| 15–21 days | 15,381 | 15.96% | ⭐ 4.10 |
| 22–30 days | 6,865 | 7.12% | ⭐ 3.49 |
| 30+ days | 4,032 | 4.18% | ⭐ 2.18 |

- Every additional **2.5 days** of delivery costs approximately **1 star**
- **São Paulo: 8.3 days avg** — fastest state, highest satisfaction (4.25)
- **Amapá: 26.7 days, Roraima: 29 days** — remote northern states wait 
  nearly 3x longer than SP customers
- Delivery times improved **62%** from Oct 2016 (19.1 days) to Aug 2018 
  (7.3 days) — sign of maturing logistics network
- **Alagoas (23.37%)** and **Maranhão (19.13%)** have the worst late 
  delivery rates — consistently score below 4.0 in reviews

### 💡 Counterintuitive Finding
- Orders delivered in 30+ days have the **highest avg order value ($189)** 
  vs 0–7 day orders ($134) — heavy/large items (furniture, appliances) 
  naturally take longer AND cost more. Not a standard product problem.

---

## Business Recommendations
1. **Reduce delivery time below 10 days** — the single most impactful 
   lever for customer satisfaction and repeat purchases
2. **Double down on credit card experience** — 78% of revenue depends on 
   it. Any checkout friction directly impacts the bottom line
3. **Launch a retention program** — 96.88% one-time buyers is a massive 
   opportunity. Post-purchase campaigns targeting this segment could 
   unlock significant incremental revenue
4. **Plan inventory for November** — Black Friday drives +53% MoM growth. 
   Logistics must scale accordingly to avoid the delivery spike seen in 2017
5. **Expand into northeastern states** — BA, AL, MA show purchasing power 
   but suffer from poor delivery infrastructure. Solving logistics here 
   unlocks an underserved market
6. **Focus on Health & Beauty and Watches** — top revenue categories with 
   low freight ratios, strong margins, and consistent demand growth

---

## Author
**Simón Segovia** | Financial & Data Analyst  
📧 [your email]  
💼 [your LinkedIn URL]

