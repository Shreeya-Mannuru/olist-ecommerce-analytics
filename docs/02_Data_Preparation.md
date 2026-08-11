# 2. Data Preparation

## 1. Dataset Overview

The project uses the Olist Brazilian E-commerce Dataset, which contains
anonymized information from an e-commerce marketplace in Brazil. The
dataset covers multiple aspects of marketplace activity, including:

-   Customers
-   Orders
-   Order items
-   Products
-   Sellers
-   Payments
-   Customer reviews

The data provides an opportunity to analyze sales performance, customer
behavior, product performance, delivery operations, payment behavior,
and customer satisfaction.

## 2. Data Model

The analysis uses seven primary analytical tables:

![Logical Data Model of the Olist E-commerce
Dataset](images/Retail_olist_er.png)

**Figure 1. Logical Data Model of the Olist E-commerce Dataset**

The analytical model connects customers, orders, order items, products,
sellers, payments and reviews. The model considers the different levels
of granularity between order-level and order-item-level data.

### Key Tables in the Dataset

  Table            Purpose
  ---------------- ------------------------------------------------------
  Customers        Customer and geographic information
  Orders           Order lifecycle and timestamps
  Order Items      Products purchased and transaction-level item values
  Products         Product attributes and categories
  Sellers          Seller information and location
  Order Payments   Payment methods, installments and payment values
  Order Reviews    Customer review scores and review information

Two supporting tables are also available:

-   Geolocation
-   Product category translation

These supporting tables were not included in the primary analytical
model because they were not required for the Version 1 business
questions.

### Core Relationships

The analytical model connects:

-   Customers → Orders
-   Orders → Order Items
-   Products → Order Items
-   Sellers → Order Items
-   Orders → Order Payments
-   Orders → Order Reviews

The model considers the different levels of granularity between
order-level and order-item-level data.

## 3. Data Quality Assessment

The datasets were assessed for:

-   Missing values
-   Duplicate records
-   Invalid data types
-   Inconsistent categorical values
-   Date consistency
-   Order-status consistency
-   Referential integrity
-   Orphan records

Missing-value analysis was performed to identify fields where incomplete
data could affect analysis.

Not every missing value was automatically removed because missingness
can be meaningful in an e-commerce dataset. For example, certain
delivery-related fields may legitimately be unavailable for orders that
were not delivered.

## 4. Data Cleaning

The following cleaning activities were performed.

### Date and Time Handling

Relevant timestamp fields were converted into appropriate datetime
formats.

Date-derived fields were created where required for:

-   Monthly analysis
-   Delivery-time analysis
-   Order lifecycle analysis

### Delivery Time

Delivery duration was calculated using the relevant order timestamps.

The analysis focuses on completed/delivered orders when calculating
delivery performance.

### Missing Values

Missing values were handled based on their analytical importance rather
than applying a blanket deletion approach.

Records were retained where missing values represented legitimate
business conditions.

### Duplicates

Duplicate records were assessed using appropriate identifiers such as:

-   `order_id`
-   `order_item_id`
-   `product_id`
-   `seller_id`
-   `review_id`

### Order Status

Order status was considered when calculating business KPIs.

For example, completed sales revenue and delivery performance are based
on delivered orders, rather than treating cancelled or incomplete orders
as completed sales.

## 5. Business Feature Engineering

Simple business-oriented features were created to make the data more
useful for analysis.

### Delivery Days

Measures the number of days between relevant order and delivery
timestamps.

**Business use:** Helps evaluate fulfillment performance and identify
potential delivery issues.

### Purchase Month

Groups orders into monthly periods.

**Business use:** Supports trend analysis of revenue and order volume.

### Approval/Processing Duration

Where applicable, order lifecycle timestamps can be used to assess the
time taken between order placement and approval.

**Business use:** Provides visibility into operational processing.

These features were designed around specific business questions rather
than creating unnecessary derived variables.

## 6. Data Validation

After cleaning, the data was validated to ensure that:

-   Expected tables existed in the database.
-   Row counts were consistent with the cleaned datasets.
-   Primary identifiers were populated where expected.
-   Relationships between key tables were valid.
-   Orphan records were checked.
-   Delivered-order calculations used the appropriate order status.
-   KPI calculations produced reasonable results.

### Orphan Records

An orphan record is a record that references another record that does
not exist in the related table.

For example, an `order_items` record referencing an `order_id` that does
not exist in `orders` would be an orphan record.

These checks are important because orphan records can cause:

-   Incorrect joins
-   Missing revenue
-   Incorrect order counts
-   Misleading dashboard results

## 7. Dataset Considerations and Limitations

The dataset has several limitations:

-   It represents a historical marketplace dataset rather than current
    business activity.
-   Customer and seller identities are anonymized.
-   Seller names are not provided; seller IDs are used instead.
-   Product category names may require translation for improved
    readability.
-   Marketing, advertising and website-session data are not available.
-   Customer lifetime value cannot represent future customer behavior
    because the dataset covers a historical period.
-   Revenue analysis using item price does not necessarily represent
    accounting-level profit or net revenue because costs, discounts and
    other financial components are not fully represented.

## 8. Conclusion

The data preparation process transformed the raw Olist datasets into a
structured analytical foundation suitable for SQL analysis, Python
analysis and Power BI dashboard development.

The cleaning and validation process focused on preserving meaningful
business information while ensuring that key KPIs such as revenue,
orders, delivery performance and customer satisfaction were calculated
consistently.
