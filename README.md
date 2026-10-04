# Loan Repayment & Credit Risk Analysis Using SQL

## Project Overview

This project analyzes loan repayment performance and customer credit-risk patterns using MySQL.

The analysis uses loan performance, customer demographic information, and previous loan history to identify factors associated with good and bad loan outcomes.

## Objectives

- Analyze overall loan portfolio performance
- Calculate total and average loan amounts
- Compare Good vs Bad loan performance
- Analyze loan performance by loan number
- Study the relationship between previous loan history and repayment performance
- Analyze credit-risk patterns by employment status
- Analyze credit-risk patterns by education level
- Analyze credit-risk patterns by bank account type
- Identify customer-level loan exposure

## Dataset

The project uses three datasets:

- Loan performance data
- Customer demographic data
- Previous loan history

## Tools Used

- MySQL
- SQL
- MySQL Workbench
- GitHub

## SQL Concepts Used

- SELECT
- WHERE
- GROUP BY
- ORDER BY
- CASE WHEN
- Aggregate Functions
- JOIN
- Subqueries
- Common Table Expressions (CTEs)
- Conditional Aggregation

## Key Findings

- Analyzed 4,368 current loan records.
- Total loan amount analyzed was approximately 77.79 million.
- 78.21% of loans were classified as Good and 21.79% as Bad.
- Customers with 1–3 previous loans had a higher observed bad-loan rate than customers with longer loan histories.
- Employment status, education level and bank account type showed differences in observed bad-loan rates.
- The analysis highlights potential credit-risk patterns that can support lending and risk-assessment decisions.

## Project Structure

```text
loan-credit-risk-analysis-sql/
│
├── README.md
│
└── sql/
    └── loan_credit_analysis.sql
