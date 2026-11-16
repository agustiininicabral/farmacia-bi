# Power BI status

The project has a previous Power BI report exported to PDF. Three screenshots from that report are preserved under `docs/evidence/powerbi-legacy/`.

The legacy report shows:
- 233 tickets
- 547 units sold
- approximately 6.58 million in sales
- average ticket of approximately 28.22 thousand
- average customer age of 42.13

These metrics do not match the current public dataset (`data/sales_2024_anonymized.csv`), which contains 2,500 distinct sale IDs, 6,162 units and 75,896,882 in total. Therefore, the screenshots are labeled as historical evidence and are not presented as results from the current CSV.

The original `.pbix` files are excluded from this public-ready package until they are reviewed in Power BI Desktop. The audit must cover embedded data, Power Query sources, relationships, DAX measures and visual totals. After that, the report can be refreshed against the public anonymized dataset or retained as a clearly separate historical version.

New Power BI reports will be developed in a later project iteration from validated datasets and SQL transformations.
