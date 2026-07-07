# MetricStream: Subscription & Viewer Engagement Analytics System

A comprehensive SQL-based database management and analytical system designed for a subscription-based video streaming platform (similar to Netflix or Hotstar). This project focuses on analyzing platform business health, calculating content consumption metrics, tracking data security partitions, and monitoring subscriber churn rates.

## 🚀 System Architecture & Relational Schema

The core relational database schema maps the dependencies between user actions, commercial tiers, and real-time behavioral logs using transactional normalization practices.

1. **Users Table (`Users`)**: Captures registration specifics, geographical location data, and user attribution channels.
2. **Plans Table (`Plans`)**: Configures product packaging metrics, pricing schedules, and multi-device connection limits.
3. **Subscriptions Table (`Subscriptions`)**: Triggers historical status paths (`Active`, `Cancelled`, `Expired`) managing historical user lifecycle footprints.
4. **Usage Logs Table (`Usage_Logs`)**: High-throughput streaming metadata capture engine indexing daily device metrics and streaming durations.

## 📈 Analytical Capabilities & Business Insights

The analytical engine runs a robust diagnostic suite optimized via advanced SQL methodologies (`CTEs`, `Window Functions`, `Set Operations`, and `Subqueries`) to surface critical data layers:

* **Revenue Analysis**: Automatically aggregates Monthly Recurring Revenue (MRR) metrics and partitions dynamic user monetization data across unique geographic locations.
* **Viewer Behavioral Segmentation**: Uses conditional processing strategies to catalog users into explicit platform personas (`Binge Watcher`, `Regular Streamer`, `Low Engagement`) depending on their volume of streaming activity.
* **Platform Churn Lifecycle Management**: Monitors platform churn rates dynamically, measuring the precise average timeline decay (`avg_days_before_churn`) calculated between initial user signup paths and cancellation logs.
* **Concurrency & Cross-Platform Metrics**: Executes cross-join intersection tests targeting specific cross-device activities (e.g., matching users concurrently streaming on both `Mobile` and `Smart TV`).
* **Dynamic Regional Ranking**: Implements algorithmic scaling via `DENSE_RANK() OVER (PARTITION BY country ORDER BY ...)` to locate peak platform context consumers broken down inside localized markets.

## 🛠️ Tech Stack & Setup Instructions

* **Engine Platform**: PostgreSQL / Standard SQL Compatible Database Engines
* **Database Language Core**: Advanced SQL (Structured Query Language)

### Getting Started

1. **Schema Initialization**: Clone the repository and execute the database tables layout scripts locally:
   ```bash
   psql -U your_username -d your_database_name -f schema.sql
