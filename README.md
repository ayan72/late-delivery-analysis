# SQL Root Cause Analysis - Delivery Performance 

## 1. Executive Summary

This project analyzes e-commerce delivery performance across multiple lanes (seller state → customer state) to uncover the root causes of late deliveries.
Using SQL, the analysis identifies whether delays stem from seller handling or courier transit and provides actionable insights for operations improvement.
The SQL outputs are designed for Power BI visualization to support real-time performance tracking.

---

## 2. Business Problem

Late deliveries negatively impact customer satisfaction and operational efficiency.
The challenge is to determine where delays occur before shipment (handling) or during transit, and to identify which sellers or routes contribute most to late orders.
This helps teams focus on targeted interventions and SLA optimization.

---

## 3. Methodology

### Data Preparation

- Combined order, item, seller, and customer data into a unified base table (v_delivery_facts_plus).

### Lane Analysis

- Calculated on-time rate, handling, and transit times per lane to identify slow routes.

### Seller Diagnosis

- Ranked sellers by median handling time to isolate pre-shipment delays.

### Root Cause Classification

- Used lane-specific thresholds to tag each delay as handling-driven or transit-driven.

### Hotspot Detection

- Highlighted high-impact seller × lane combinations for operational focus.

---

## 4. Skills

### SQL
- CTEs, joins, window functions, and views


### ETL

- Combined multiple raw tables through SQL transformations to create a clean, analytics-ready dataset.


### Root Cause Analysis

- Used SQL-driven metrics to isolate whether lateness was handling or transit driven for each lane.

---

## 5. Results and Business Recommendations

- **Lane SP → RJ** is *handling-driven* — 62% of late orders are due to seller-side delays before shipment.  
- **Lane MG → BA** is *transit-driven* — 70% of late orders are caused by courier-side transit delays.  
- **Seller S123 on SP → BA** has a **28% late rate**; median handling time is **2.6 days** vs **1.1 days transit**, indicating a seller-side process issue.


### Recommendations

-Coach sellers with high handling times to improve pre-shipment processes.

-Coordinate with logistics teams on lanes with frequent transit delays.

-Prioritize top seller × lane hotspots for immediate operational review.

---

## 6. Next Steps

### Build the Power BI Dashboard
Leverage the SQL outputs created in this project to design a Power BI dashboard that transforms the analysis into clear, visual insights for business and operations teams.

This dashboard will enable stakeholders to explore results interactively and identify performance bottlenecks across the delivery network.

---

### 2. Prepare an In-Depth Analytical Report
Once the Power BI dashboard is complete, create a detailed report summarizing the key findings and insights derived from the analysis.

**Report Deliverables:**
- **Executive Summary:** Overall delivery performance and late rate overview.  
- **Root Cause Analysis:** Breakdown of lateness by handling vs. transit drivers.  
- **Regional and Seller Trends:** Insights into state-to-state performance and slow-handling sellers.  
- **Operational Recommendations:**  
  - Coach specific sellers with high handling times.  
  - Address courier routes with consistent transit delays.  
  - Adjust SLAs or routing for high-risk lanes.  

---

### 4. Future Enhancements
- Incorporate additional data sources such as courier performance metrics or weather conditions.  
- Add predictive analytics to forecast potential late deliveries using historical patterns.  
