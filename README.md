# MetricStream - Database Management System

## 1. Project Explanation
MetricStream is a relational database management platform tailored for a subscription-based streaming provider. The system is engineered to capture user profiles, manage multiple operational subscription tiers, monitor retention lifecycle statuses, and log streaming data metrics across distinct device forms. By aggregating these relationship datasets, the architecture supplies a pipeline for calculating core business performance factors like Monthly Recurring Revenue (MRR), subscriber churn rates, and cross-platform device usage engagement.

## 2. ER Diagram
The relational architecture follows an integrated network of one-to-many dependencies to record metrics cleanly without duplication:

*   **Users to Subscriptions (1:N):** A user can manage successive subscription cycles over time, but each unique billing subscription profile maps back to a single user account.
*   **Plans to Subscriptions (1:N):** A pricing plan tier hosts multiple customer subscriptions simultaneously, while a specific subscription lifecycle event enforces exactly one plan rate.
*   **Users to Usage Logs (1:N):** One account produces infinite session stream metrics, but every individual stream row traces back strictly to the initiating viewer.

*(Note: Add your actual ER diagram image to the root folder of this repository and name it `er_diagram.png`)*
![ER Diagram](er_diagram.png)

## 3. Relational Tables
The normalized schema uses four foundational tables:

### 1. Users
Tracks global consumer profile and acquisition metadata.
*   `user_id` (INT, Primary Key): Unique row index for the individual user profile.
*   `name` (VARCHAR): Standard text string containing the customer's full name.
*   `email` (VARCHAR, Unique): Validated direct email address string.
*   `country` (VARCHAR): Demographic country string used for geographic performance analysis.
*   `signup_date` (DATE): Standard date tracking when the user profile was created.
*   `referral_source` (VARCHAR): Direct attribute tracking user acquisition channel origins.

### 2. Plans
Houses available tier parameters, prices, and concurrent structural streams.
*   `plan_id` (INT, Primary Key): Unique functional identifier for the subscription plan tier.
*   `plan_name` (VARCHAR): Operational identifier naming the tier (Basic, Standard, Premium).
*   `monthly_price` (DECIMAL): Base pricing metric capturing monthly recurring income amounts.
*   `max_screens` (INT): Total integer allowance of parallel streams.

### 3. Subscriptions
Maintains time-series financial life logs and operational service states.
*   `sub_id` (INT, Primary Key): Unique billing system relationship row index.
*   `user_id` (INT, Foreign Key): System relationship index referencing `Users(user_id)`.
*   `plan_id` (INT, Foreign Key): System relationship index referencing `Plans(plan_id)`.
*   `start_date` (DATE): Active opening stamp for the current subscription tier term.
*   `end_date` (DATE): Closing or renewal date indicator for the current subscription tier term.
*   `status` (VARCHAR): Descriptive system status text (Active, Cancelled, Expired).

### 4. Usage_Logs
Logs telemetry metrics for stream sessions.
*   `log_id` (INT, Primary Key): Unique streaming event index.
*   `user_id` (INT, Foreign Key): System relationship index referencing `Users(user_id)`.
*   `activity_date` (DATE): Calendar stamp tracking exactly when the streaming session occurred.
*   `minutes_streamed` (INT): Performance duration tracking viewing lengths.
*   `device_type` (VARCHAR): Categorical text capturing screen forms (Mobile, Laptop, Smart TV, Web).

## 4. How to Run It and Get Output

### Execution Environment Setup
1. Open your database GUI tool (such as **pgAdmin 4** or **DBeaver**) connected to your target **PostgreSQL** instance.
2. Open a new Query Tool session and execute the structural commands found in your modified `schema.sql` script to establish the database layout.
3. Open a separate query panel, copy the full dataset from your corrected `data_import.sql` script, and execute it to populate your relational tables.

### Extracting System Output
To verify system viability and read data metrics, open your script containing `analytics_queries.sql` and run individual analytical commands. 

For example, highlight and run the following query to view total active streams by device:
```sql
SELECT device_type, COUNT(log_id) AS total_sessions
FROM Usage_Logs
GROUP BY device_type;
