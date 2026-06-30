-- 1. Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    country VARCHAR(50),
    signup_date DATE NOT NULL,
    referral_source VARCHAR(50)
);

-- 2. Plans Table
CREATE TABLE Plans (
    plan_id INT PRIMARY KEY,
    plan_name VARCHAR(50), 
    monthly_price DECIMAL(10, 2) NOT NULL,
    max_screens INT
);

-- 3. Subscriptions Table
CREATE TABLE Subscriptions (
    sub_id INT PRIMARY KEY,
    user_id INT,
    plan_id INT,
    start_date DATE NOT NULL,
    end_date DATE, 
    status VARCHAR(20), 
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (plan_id) REFERENCES Plans(plan_id)
);

-- 4. Usage Logs Table
CREATE TABLE Usage_Logs (
    log_id INT PRIMARY KEY,
    user_id INT,
    activity_date DATE NOT NULL,
    minutes_streamed INT DEFAULT 0,
    device_type VARCHAR(30), 
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);