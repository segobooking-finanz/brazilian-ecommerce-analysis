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
📧 email  
💼 Link

## Key Findings
### 📈 Month over Month Growth
- **November 2017 showed +53% growth** — directly correlated with 
  Black Friday and Cyber Monday, confirming strong seasonal demand
- **December consistently drops** after November peak (-26% in 2017), 
  suggesting customers pull forward purchases to Black Friday
- By 2018, monthly revenue **stabilized between $1M-$1.16M**, 
  indicating business maturity and predictable demand
- **September-October 2018 show near-zero values** — this reflects 
  dataset cutoff, not actual business decline

### 🛍️ Top Product Categories
- **Health & Beauty leads** with $5,034,725 in revenue (9.39% share) 
  across 8,836 orders
- **Watches & Gifts** has the highest average price ($201.14), 
  indicating a premium customer segment
- **Bed, Bath & Table** drives the most orders (9,417) with lower 
  average price ($93.30) — high volume, lower margin category
- Top 10 categories represent approximately **62% of total revenue**

### 🏪 Top Sellers
- Top seller (Guariba, SP) generated **$229,472** from 1,132 orders 
  at $198 average — high volume strategy
- Second seller (Lauro de Freitas, BA) generated **$222,776** from 
  only 358 orders at **$543 average** — premium product strategy
- **São Paulo dominates** the seller base, with multiple top-10 
  sellers operating from SP state

### 🗺️ Geographic Distribution
- **São Paulo concentrates 41.98% of all customers** — nearly 1 in 
  2 customers is from SP
- The top 3 states (SP, RJ, MG) account for **66.6% of the customer base**
- Southern and southeastern Brazil dominates e-commerce activity
- **Opportunity:** States like BA, DF, ES and GO show emerging demand 
  with significant growth potential

### 🚚 Delivery Performance & Customer Satisfaction
- **Delivery time directly correlates with review scores** — a near-perfect 
  linear relationship:
  - 5 stars → avg **10.2 days** delivery
  - 4 stars → avg **11.8 days** delivery  
  - 3 stars → avg **13.8 days** delivery
  - 2 stars → avg **16.2 days** delivery
  - 1 star  → avg **20.8 days** delivery
- Every additional 2.5 days of delivery time costs approximately **1 star** 
  in customer satisfaction
- **On-time deliveries (92% of orders)** average a 4.29 review score 
  and generate **$14,045,369** in revenue
- **Late deliveries (8% of orders)** drop to a 2.56 average score, 
  putting **$1,317,922** in revenue at risk of churn

### 💡 Key Business Recommendations
1. **Reduce delivery time below 10 days** — the single most impactful 
   lever for improving customer satisfaction
2. **Double down on credit card experience** — 78% of revenue depends 
   on it. Any friction directly impacts the bottom line
3. **Promote installment options** — customers respond to flexible 
   payments. Offering 3-6 installments could increase average order value
4. **Plan for November** — Black Friday drives +53% MoM growth. 
   Inventory and logistics must scale accordingly
5. **Expand beyond São Paulo** — SP concentrates 42% of customers 
   but states like BA, GO and DF show emerging demand worth targeting
6. **Focus on Health & Beauty and Watches** — top revenue categories 
   with strong margins and consistent demand

## Category & Product Analysis

### 🏆 Top Categories Deep Dive
- **Health & Beauty leads** with $5,034,725 across 8,836 orders and 
  2,444 unique products — the most diverse category
- **Watches & Gifts** has the highest average price ($201.14) with 
  only 1,329 unique products — fewer SKUs but premium positioning
- **Computers** has the highest average price of all ($1,098) but 
  only 181 orders — ultra-premium, niche segment
- **Small Appliances Home** averages $624 per item — second highest 
  avg price, low volume but high margin potential

### 📦 Freight Efficiency
- **Home Comfort, Flowers and Furniture** have the worst freight-to-price 
  ratios (54%, 44%, 37%) — shipping costs eat into margins significantly
- **Electronics** has a 29% freight ratio across 11,068 items — high 
  volume makes logistics optimization critical for this category
- Categories like **Health & Beauty and Watches** have low freight 
  ratios, making them the most profitable to ship

