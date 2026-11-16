# Farmacia BI — SQL, data quality and business intelligence

A portfolio project documenting a pharmacy relational model and a 2024 practice dataset for cream-sales analysis. The repository separates database engines, data assets, validation and historical Power BI evidence.

> **Data notice:** the published CSV is a simulated/practice dataset, not verified real commercial activity. Customer names, surnames, email addresses and phone numbers were removed; customer identifiers were pseudonymized.

## Project stages

1. **Operational relational model (MySQL 8.x):** pharmacy entities, keys and relationships.
2. **Cream-sales analysis (PostgreSQL):** a separate analytical model and SQL queries for the 2024 practice dataset.
3. **Data preparation and quality:** anonymized CSV, data dictionary and repeatable validation.
4. **Historical Power BI report:** screenshots from the earlier report are retained as historical evidence only. The original `.pbix` files are not published until their embedded data is audited and reconciled.
5. **Next iteration:** new Power BI reports will be developed from validated datasets and SQL transformations.

## Repository map

- `database/mysql/` — operational schema for MySQL 8.x.
- `database/postgresql/` — analytical schema and queries for PostgreSQL.
- `data/` — anonymized practice dataset.
- `docs/` — project scope, data quality, dictionary, Power BI status and evidence.
- `diagrams/` — entity-relationship diagram.
- `powerbi/` — Power BI status and future report assets.
- `scripts/` — reproducible dataset validation.

## Dataset snapshot

- Rows: 2,500
- Distinct sale IDs: 2,500
- Period: 2024-01-01 to 2024-12-31
- Distinct pseudonymized customers: 2,160
- Sales total: 75,896,882
- Units: 6,162

These figures describe the current anonymized CSV only. They are not the same figures shown in the historical Power BI PDF.

## Run validation

```bash
python scripts/validate_dataset.py
```

## Power BI

See [`docs/powerbi-status.md`](docs/powerbi-status.md) and [`docs/evidence/powerbi-legacy/`](docs/evidence/powerbi-legacy/). The legacy screenshots are provided to demonstrate prior work, not to claim that the old report matches the current dataset.

## Author

Agustín Cabral — Data Analytics · SQL · Power BI · Data Quality
