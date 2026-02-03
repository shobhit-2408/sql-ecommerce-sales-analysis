# 🛒 SQL E-Commerce Sales Performance Analysis

## 📌 Project Goal
The objective of this project is to **analyze e-commerce sales performance** across products, customers, and regions using **SQL**, and to present actionable insights through a **Power BI dashboard**.

This project focuses on understanding:
- Revenue trends
- Customer behavior
- Product performance
- Regional performance
- Returns and refunds

---

## 🗂 Database Schema Overview
The analysis is based on an e-commerce database consisting of **5 tables**:

- **Customers**
- **Products**
- **Orders**
- **OrderDetails**
- **Regions**

An ERD diagram is included in this repository for reference.

---

## 🧠 Business Questions Answered

### 🔹 General Sales Insights
- What is the **total revenue** generated over the entire period?
- What is the **revenue excluding returned orders**?
- What is the **total revenue per year and per month**?
- What is the **revenue by product and category**?
- What is the **average order value (AOV)** across all orders?
- How does **AOV change by year and month**?
- What is the **average order size by region**?

---

### 🔹 Customer Insights
- Who are the **top 10 customers by total revenue spent**?
- What is the **repeat customer rate**?
- What is the **average time between two consecutive orders** for the same customer (region-wise)?
- How are customers segmented based on total spend?
  - **Platinum:** Total Spend > 1500  
  - **Gold:** 1000 – 1500  
  - **Silver:** 500 – 999  
  - **Bronze:** < 500
- What is the **Customer Lifetime Value (CLV)**?

---

### 🔹 Product & Order Insights
- What are the **top 10 most sold products by quantity**?
- What are the **top 10 most sold products by revenue**?
- Which products have the **highest return rate**?
- What is the **return rate by product category**?
- What is the **average price of products per region**?
- What is the **sales trend for each product category**?

---

### 🔹 Temporal Trends
- What are the **monthly sales trends** over the past year?
- How does **AOV change by month or week**?

---

### 🔹 Regional Insights
- Which regions have the **highest and lowest order volumes**?
- What is the **revenue per region**, and how do regions compare?

---

### 🔹 Return & Refund Insights
- What is the **overall return rate by product category**?
- What is the **overall return rate by region**?
- Which customers are making **frequent returns**?

---

## 📊 Dashboard Overview
The Power BI dashboard provides:
- Sales & Revenue KPIs
- Sales & Revenue Over Time
- Sales by Region (Map)
- Top Performing Products
- Customer Insights & Segmentation
- Customer Repeat Rate Trend
- Return & Refund Analysis

The dashboard follows a **clean, card-based design** with consistent colors and business-friendly visuals.

---

## 📂 Project Structure
SQL-Ecommerce-Project/
│
├── Dashboard Data/
│ └── CSV files exported from SQL queries
│
├── Database and Tables/
│ └── SQL scripts (schema & analysis queries)
│
├── Insights/
│ └── Business insights and interpretations
│
├── Dashboard.pbix
├── Dashboard.pdf
├── ERD.png
└── README.md


---

## 🧾 Data Workflow
1. Data queried and analyzed using **SQL**
2. Query results exported as **CSV files**
3. CSV files imported into **Power BI**
4. **DAX measures** created for KPIs and trends
5. Insights visualized through an interactive dashboard

---

## 🚀 How to Use This Project
1. Clone the repository
2. Review SQL queries in **Database and Tables/**
3. Open `Dashboard.pbix` in **Power BI Desktop**
4. Explore visuals, filters, and insights

---

## 🔗 Live Dashboard Access
Due to tenant restrictions, public embedding of Power BI reports is disabled.

However, the complete interactive dashboard is available in:
- `Dashboard.pbix` (open in Power BI Desktop)
- `Dashboard.pdf` (static preview)

This ensures full transparency and reproducibility.

---

## 👤 Author
**Shobhit Sharma**  

---

⭐ If you find this project useful, feel free to give it a star!
