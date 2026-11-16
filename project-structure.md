# Project structure and technical scope

Farmacia BI contains related learning and portfolio stages. They are documented separately because they do not all use the same database engine or the same dataset version.

## Database modules

### MySQL 8.x — operational pharmacy model
`database/mysql/operational_schema.sql` represents the initial relational model for pharmacy operations: customers, suppliers, products, branches, inventory, payments, sales and sale details.

### PostgreSQL — 2024 cream-sales analysis
`database/postgresql/cremas_schema.sql` and `database/postgresql/analysis_queries.sql` belong to a later analytical stage focused on cream sales. They are not interchangeable with the MySQL schema.

## Public dataset

`data/sales_2024_anonymized.csv` is the selected public practice dataset. It contains 2,500 rows and pseudonymized customer identifiers. Direct identifiers (name, surname, email and phone) were removed.

## Historical Power BI evidence

The screenshots under `docs/evidence/powerbi-legacy/` were extracted from the previously exported Power BI PDF. They document the dashboard as it existed in an earlier version.

**Important:** those screenshots report 233 tickets, 547 units and approximately 6.58 million in sales. Those figures do not match the current public CSV (2,500 sale IDs, 6,162 units and 75,896,882 in total). They are included only as historical evidence of prior work, not as results calculated from the public CSV.

## Current status

- SQL schemas and analysis queries are separated by database engine.
- The public dataset is anonymized and has a reproducible validation script.
- The previous Power BI report is documented through historical screenshots.
- Original `.pbix` files are intentionally excluded until their embedded data, queries, relationships and measures are reviewed in Power BI Desktop and reconciled with the public dataset.
- New Power BI reports will be developed later from validated datasets and documented SQL transformations.
