##🛒 E-Commerce Sales Performance Analysis

A complete end-to-end data analytics project analyzing Indian e-commerce sales data using **Excel**, **MySQL** and **Power BI**.

---

## 📌 Project Overview

This project simulates a real-world business scenario where an e-commerce company wants to understand its sales performance, identify top performing categories and platforms, analyze regional trends and reduce return rates.

The analysis covers **5,500 orders** across **2 years (2023–2024)** from major Indian e-commerce platforms like Amazon, Flipkart, Meesho, Myntra, Nykaa and BigBasket.

---

## 🎯 Business Questions Answered

- Which product category generates the most revenue?
- Which platform drives the highest number of orders?
- Which month has the highest sales volume?
- Which region outperforms others in revenue?
- Which category has the highest return rate and why?

---

## 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| Microsoft Excel | Data cleaning, validation, helper columns |
| MySQL Workbench | Data transformation and analysis (12 SQL queries) |
| Power BI Desktop | Interactive dashboard and DAX measures |

---

## 📂 Project Structure

```
ecommerce-sales-analysis/
│
├── data/
│   └── ecommerce_sales_data.xlsx       # Raw dataset (5,500 rows)
│
├── sql/
│   └── analysis_queries.sql            # All 12 SQL queries
│
├── powerbi/
│   └── ecommerce_dashboard.pbix        # Power BI dashboard file
│
├── insights/
│   └── business_insights.md            # Key findings and recommendations
│
└── README.md
```

---

## 🧹 Data Cleaning (Excel)

- Verified **zero duplicate** Order IDs across 5,500 rows
- Validated data types — dates, decimals, integers
- Confirmed **4,942 blank Return Reasons** are intentional (non-returned orders)
- Confirmed **~750 blank Customer Ratings** are intentional (non-delivered orders)
- Added **Delivery Days** helper column = Delivery Date − Order Date

---

## 🗄️ SQL Analysis (MySQL)

12 queries covering a range of SQL concepts:

| # | Query | Concept |
|---|-------|---------|
| 1 | Total Revenue, Profit & Orders | Aggregation |
| 2 | Revenue by Category | GROUP BY |
| 3 | Revenue by Platform | GROUP BY |
| 4 | Monthly Revenue Trend | STR_TO_DATE |
| 5 | Top 5 Cities by Revenue | LIMIT |
| 6 | Return Rate by Category | CASE WHEN |
| 7 | Customer Segment Performance | GROUP BY |
| 8 | Top 5 Most Profitable Products | ORDER BY |
| 9 | Running Total Revenue by Month | Window Function |
| 10 | Payment Method Analysis | AVG |
| 11 | Categories Above Average Return Rate | CTE + CROSS JOIN |
| 12 | Top City per Region | CTE + INNER JOIN |

---

## 📊 Power BI Dashboard

**5 DAX Measures:**
- Total Revenue
- Total Profit
- Profit Margin %
- Total Orders
- Return Rate %

**6 Visuals:**
- KPI Cards (Revenue, Profit, Orders, Margin, Return Rate)
- Revenue by Category (Bar Chart)
- Monthly Revenue Trend (Line Chart)
- Revenue by Platform (Donut Chart)
- Revenue by Region (Column Chart)
- Order Status Breakdown (Donut Chart)

**2 Interactive Slicers:** Year, Platform

---

## 💡 Key Business Insights

**1. Electronics Dominates Revenue**
Electronics is the highest revenue generating category. However it also has the highest return rate — the business should improve product descriptions and quality checks to reduce returns.

**2. Amazon Leads in Orders**
Amazon is the top performing platform by order volume. The business should prioritize Amazon listings and promotions to maximize reach.

**3. July is Peak Sales Month**
Sales peaked in July indicating a strong mid-year demand spike. The business should stock up inventory and run targeted campaigns before July every year.

**4. South Region Outperforms All Regions**
The South region generates the highest revenue driven by tech savvy high income cities like Bangalore, Chennai and Hyderabad.

**5. Electronics Has Highest Return Rate**
Despite being the top revenue category, Electronics leads in returns — a profitability risk that needs immediate attention through better quality control and buyer guidance.

---

## 📈 Dataset Details

| Feature | Detail |
|---------|--------|
| Total Rows | 5,500 |
| Time Period | Jan 2023 — Dec 2024 |
| Categories | 8 (Electronics, Clothing, Home & Kitchen, etc.) |
| Platforms | 6 (Amazon, Flipkart, Meesho, Myntra, Nykaa, BigBasket) |
| Regions | 5 (North, South, East, West, Central) |
| Cities | 25 Indian cities |
| Currency | Indian Rupee (₹) |

---

## 👤 Author

**Ashutosh**
Aspiring Data Analyst | Excel • SQL • Power BI
