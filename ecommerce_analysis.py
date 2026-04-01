import psycopg2
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker
import seaborn as sns

# ── Conexión a PostgreSQL ──────────────────────────────────────────
conn = psycopg2.connect(
    host="localhost",
    port=5432,
    database="ecommerce",
    user="postgres",
    password="Siseseva11092002*"  # <- pon tu contraseña aquí
)

# ── Estilo general ─────────────────────────────────────────────────
plt.rcParams['figure.facecolor'] = '#0d1117'
plt.rcParams['axes.facecolor']   = '#161b22'
plt.rcParams['axes.edgecolor']   = '#30363d'
plt.rcParams['text.color']       = '#e6edf3'
plt.rcParams['axes.labelcolor']  = '#e6edf3'
plt.rcParams['xtick.color']      = '#8b949e'
plt.rcParams['ytick.color']      = '#8b949e'
plt.rcParams['grid.color']       = '#21262d'
plt.rcParams['font.family']      = 'sans-serif'

COLORS = ['#2ea043', '#388bfd', '#f78166', '#d2a8ff', '#ffa657']

# ══════════════════════════════════════════════════════════════════
# GRÁFICO 1 — Monthly Revenue Trend
# ══════════════════════════════════════════════════════════════════
query1 = """
    SELECT 
        DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
        ROUND(SUM(op.payment_value)::numeric, 2)         AS revenue
    FROM orders o
    JOIN order_payments op ON o.order_id = op.order_id
    WHERE o.order_purchase_timestamp IS NOT NULL
    AND DATE_TRUNC('month', o.order_purchase_timestamp) 
        NOT IN ('2018-09-01', '2018-10-01')
    GROUP BY 1 ORDER BY 1
"""
df1 = pd.read_sql(query1, conn)
df1['month'] = pd.to_datetime(df1['month'])

fig, ax = plt.subplots(figsize=(14, 6))
ax.fill_between(df1['month'], df1['revenue'], alpha=0.3, color=COLORS[0])
ax.plot(df1['month'], df1['revenue'], color=COLORS[0], linewidth=2.5, marker='o', markersize=5)
ax.axvline(pd.Timestamp('2017-11-01'), color=COLORS[2], linestyle='--', alpha=0.7, label='Black Friday 2017')
ax.yaxis.set_major_formatter(mticker.FuncFormatter(lambda x, _: f'${x/1e6:.1f}M'))
ax.set_title('Monthly Revenue Trend — Olist E-Commerce (2016–2018)', fontsize=15, fontweight='bold', pad=15)
ax.set_xlabel('Month')
ax.set_ylabel('Revenue (USD)')
ax.legend()
ax.grid(True, alpha=0.4)
plt.tight_layout()
plt.savefig(r'C:\ecommerce\chart_01_monthly_revenue.png', dpi=150, bbox_inches='tight')
plt.show()
print('✅ Gráfico 1 guardado')

# ══════════════════════════════════════════════════════════════════
# GRÁFICO 2 — Revenue by Payment Method
# ══════════════════════════════════════════════════════════════════
query2 = """
    SELECT payment_type,
           ROUND(SUM(payment_value)::numeric, 2) AS revenue
    FROM order_payments
    WHERE payment_value > 0
    GROUP BY payment_type
    ORDER BY revenue DESC
"""
df2 = pd.read_sql(query2, conn)
df2['payment_type'] = df2['payment_type'].str.replace('_', ' ').str.title()

fig, ax = plt.subplots(figsize=(8, 8))
wedges, texts, autotexts = ax.pie(
    df2['revenue'], labels=df2['payment_type'],
    autopct='%1.1f%%', colors=COLORS,
    startangle=90, pctdistance=0.75,
    wedgeprops=dict(width=0.5)
)
for t in autotexts:
    t.set_color('white')
    t.set_fontsize(12)
ax.set_title('Revenue Share by Payment Method', fontsize=14, fontweight='bold', pad=20)
plt.tight_layout()
plt.savefig(r'C:\ecommerce\chart_02_payment_methods.png', dpi=150, bbox_inches='tight')
plt.show()
print('✅ Gráfico 2 guardado')

