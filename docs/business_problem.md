# Business Problem

## Context

I analyzed two years of transaction data (June 2024 – June 2026) for an Indian e-commerce platform spanning 40,000 customers, 2,000 products across 7 categories, and 250,000 orders. Nearly 20% of orders are Cancelled, Returned, or stuck in Processing — a direct hit to revenue and operational efficiency.

## Objective

My goal was to identify which customer segments, product categories, and payment methods drive the most reliable revenue, uncover the root causes behind order cancellations and returns, and evaluate whether coupon usage and pricing strategy are actually improving conversion or eroding margin.

## Questions I Set Out to Answer

1. **Revenue drivers** — Which customer tiers and product categories contribute the most revenue? What does the month-over-month revenue trend look like?
2. **Cancellation and return root cause** — Does the cancellation/return rate vary meaningfully by category, payment mode, or coupon usage? Does delivery time play a role?
3. **Customer behavior** — How does spending differ by customer tier and age group? Are Platinum-tier customers actually behaving differently, or is the tier just a label?
4. **Operational efficiency** — Does payment mode (COD vs. prepaid) affect cancellation rates? Are any orders stuck in the fulfillment pipeline longer than expected?
5. **Pricing strategy** — Is coupon usage actually increasing average order value, or is it just attracting smaller, discount-driven purchases?

## Approach

1. Validated the raw data for quality issues (nulls, duplicate keys, orphaned foreign keys, date logic) using Python/pandas.
2. Loaded the cleaned data into a relational MySQL database.
3. Answered the questions above using SQL — joins, aggregation, window functions, and multi-step CTEs.
4. Built a 6-page Power BI dashboard to make the findings explorable and presentable.

## Outcome

The analysis found that cancellation/return rates are nearly uniform across product categories and don't correlate with product rating — ruling out product quality as the driver. Instead, the real story is operational (a large share of orders stuck in Processing well past the expected delivery window) and behavioral (coupon usage isn't lifting order value, and revenue is heavily concentrated in the Platinum tier and the 26–45 age group). Full findings and recommendations are in the main [README](../README.md).
