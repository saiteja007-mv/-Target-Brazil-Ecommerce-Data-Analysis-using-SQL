# 🎯 Target Brazil E-commerce Data Analysis

## 📌 Overview
This project conducts a comprehensive SQL analysis on e-commerce data from **Target Brazil (2016-2018)**. The goal is to extract meaningful insights to guide **strategic business decisions**, including:
- 🌍 **Regional expansion**
- 🚚 **Shipping optimization**
- 💳 **Payment method analysis**
- 🛍 **Customer retention strategies**

The entire analysis is performed using **Google BigQuery**.

## 🔗 Project Links
- **BigQuery Dataset:** [🔍 View Here](https://console.cloud.google.com/bigquery?sq=483953523449:7eb3d8240c42416994d1c95261f42ec6)
- **Datasets:** [📂 Google Drive Link](https://drive.google.com/drive/folders/1HfI23iU1HPjeMz3YcSpfL5g1l39Sn1JK?usp=sharing)

## 📊 Data Description
The dataset consists of **100,000+ orders** placed in Brazil from **2016 to 2018**, covering:
- 👥 **Customers & Sellers**
- 📦 **Order details & items**
- 🌎 **Geolocation data**
- 💰 **Payment information**
- 🏷 **Product attributes**
- ⭐ **Customer reviews**

### 📑 Datasets
The data is stored in **8 CSV files:**
1. 🛒 `customers.csv` - Customer details (location, ID, etc.)
2. 🏪 `sellers.csv` - Seller information
3. 📋 `order_items.csv` - Order details (items, price, shipping, etc.)
4. 🌍 `geolocation.csv` - Customer & seller location data
5. 💳 `payments.csv` - Payment details (type, value, installments, etc.)
6. ✍️ `reviews.csv` - Customer feedback & ratings
7. 📦 `orders.csv` - Order timestamps & statuses
8. 📜 `products.csv` - Product descriptions, weight, dimensions, etc.

## 🔍 Analysis & Insights
The SQL analysis leverages **advanced querying techniques** such as:
- 📌 **Window functions**
- 📌 **Common Table Expressions (CTEs)**
- 📌 **Complex Joins**

### 📈 Key Findings:
#### 1️⃣ **E-commerce Trends**
- 📈 Orders **grew steadily** from 2016 to 2018.
- 🎯 **Peak order months**: May, July, and August.
- ⏳ Most orders are placed **in the Afternoon (13:00 - 18:00 hrs)**.

#### 2️⃣ **Regional Order Trends**
- 🏙 **High customer density:** Minas Gerais (MG) & Rio de Janeiro (RJ).
- 🌍 **Low customer density:** Roraima (RR) & Amapá (AP) - potential for targeted marketing.

#### 3️⃣ **Economic Impact & Spending Patterns**
- 💰 **Order costs increased by 20%** (2017-2018, Jan-Aug).
- 🏆 **Top spending states:** São Paulo (SP), Minas Gerais (MG), Paraná (PR).
- 🎯 **Identified top 10 highest-spending customers** for loyalty programs.

#### 4️⃣ **Shipping & Delivery Optimization**
- 🚛 **Longest delivery times:** Roraima (RR), Amapá (AP), Amazonas (AM) (>23 days avg.)
- 🚀 **Fastest deliveries:** São Paulo (SP), Paraná (PR), Minas Gerais (MG) (<15 days avg.)
- 💲 **Highest freight costs:** Paraíba (PB), Acre (AC), Rondônia (RO).

#### 5️⃣ **Payment Trends**
- 💳 **Credit Cards dominate** across all years.
- 🎟 **Voucher usage is declining** from 2017 onwards.
- 🔄 Orders with **1-10 installments** are most common; very few use >10 installments.

## 🛠 Technologies Used
- 💾 **SQL** (Google BigQuery Legacy SQL)
- ☁️ **Google BigQuery** (Cloud-based Data Analysis)
- 📊 **Data Visualization** (Tableau, Google Data Studio)

## 📂 Key Files
- 📝 `SQL Target Data Analysis.sql` - Contains **50+ SQL queries** used in the project.
- 📑 `Target SQL Business Case.pdf` - **Visual summary** of insights & trends.
- 📘 `Project Target SQL Description.pdf` - Detailed project **description & objectives**.

## 🚀 Future Work
- 🏎 **Enhance Delivery Optimization:** Reduce delivery times in delayed regions.
- 💳 **Improve Payment Strategies:** Address declining voucher usage, promote installment-based purchases.
- 🌍 **Regional Expansion:** Identify opportunities in states with fewer customers.
- 🎯 **Personalized Marketing:** Use customer spending insights for targeted campaigns.

## 📬 Contact
For questions, feedback, or collaboration opportunities, feel free to reach out:
- 🔗 **LinkedIn:** [Venkata Sai Teja Mothukuri](https://www.linkedin.com/in/venkata-sai-teja-mothukuri-b30063199/)

---
📊 *This project showcases data-driven decision-making for e-commerce growth and optimization using SQL & BigQuery.* 🚀