# ══════════════════════════════════════════════════════════════════
# GRÁFICO 3 — Top 10 Categories by Revenue
# ══════════════════════════════════════════════════════════════════
query3 = """
    SELECT ct.product_category_name_english AS category,
           ROUND(SUM(oi.price)::numeric, 2)  AS revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    JOIN category_translation ct ON p.product_category_name = ct.product_category_name
    GROUP BY 1 ORDER BY revenue DESC LIMIT 10
"""
df3 = pd.read_sql(query3, conn)
df3['category'] = df3['category'].str.replace('_', ' ').str.title()

fig, ax = plt.subplots(figsize=(12, 7))
bars = ax.barh(df3['category'][::-1], df3['revenue'][::-1], color=COLORS[1], alpha=0.85)
for bar, val in zip(bars, df3['revenue'][::-1]):
    ax.text(bar.get_width() + 30000, bar.get_y() + bar.get_height()/2,
            f'${val/1e6:.2f}M', va='center', fontsize=10, color='#e6edf3')
ax.xaxis.set_major_formatter(mticker.FuncFormatter(lambda x, _: f'${x/1e6:.1f}M'))
ax.set_title('Top 10 Product Categories by Revenue', fontsize=14, fontweight='bold', pad=15)
ax.set_xlabel('Total Revenue (USD)')
ax.grid(True, axis='x', alpha=0.4)
plt.tight_layout()
plt.savefig(r'C:\ecommerce\chart_03_top_categories.png', dpi=150, bbox_inches='tight')
plt.show()
print('✅ Gráfico 3 guardado')

# ══════════════════════════════════════════════════════════════════
# GRÁFICO 4 — Delivery Time vs Review Score
# ══════════════════════════════════════════════════════════════════
query4 = """
    SELECT
        ROUND(AVG(EXTRACT(DAY FROM (o.order_delivered_customer_date - 
              o.order_purchase_timestamp)))::numeric, 1) AS avg_days,
        r.review_score
    FROM orders o
    JOIN order_reviews r ON o.order_id = r.order_id
    WHERE o.order_delivered_customer_date IS NOT NULL
    GROUP BY r.review_score
    ORDER BY r.review_score
"""
df4 = pd.read_sql(query4, conn)

fig, ax = plt.subplots(figsize=(9, 6))
bars = ax.bar(df4['review_score'], df4['avg_days'],
              color=[COLORS[2] if d > 15 else COLORS[0] for d in df4['avg_days']],
              width=0.6, alpha=0.85)
for bar, val in zip(bars, df4['avg_days']):
    ax.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 0.3,
            f'{val} days', ha='center', fontsize=11, color='#e6edf3')
ax.set_xticks([1, 2, 3, 4, 5])
ax.set_xticklabels(['⭐ 1', '⭐⭐ 2', '⭐⭐⭐ 3', '⭐⭐⭐⭐ 4', '⭐⭐⭐⭐⭐ 5'])
ax.set_title('Average Delivery Time by Review Score', fontsize=14, fontweight='bold', pad=15)
ax.set_xlabel('Customer Review Score')
ax.set_ylabel('Avg Delivery Days')
ax.grid(True, axis='y', alpha=0.4)
plt.tight_layout()
plt.savefig(r'C:\ecommerce\chart_04_delivery_vs_review.png', dpi=150, bbox_inches='tight')
plt.show()
print('✅ Gráfico 4 guardado')

# ══════════════════════════════════════════════════════════════════
# GRÁFICO 5 — Customer Concentration by State
# ══════════════════════════════════════════════════════════════════
query5 = """
    SELECT customer_state,
           COUNT(DISTINCT customer_id) AS customers
    FROM customers
    GROUP BY customer_state
    ORDER BY customers DESC
    LIMIT 10
"""
df5 = pd.read_sql(query5, conn)

fig, ax = plt.subplots(figsize=(11, 6))
bars = ax.bar(df5['customer_state'], df5['customers'], color=COLORS[3], alpha=0.85)
for bar, val in zip(bars, df5['customers']):
    ax.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 200,
            f'{val:,}', ha='center', fontsize=10, color='#e6edf3')
ax.set_title('Top 10 States by Customer Concentration', fontsize=14, fontweight='bold', pad=15)
ax.set_xlabel('State')
ax.set_ylabel('Number of Customers')
ax.grid(True, axis='y', alpha=0.4)
plt.tight_layout()
plt.savefig(r'C:\ecommerce\chart_05_customer_by_state.png', dpi=150, bbox_inches='tight')
plt.show()
print('✅ Gráfico 5 guardado')

conn.close()
print('\n🎉 Todos los gráficos generados exitosamente')
