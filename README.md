# Delivery Performance Analysis — SQL Case Study

## Overview
This project analyzes end-to-end delivery performance across multiple lanes (seller state → customer state) to identify the root causes of late deliveries in an e-commerce network.  
The objective is to determine whether delays originate from seller handling or courier transit, and to provide operations teams with actionable insights for improvement.

The analysis is fully implemented in **SQL**, organized into sequential steps, and designed for visualization in **Power BI**.

---

## Objectives
- Build a unified and reusable “delivery facts” base table.  
- Evaluate delivery performance by route.  
- Identify sellers responsible for pre-shipment delays.  
- Diagnose whether lateness is handling or transit driven.  
- Pinpoint high-impact seller × lane combinations responsible for most delays.  

---

## Data Sources
The analysis combines data from multiple relational tables:
- `olist_orders` – order-level information and timestamps  
- `olist_order_items` – mapping of items to sellers  
- `olist_customers` – customer details and regions  
- `olist_sellers` – seller details and locations  

These tables were merged to form a consistent base for performance analytics.

---

## Project Structure

### Task 1 — Delivery Facts Base
Created a view `v_delivery_facts_plus` with one row per order × seller, containing:
- Key timestamps (approval, shipment, delivery, promised date)  
- Calculated durations (handling days, transit days, lead time, lateness)  

This base standardizes all downstream analysis.

---

### Task 2 — Lane Performance
Analyzed performance by **seller_state → customer_state** lane to identify the slowest routes.  
Computed:
- On-time rate and average lead time  
- Median handling and transit times for diagnosis  
- Volume thresholds to exclude low-traffic lanes  

Created a reusable view `v_lane_performance` for continuous monitoring.

---

### Task 3 — Slow-Handling Sellers
Ranked sellers by their median handling time.  
Identified those consistently delaying before shipment and compared against median transit times to distinguish seller vs courier-related issues.

---

### Task 4 — Diagnose Lateness (Handling vs Transit)
Used lane-specific 75th percentile thresholds to determine whether each late delivery was:
- **Handling-driven:** seller delay before handoff  
- **Transit-driven:** courier delay during transport  

Aggregated results into a `primary_driver` classification for each lane.  
This provides a clear operational recommendation — whether to coach sellers or coordinate with logistics partners.

---

### Task 5 — Hot Spots (Seller × Lane Pairs)
Focused on the highest-impact problem areas by analyzing seller × lane pairs.  
Highlighted combinations with:
- High order volume  
- High late rate  
- Median handling and transit times for context  

These form the “call-first” list for daily operations reviews.

---
