# Paraguay's Exports, 1994–2025

This project analyzes 30 years of Paraguay's exports using data from the Central Bank of Paraguay (BCP). I cleaned the data with Power Query, explored it with SQL (SQLite), and built an interactive dashboard in Power BI to answer three questions: which products drive exports, how they have grown, and where they go.

📄 **Full write-up (Spanish):** [Una historia de crecimiento](https://mydatafolio.com/p/facundo-jos-samaniego-cantero/una-historia-de-desarrollo-30-a-os-de-exportaciones-del-paraguay)

## Tools

| Cleaning and transformation | Excel · Power Query |
| Exploration | SQL (SQLite) |
| Visualization | Power BI |

## Data source

[BCP – Foreign Trade Tables (Cuadros de Comercio Exterior)](https://www.bcp.gov.py/web/institucional/comercio-externo-comex-mensual), sheets 44a (exports by product) and 45 (exports by destination). Monthly values in thousands of US dollars (FOB), nominal.

## Process

1. **Cleaning (Power Query):** removed headers, subtotals and empty columns; fixed inconsistent month labels ("Sept" vs "Set") and year markers ("2025*"); built a date column; unpivoted from wide to long format (Date, Product/Destination, Value).
2. **Exploration (SQL):** aggregations with `GROUP BY`, conditional sums with `CASE WHEN` to compare 3-year averages (2016–2018 vs 2023–2025), and window functions (`SUM() OVER()`) to calculate shares.
3. **Dashboard (Power BI):** star schema with a calendar table and a product dimension; DAX measures for total value, average annual growth and agricultural share; two pages (products and destinations) with period and category filters.

## Key findings

- Exports grew from USD 1,843 million in 1994 to USD 11,073 million in 2025 (+501%, 6.0% average annual growth).
- Electricity went from more than half of all exports in the 1990s to 10.9% in 2025.
- Agriculture and livestock accounted for 64% of exports in 2025.
- Brazil and Argentina received 60% of exports in 2025; Argentina was the fastest-growing destination.

## Limitations

- Only registered exports are included (re-exports are excluded).

## Author

Facundo Samaniego · Agronomist | Data Analysis · [LinkedIn](www.linkedin.com/in/facundo-josé-samaniego-cantero-922a65245)

