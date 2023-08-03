# Sustainable Data Day 1 : Data Acquisition with Snowflake

The first day cover data acquisition and storage in a modern data platform.

We will use [Snowflake](https://www.snowflake.com) as **Cloud Data Management System**. It is fully managed (SaaS), fast, flexible and user-friendly.
It covers not only data storage, but also processing and analysis. It is cloud-agnostic, as it operates across Amazon Web Services (AWS), Microsoft Azure or Google Cloud Platform(GCP).
Snowflake has a **pay-as-you-go** pricing model meaning that the cost is related to your usage of the platform.
Even if some featurs used in this workshop are still unique to Snowflake, you should be able to adapt to other DBMS such as PostgreSQL (on premise), Azure Synapse Analytics (Cloud) or Google Big Query (Cloud).

During Sustainable Data Days workshops, we use two distinct finance activities:
- Trading via a market exchange simulator (Atom)
- Sustainable Investment with extra-financial data also call "ESG" (Environment Social Governance)

So be ready to learn some functional concepts.

## Exercise 1 - Structured data integration
In [exercise 1](data%20acquisition%20-%20exercice%2001.md), we will create reference tables that will be used for classification (industry, sector, region) and strategies for investment decision.

### Functional scope
Learn some basics of investment management and ESG.
- Issuer
- Issuing
- Classification

### Technical activities
- Database and table creation
- Import a structured dataset (CSV) 
- Create stage, file format, role, warehouse, 

## Exercise 2 - Unstructured Data Integration
In [exercise 2](data%20acquisition%20-%20exercice%2002.md), we start manipulated operational data produced by the market exchange simulator.

### Functional scope
Review different market participants and trading concept: 
- Market participant
- Order 
- Price 
- Execution

### Technical activities
- Import unstructured data (json) into Snowflake variant table via an external stage on AWS S3

## Exercise 3 - Data Sharing [Work in Progress]
Access ESG KPI produced by a data provider.

### Functional scope
Some types of ESG data.
- ESG KPI
- PAI

### Technical activities
Setup a data sharing.

## Exercise 4 - Continuous Data Acquisition [Work in Progress]
Automate data acquisition from the trading platform (batch).

### Functional scope

### Technical activities
- Setup snowpipe with SNS notification to ingest data as soon as it is written on the AWS S3 bucket.

## Exercise 5 - Optional - Streaming Data Acquisition [Work in Progress]
Acquire financial transactions in streaming

### Functional scope

### Technical activities
- Snowpipe with kafka streaming