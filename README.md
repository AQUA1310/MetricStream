# 🎬 MetricStream: Streaming Platform Data Pipeline & Analytics Engine

MetricStream is a production-ready relational database model and data-seeding pipeline engineered for modern video-on-demand architectures. It maps, injects, and evaluates critical platform data points: user acquisition, service monetization plans, cross-entity subscriptions, and high-frequency viewing telemetry logs.

---

## 📖 Table of Contents
1. [Project Architecture Overview](#-project-architecture-overview)
2. [Database Schema & Entity-Relationship Model](#-database-schema--entity-relationship-model)
3. [Data Dictionary & Constraints](#-data-dictionary--constraints)
4. [The Raw SQL DDL & Seed Scripts](#-the-raw-sql-ddl--seed-scripts)
5. [Deployment Guide: How to Get the Output](#-deployment-guide-how-to-get-the-output)
6. [Analytical Insights & Business KPIs](#-analytical-insights--business-kpis)

---

## 🚀 Project Architecture Overview

MetricStream simulates the complete data footprint of an active media streaming service[cite: 1, 2, 3]. It bridges business infrastructure with real-time application behavior by managing three primary business layers:
*   **User Attribution Layer**: Evaluates global onboarding distributions alongside marketing channel effectiveness (`referral_source`).
*   **Billing & Tier Optimization Layer**: Directs access rules across distinct monetization packages ($9.99 Basic, $15.49 Standard, and $19.99 Premium tiers).
*   **Event-Driven Telemetry Layer**: Feeds user watch habits directly into granular session tracking metrics (`minutes_streamed`) categorized by hardware endpoints.

---

## 📊 Database Schema & Entity-Relationship Model

The underlying system is built on strong relational integrity. Subscriptions and playback events are structurally tied to active customer records, enforcing database constraints across your ecosystem.

### ER Diagram (Mermaid)

```mermaid
erDiagram
    USERS ||--o{ SUBSCRIPTIONS : "holds"
    USERS ||--o{ USAGE_LOGS : "generates"
    PLANS ||--o{ SUBSCRIPTIONS : "defines"
    
    USERS {
        INT user_id PK
        VARCHAR name
        VARCHAR email UK
        VARCHAR country
        DATE signup_date
        VARCHAR referral_source
    }
    PLANS {
        INT plan_id PK
        VARCHAR plan_name
        DECIMAL monthly_price
        INT max_screens
    }
    SUBSCRIPTIONS {
        INT sub_id PK
        INT user_id FK
        INT plan_id FK
        DATE start_date
        DATE end_date
        VARCHAR status
    }
    USAGE_LOGS {
        INT log_id PK
        INT user_id FK
        DATE activity_date
        INT minutes_streamed
        VARCHAR device_type
    }
