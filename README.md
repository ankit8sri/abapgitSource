# ZSALES_ORDER_ALV_TEST - Sales Order ALV Learning Package

## Overview
This ABAP package contains a complete sales order ALV report with conditional coloring, designed for learning SAP ABAP development in BTP ABAP Environment.

## Package Structure
```
ZSALES_ORDER_ALV_TEST/
├── src/
│   ├── ztables/         # Table Definitions
│   │   ├── zscarr_test.tabl.xml      # Airlines Table
│   │   └── zsflight_test.tabl.xml    # Flights Table
│   ├── zcds_views/      # CDS Views
│   │   └── zcds_flight_test.ddls.*   # Flight Data CDS View
│   └── zreports/        # ABAP Reports
│       └── zsales_order_alv_test.prog.* # Main ALV Report
├── package.devc.xml     # Package Definition
├── .abapgit.xml        # abapGit Configuration
└── README.md           # This file
```

## Components Included
- **ZSCARR_TEST**: Airlines master data table
- **ZSFLIGHT_TEST**: Flight data table with pricing and seat information
- **ZCDS_FLIGHT_TEST**: CDS view joining airline and flight data
- **ZSALES_ORDER_ALV_TEST**: ALV report with conditional coloring based on flight prices

## Features
- **Conditional Coloring**: 
  - Green: Price < 500
  - Orange: Price 500-999
  - Red: Price >= 1000
- **Selection Screen**: Filter by airline and flight date
- **Optimized Columns**: Proper column headers and formatting
- **Modern ABAP**: Uses SALV classes for ALV display

## Deployment Instructions

### Using abapGit
1. Push this directory to your Git repository
2. In ADT: abapGit Repositories → Clone Repository
3. Enter Git URL and target package: `ZSALES_ORDER_ALV_TEST`
4. Pull objects and activate

### Manual Deployment
1. Create package `ZSALES_ORDER_ALV_TEST` in ADT
2. Create tables, CDS view, and report using provided source code
3. Activate all objects

## Usage
1. Execute report `ZSALES_ORDER_ALV_TEST` (F8)
2. Enter selection criteria (airline, date range)
3. View flight data with conditional coloring
4. Test CDS view `ZCDS_FLIGHT_TEST` in Data Preview

## Learning Topics Covered
- Table definitions with proper annotations
- CDS views with joins and field mappings
- ALV reports with SALV classes
- Conditional formatting and coloring
- Selection screens and data filtering
- Modern ABAP development practices