-- Encontrar principales compradores de los ultimos 10 años
SELECT Destino, ROUND(SUM(Valor_miles_USD) / 1000, 1) AS millones_usd, ROUND(100.0 * SUM(Valor_miles_USD) / SUM(SUM(Valor_miles_USD)) OVER (), 1) AS participacion_pct
FROM destinos
WHERE Fecha >= '2016-01-01' AND Fecha < '2026-01-01'
GROUP BY destino
ORDER BY millones_usd DESC;

-- Brasil y Argentina son los principales compradores de los ultimos 10 años, con un 56.3 de la participacion total.
-- La unión europea representaba un 6.6% de participacion total.
-- Rusia un 5.0%
-- Asia un 10.1% 

-- Ver como se repite la tendencia en los ultimos 5 años
SELECT Destino, ROUND(SUM(Valor_miles_USD) / 1000, 1) AS millones_usd, ROUND(100.0 * SUM(Valor_miles_USD) / SUM(SUM(Valor_miles_USD)) OVER (), 1) AS participacion_pct
FROM destinos
WHERE Fecha >= '2021-01-01' AND Fecha < '2026-01-01'
GROUP BY destino
ORDER BY millones_usd DESC;

-- Practicamente igual, mismos destinos y sin mucha variación en la participación porcentual.

-- Ver como se encuentra la tendencia en los ultimos 3 años
SELECT Destino, ROUND(SUM(Valor_miles_USD) / 1000, 1) AS millones_usd, ROUND(100.0 * SUM(Valor_miles_USD) / SUM(SUM(Valor_miles_USD)) OVER (), 1) AS participacion_pct
FROM destinos
WHERE Fecha >= '2023-01-01' AND Fecha < '2026-01-01'
GROUP BY destino
ORDER BY millones_usd DESC;

-- Muy similar, solo que Argentina pasa a ser el principal destino de nuestras exportaciones.

-- Ver destinos del 2025
SELECT Destino, ROUND(SUM(Valor_miles_USD) / 1000, 1) AS millones_usd, ROUND(100.0 * SUM(Valor_miles_USD) / SUM(SUM(Valor_miles_USD)) OVER (), 1) AS participacion_pct
FROM destinos
WHERE Fecha >= '2025-01-01' AND Fecha < '2026-01-01'
GROUP BY destino
ORDER BY millones_usd DESC;

-- Misma tendencia, Brasi encabeza de nuevo la lista, Rusia bajó mucho su participación.
-- Un gráfico con las exportaciones por destino por año sería lo más interesante y su % de participación.

-- Ver de que se compusieron las exportaciones los últimos 10 años.
SELECT Producto, ROUND(SUM(Valor_miles_USD) / 1000, 1) AS millones_usd, ROUND(100.0 * SUM(Valor_miles_USD) / SUM(SUM(Valor_miles_USD)) OVER (), 1) AS participacion_pct
FROM exportaciones
WHERE Fecha >= '2016-01-01' AND Fecha < '2026-01-01'
GROUP BY Producto
ORDER BY millones_usd DESC;

-- La soja, la energía eléctrica y la carne son los principales productos exportados. Los derivados de la soja, representan el 12%.
-- El arroz representa el 3%.

-- Ver de que se compusieron las exportaciones los últimos 5 años.
SELECT Producto, ROUND(SUM(Valor_miles_USD) / 1000, 1) AS millones_usd, ROUND(100.0 * SUM(Valor_miles_USD) / SUM(SUM(Valor_miles_USD)) OVER (), 1) AS participacion_pct
FROM exportaciones
WHERE Fecha >= '2021-01-01' AND Fecha < '2026-01-01'
GROUP BY Producto
ORDER BY millones_usd DESC;

-- Soja sigue igual, derivados de la soja bajaron su participacion al 11%. Carne aumentó su participación al 17%. Energía eléctrica bajó al 13. Arroz bajó al 2%.

-- Ver de que se compusieron las exportaciones los últimos 3 años.
SELECT Producto, ROUND(SUM(Valor_miles_USD) / 1000, 1) AS millones_usd, ROUND(100.0 * SUM(Valor_miles_USD) / SUM(SUM(Valor_miles_USD)) OVER (), 1) AS participacion_pct
FROM exportaciones
WHERE Fecha >= '2023-01-01' AND Fecha < '2026-01-01'
GROUP BY Producto
ORDER BY millones_usd DESC;

-- Se mantuvo la tendencia, energía eléctrica volvió a reducirse, Arroz subió hasta un 3.6%.

-- Ver de que se compusieron las exportaciones en 2025.
SELECT Producto, ROUND(SUM(Valor_miles_USD) / 1000, 1) AS millones_usd, ROUND(100.0 * SUM(Valor_miles_USD) / SUM(SUM(Valor_miles_USD)) OVER (), 1) AS participacion_pct
FROM exportaciones
WHERE Fecha >= '2025-01-01' AND Fecha < '2026-01-01'
GROUP BY Producto
ORDER BY millones_usd DESC;

-- Se mantuvo la tendencia de los últimos 3 años, con la soja liderando, la carne creció un 3%, derivados de la soja se mantuvo en un 11%.
-- Un gráfico con las exportaciones por producto por año sería lo más interesante y su % de participación.
-- Otro gráfico sería un timeline del valor en millones USD por producto, para ver la tendencia de los últimos 10 años.