### ⭐ Customer Satisfaction by Category
- **Books** (general and technical) lead satisfaction with 4.45 and 
  4.37 scores — digital-friendly, lightweight, easy to ship
- **Food & Drink and Luggage** score above 4.30 — consistent, 
  predictable products with clear customer expectations
- High-revenue categories like **Health & Beauty and Watches** score 
  around 4.0-4.1 — room for improvement despite strong sales

### 🏪 Seller Tier Analysis
- Only **18 Platinum sellers** (>$100K revenue) generate $2,683,686 
  combined — avg $149K each with 4.04 review score
- **21 Gold sellers** ($50K-$100K) average $60K with the best review 
  score of all tiers: **4.14** — the sweet spot of volume and quality
- **2,801 Bronze sellers** each average only $1,635 in revenue — 
  the long tail that collectively generates $4,582,342
- **Key insight:** Gold sellers outperform Platinum in satisfaction 
  (4.14 vs 4.04), suggesting larger sellers sacrifice service quality 
  for volume

### 📈 Category Trends Over Time
- **Health & Beauty** grew from $539 in Sep 2016 to **$483,215 in 
  Aug 2018** — 895x growth, consistently in top 3
- **Watches & Gifts** surged to **$495,490 in May 2018** — highest 
  single-month category revenue in the dataset
- **November 2017 Black Friday effect** visible across all categories:
  - Watches & Gifts: $390,898 (+48% vs October)
  - Bed, Bath & Table: $357,650 (+93% vs October)
  - Computers & Accessories: $290,624 (+65% vs October)
- By mid-2018, **Health & Beauty and Watches & Gifts** alternate 
  leadership — signaling a maturing, competitive market

## Customer & Geographic Analysis

### 🔄 Customer Retention
- **96.88% of customers buy only once** — classic e-commerce challenge
- Only **2.86% return for a second purchase** and 0.21% for a third
- This signals a massive **retention opportunity** — even moving 5% of 
  one-time buyers to repeat customers would significantly impact revenue
- Recommendation: implement loyalty programs and post-purchase email 
  campaigns targeting the 93,099 one-time buyers

### 🗺️ Revenue by State
- **São Paulo generates 37.47% of total revenue** ($5,998,226) — 
  nearly 4x the second state
- **Rio de Janeiro** is second with 13.39% but has the highest avg 
  order value among top states ($158.53)
- **Bahia** has the highest avg order value in top 10 ($170.82) — 
  premium buyers despite lower volume
- Top 3 states (SP, RJ, MG) = **62.56% of total revenue**

### 🏙️ High-Value Cities
- **Divinópolis MG** leads avg order value at $276 — surprisingly 
  outperforming São Paulo ($137) despite being a smaller city
- **Porto Velho RO** averages $245 — northern Brazil shows premium 
  purchasing behavior, likely due to higher shipping costs inflating totals
- **João Pessoa PB** and **Belém PA** both exceed $200 avg — 
  underserved northeastern markets with strong purchasing power
- São Paulo city despite massive volume has relatively low avg order 
  value ($137) — high volume, competitive, price-sensitive market

### 📅 Customer Acquisition
- **November 2017: 7,430 new customers** — biggest acquisition month, 
  driven by Black Friday
- **January 2018: 7,166 customers** — strong post-holiday recovery
- Growth from 3 customers (Sep 2016) to 7,000+ monthly by 2018 
  represents extraordinary platform scaling

### 📦 Order Status
- **97.02% of orders are successfully delivered** — excellent 
  operational performance
- Only **0.63% canceled** — very low cancellation rate signals 
  strong customer intent and clear product listings
- **1.11% still shipped** — in-transit orders at dataset cutoff

### 💎 High Value Customers
- Top customer spent **$13,664** in a single order from Rio de Janeiro
- Most VIP customers are **one-time buyers** of high-value items — 
  likely electronics or furniture
- **Florianópolis customer** spent $9,553 across 3 orders — 
  the ideal repeat high-value profile
- VIP customers are geographically diverse — opportunity for 
  targeted premium campaigns nationwide

### 🚚 Delivery Time by State
- **São Paulo receives orders in 8.3 days** — fastest in Brazil, 
  explains its dominance in customer satisfaction (4.25 score)
