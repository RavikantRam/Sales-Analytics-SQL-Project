# 📊 Sales Analytics SQL Project

## 📌 Project Overview
This project focuses on performing data cleaning, transformation, and business analysis using PostgreSQL.  
The dataset used is the Superstore sales dataset, which contains order, customer, product, and profit details.

The goal of this project is to extract meaningful business insights using SQL queries and optimize performance using indexing.

---

## 🛠️ Tools & Technologies Used
- PostgreSQL
- SQL
- Git & GitHub
- pgAdmin

---

## 📂 Dataset
Dataset: Superstore Sales Dataset

Contains information about:
- Orders
- Customers
- Products
- Sales & Profit
- Regions & Categories

---

## 🔄 Data Processing Steps

### 1️⃣ Raw Data Import
- Imported CSV dataset into PostgreSQL
- Stored raw data in `sales_raw` table
- All columns initially stored as TEXT

---

### 2️⃣ Data Cleaning & Transformation
Created cleaned table `sales` with proper data types:

- Converted date fields using `TO_DATE()`
- Converted numeric fields using type casting
- Removed inconsistent data formatting

---

### 3️⃣ Database Structure
Created structured sales table with:

- Order details
- Customer details
- Product details
- Financial metrics

---

## 📊 Business Analysis Queries

### ✔ Sales & Profit Analysis
- Total Sales
- Total Profit
- Average Profit Per Order
- Highest & Lowest Sales

---

### ✔ Category & Region Analysis
- Sales by Region
- Profit by Category
- Discount Analysis by Category
- Quantity sold per Region

---

### ✔ Customer Insights
- Top Customers by Spending
- Average Purchase Value per Customer
- Customer Count by Segment

---

### ✔ Time-Based Analysis
- Monthly Sales Trend
- Sales Performance Over Time

---

## ⚡ Performance Optimization
Created indexes to improve query speed:

- Index on Order Date
- Index on Region
- Index on Product Name

Used `EXPLAIN ANALYZE` to evaluate query performance.

---

## 📈 Sample Query
```sql
SELECT region, SUM(sales) AS total_sales
FROM sales
GROUP BY region
ORDER BY total_sales DESC;
