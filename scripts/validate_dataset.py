#!/usr/bin/env python3
"""Validate the anonymized public dataset for Farmacia BI."""
from pathlib import Path
import csv
from datetime import date

ROOT = Path(__file__).resolve().parents[1]
CSV_PATH = ROOT / "data" / "sales_2024_anonymized.csv"
EXPECTED = {"ID_Venta", "Fecha", "Sucursal", "Categoria", "Producto", "Marca", "Precio_Unitario", "Cantidad", "Descuento_%", "Medio_Pago", "Cliente_ID", "Edad", "Genero", "Ciudad", "Stock_Disponible", "Total_Venta"}
FORBIDDEN = {"Nombre", "Apellido", "Email", "Telefono", "DNI", "dni"}

def main():
    with CSV_PATH.open(encoding="utf-8-sig", newline="") as f:
        reader = csv.DictReader(f)
        fields = set(reader.fieldnames or [])
        assert EXPECTED <= fields, f"Missing columns: {EXPECTED - fields}"
        assert not (FORBIDDEN & fields), f"Potential direct identifiers present: {FORBIDDEN & fields}"
        rows = list(reader)
    assert len(rows) == 2500, f"Expected 2500 rows, got {len(rows)}"
    ids = [r["ID_Venta"] for r in rows]
    assert len(ids) == len(set(ids)), "Duplicate sale IDs"
    dates = [date.fromisoformat(r["Fecha"]) for r in rows]
    assert min(dates) == date(2024, 1, 1) and max(dates) == date(2024, 12, 31)
    for r in rows:
        price = float(r["Precio_Unitario"]); qty = float(r["Cantidad"]); disc = float(r["Descuento_%"]); total = float(r["Total_Venta"])
        assert price >= 0 and qty >= 0 and 0 <= disc <= 100 and total >= 0
        expected = price * qty * (1 - disc / 100)
        assert abs(expected - total) <= 0.02, f"Total mismatch for {r['ID_Venta']}"
        assert r["Cliente_ID"].startswith("CLI"), "Client ID is not pseudonymized"
    print(f"OK: {len(rows)} rows; {len(set(r['Cliente_ID'] for r in rows))} pseudonymous clients; no direct identifier columns.")

if __name__ == "__main__":
    main()
