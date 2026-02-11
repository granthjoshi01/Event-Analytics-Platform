
# Funnels Analysis

This folder contains SQL queries used to analyze user funnel progression in the Event Analytics system.

Funnels help measure how users move through key product stages — from signup to activation and early engagement.

---

## Files Overview

### 1. `signup_to_day1.sql`

**Purpose:**  
Measures Day 1 retention — how many users return the day after signup.

**Key Insight:**  
Helps evaluate early user engagement and product stickiness.

**Metrics Covered:**
- Total signups
- Users active on Day 1
- Day 1 retention rate (%)

---

### 2. `signup_to_activity.sql`

**Purpose:**  
Tracks how many users perform a meaningful activity after signing up.

**Examples of Activity:**
- Creating an event  
- Joining an event  
- Performing first interaction  

**Key Insight:**  
Measures activation rate (Signup → First meaningful action).

**Metrics Covered:**
- Total signups
- Activated users
- Activation rate (%)

---



---

##  Usage

Run these queries against the analytics database after ensuring:

- Signup events are properly tracked  
- User activity events are cleaned and deduplicated  
- Timestamps are standardized  

These queries are designed to be modular and can be extended to build multi-step funnels.
