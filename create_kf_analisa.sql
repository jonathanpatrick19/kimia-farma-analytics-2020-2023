CREATE TABLE `rakamin-kf-analytics-468807.kimia_farma.kf_analisa` AS
SELECT
    ft.transaction_id,
    ft.date,
    kc.branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.rating AS rating_cabang,
    ft.customer_name,
    ft.product_id,
    p.product_name,
    ft.price AS actual_price,
    ft.discount_percentage,

    CASE
        WHEN ft.price <= 50000 THEN 0.10
        WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
        WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.20
        WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
        WHEN ft.price > 500000 THEN 0.30
    END AS persentase_gross_laba,

    (ft.price * (1 - ft.discount_percentage / 100)) AS nett_sales,

    (ft.price * (1 - ft.discount_percentage / 100)) *
    CASE
        WHEN ft.price <= 50000 THEN 0.10
        WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
        WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.20
        WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
        WHEN ft.price > 500000 THEN 0.30
    END AS nett_profit,

    ft.rating AS rating_transaksi

FROM `rakamin-kf-analytics-468807.kimia_farma.kf_final_transaction` AS ft
JOIN `rakamin-kf-analytics-468807.kimia_farma.kf_product` AS p
    ON ft.product_id = p.product_id
JOIN `rakamin-kf-analytics-468807.kimia_farma.kf_kantor_cabang` AS kc
    ON ft.branch_id = kc.branch_id;