-- Ver evolución del valor nominal de las exportaciones por producto en los últimos 10 años.
-- Ver de granos de soja
SELECT strftime('%Y', Fecha) AS Año, Producto, ROUND(SUM(Valor_miles_USD) / 1000, 1) AS millones_usd
FROM exportaciones
WHERE Producto = 'Granos de soja'
GROUP BY Año
ORDER BY Año DESC;

-- El pico fue 2023 con 3424.
-- Ver de derivados de la soja
-- Exportaciones de derivados de la soja (harina + aceite) por año
SELECT strftime('%Y', Fecha) AS Año,
       ROUND(SUM(Valor_miles_USD) / 1000, 1) AS derivados_millones_usd
FROM exportaciones
WHERE Producto IN ('Harina de soja', 'Aceites de soja')
GROUP BY Año
ORDER BY Año DESC;

-- El pico fue 2014 con 1588 millones USD, hace 10 años.
-- Ver todo el complejo sojero (granos de soja + harina + aceite) por año
-- Exportaciones de derivados de la soja (harina + aceite) por año
SELECT strftime('%Y', Fecha) AS Año,
       ROUND(SUM(Valor_miles_USD) / 1000, 1) AS complejo_sojero_millones_usd
FROM exportaciones
WHERE Producto IN ('Granos de soja', 'Harina de soja', 'Aceites de soja')
GROUP BY Año
ORDER BY Año DESC;

-- El pico fue el 2023 con 4825 millones USD.
-- Crecimiento por producto: promedio 2016-2018 vs promedio 2023-2025
SELECT Producto,
       ROUND(SUM(CASE WHEN Fecha >= '2016-01-01' AND Fecha < '2019-01-01'
                      THEN Valor_miles_USD END) / 3 / 1000, 1) AS prom_2016_2018,
       ROUND(SUM(CASE WHEN Fecha >= '2023-01-01' AND Fecha < '2026-01-01'
                      THEN Valor_miles_USD END) / 3 / 1000, 1) AS prom_2023_2025,
       ROUND((SUM(CASE WHEN Fecha >= '2023-01-01' AND Fecha < '2026-01-01'
                       THEN Valor_miles_USD END)
            - SUM(CASE WHEN Fecha >= '2016-01-01' AND Fecha < '2019-01-01'
                       THEN Valor_miles_USD END)) / 3 / 1000, 1) AS diferencia_millones,
       ROUND(100.0 * (SUM(CASE WHEN Fecha >= '2023-01-01' AND Fecha < '2026-01-01'
                               THEN Valor_miles_USD END)
                    / SUM(CASE WHEN Fecha >= '2016-01-01' AND Fecha < '2019-01-01'
                               THEN Valor_miles_USD END) - 1), 1) AS crecimiento_pct
FROM exportaciones
GROUP BY Producto
ORDER BY crecimiento_pct DESC;

-- En terminos porcentuales, los que más crecieron fueron Fibras de algodón, Maíz, Arroz, Prendas, Hilos, Carne.
-- Un gráfico que muestre eso sería muy intereseante.
-- Lo mismo para destinos que más crecieron en terminos porcentuales, y en terminos absolutos.
-- El valor total de las exportaciones también sería interesante poner en un line chart.

-- Crecimiento por producto: promedio 2016-2018 vs promedio 2023-2025 en terminos absolutos
SELECT Producto,
       ROUND(SUM(CASE WHEN Fecha >= '2016-01-01' AND Fecha < '2019-01-01'
                      THEN Valor_miles_USD END) / 3 / 1000, 1) AS prom_2016_2018,
       ROUND(SUM(CASE WHEN Fecha >= '2023-01-01' AND Fecha < '2026-01-01'
                      THEN Valor_miles_USD END) / 3 / 1000, 1) AS prom_2023_2025,
       ROUND((SUM(CASE WHEN Fecha >= '2023-01-01' AND Fecha < '2026-01-01'
                       THEN Valor_miles_USD END)
            - SUM(CASE WHEN Fecha >= '2016-01-01' AND Fecha < '2019-01-01'
                       THEN Valor_miles_USD END)) / 3 / 1000, 1) AS diferencia_millones,
       ROUND(100.0 * (SUM(CASE WHEN Fecha >= '2023-01-01' AND Fecha < '2026-01-01'
                               THEN Valor_miles_USD END)
                    / SUM(CASE WHEN Fecha >= '2016-01-01' AND Fecha < '2019-01-01'
                               THEN Valor_miles_USD END) - 1), 1) AS crecimiento_pct
FROM exportaciones
GROUP BY Producto
ORDER BY diferencia_millones DESC;

-- En promedio exportamos soja 900 millones de dólares más que hace 10 años.
-- La carne representa 700 millones más que hace 10 años.
-- El arroz representa 200 millones más.
-- El maíz 300 millones más.
-- La energía eléctrica es la peor caída, con 800 millones menos en promedio.
-- Derivados de la soja están estancados.
-- Resto representa 1000 millones más que hace 10 años, en promedio. Esto es por la suma de todos los productos que no son los principales.