- **Paraná and Minas Gerais** at 11.5 days — still strong performance
- **Amapá (26.7 days) and Roraima (29 days)** — remote northern states 
  wait nearly 3x longer than SP customers
- **Direct correlation confirmed:** states with faster delivery 
  consistently score above 4.0 in reviews
- **Maranhão and Alagoas** (20+ days, ~3.84 score) represent the 
  biggest service gap — underserved markets with poor delivery 
  infrastructure but real purchasing demand

## Delivery & Operations Analysis

### 🚚 Overall Delivery Performance
- Average actual delivery time: **12.1 days**
- Average estimated delivery time: **23.4 days**
- **Olist overestimates delivery by 11 days on average** — they 
  underpromise and overdeliver, which explains the high satisfaction
- **91.89% on-time rate** — industry-leading operational performance

### 📅 Monthly Delivery Trends
- Delivery times improved dramatically: from **19.1 days (Oct 2016)** 
  to **7.3 days (Aug 2018)** — a 62% improvement in logistics efficiency
- **November-December 2017** saw delivery spike to 14-15 days — 
  Black Friday volume overwhelmed logistics capacity
- **Feb-Mar 2018** peaked at 16.5 days — likely post-holiday backlog
- By mid-2018, delivery times dropped below 9 days consistently — 
  sign of mature, optimized logistics network

### ⏱️ Delivery Time Distribution & Satisfaction
| Range | Orders | Share | Avg Review |
|-------|--------|-------|------------|
| 0-7 days | 33,685 | 34.96% | ⭐ 4.41 |
| 8-14 days | 36,396 | 37.77% | ⭐ 4.29 |
| 15-21 days | 15,381 | 15.96% | ⭐ 4.10 |
| 22-30 days | 6,865 | 7.12% | ⭐ 3.49 |
| 30+ days | 4,032 | 4.18% | ⭐ 2.18 |

- **72.73% of orders arrive within 14 days** — strong core performance
- Orders taking 30+ days receive catastrophic **2.18 rating** — 
  these 4,032 orders represent a critical churn risk

### ⚙️ Operational Pipeline Breakdown
- **Approval time:** consistently ~3.5 hours — fast payment processing
- **Seller to carrier:** improved from 12.6 days (Oct 2016) to 
  **1.6 days (Aug 2018)** — 87% improvement in seller dispatch speed
- **Carrier to customer:** improved from 8.7 days (Jan 2017) to 
  **4.9 days (Aug 2018)** — last-mile delivery getting faster
- The biggest operational gain came from **seller dispatch time** — 
  suggests Olist implemented seller performance requirements over time

### 🗺️ Late Deliveries by State
- **Alagoas (23.37%)** and **Maranhão (19.13%)** have the worst 
  late delivery rates — northeastern states suffer most
- **São Paulo has only 5.82% late rate** — proximity to distribution 
  centers makes the difference
- **Paraná (4.94%)** and **Amazonas (4.14%)** surprisingly low — 
  despite distance, good carrier coverage
- States with highest late rates (AL, MA, PI, CE) consistently 
  score below 4.0 in reviews — direct operational impact on NPS

### 💰 Revenue Impact by Delivery Speed
| Range | Revenue | Avg Order | Avg Review |
|-------|---------|-----------|------------|
| 0-7 days | $4,730,450 | $134.89 | ⭐ 4.41 |
| 8-14 days | $5,925,438 | $155.30 | ⭐ 4.29 |
| 15-21 days | $2,672,227 | $166.49 | ⭐ 4.10 |
| 22-30 days | $1,233,844 | $172.47 | ⭐ 3.50 |
| 30+ days | $801,331 | $189.89 | ⭐ 2.18 |

- **Counterintuitive finding:** slower deliveries have higher avg 
  order values ($189 for 30+ days vs $134 for 0-7 days)
- This suggests **heavy/large items** (furniture, appliances) 
  naturally take longer to ship AND cost more — not a satisfaction 
  problem with standard products
- **$801,331 in revenue** comes from orders with catastrophic 
  satisfaction scores — high churn risk segment

## Author
**Simón Segovia** | Financial & Data Analyst
