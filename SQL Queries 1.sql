SELECT
    CASE WHEN DAYOFWEEK(STR_TO_DATE(o.order_purchase_timestamp, '%Y-%m-%d')) IN (1, 7) THEN 'Weekend' 
         ELSE 'Weekday' 
    END AS DayType, 
    COUNT(DISTINCT o.order_id) AS TotalOrders, 
    ROUND(SUM(p.payment_value)) AS TotalPayments, 
    ROUND(AVG(p.payment_value)) AS AveragePayment
FROM
    orders_dataset o
JOIN
    payments_dataset p ON o.order_id = p.order_id
GROUP BY
    DayType;



SELECT
    COUNT(DISTINCT p.Order_id) AS NumberOfOrders
FROM
    payments_dataset p
JOIN
    reviews_dataset r ON p.Order_id = r.Order_id
WHERE
    r.Review_score = 5
    AND p.Payment_type = 'credit_card';


SELECT
    p.Product_Category_name,
    ROUND(AVG(DATEDIFF(o.Order_Delivered_Customer_Date, o.Order_Purchase_Timestamp))) AS avg_delivery_time
FROM
    orders_dataset o
JOIN
    items_dataset i ON i.order_id = o.order_id
JOIN
    products_dataset p ON p.product_id = i.product_id
WHERE
    p.Product_Category_name = 'pet_shop' AND o.Order_Delivered_Customer_Date IS NOT NULL
GROUP BY
    p.Product_Category_name;


SELECT
    ROUND(AVG(i.Price)) AS average_price,
    ROUND(AVG(p.Payment_value)) AS average_payment
FROM
    customers_dataset c
JOIN
    orders_dataset o ON c.Customer_id = o.Customer_id
JOIN
    items_dataset i ON o.Order_id = i.Order_id
JOIN
    payments_dataset p ON o.Order_id = p.Order_id
WHERE
    c.City = 'Sao Paulo';


SELECT
    r.Review_score,
    ROUND(AVG(IFNULL(DATEDIFF(o.Order_Delivered_Customer_Date, o.Order_Purchase_Timestamp), 0))) AS AvgShippingDays
FROM
    orders_dataset o
JOIN
    reviews_dataset r ON o.Order_id = r.Order_id
WHERE
    o.Order_Delivered_Customer_Date IS NOT NULL AND o.Order_Purchase_Timestamp IS NOT NULL
GROUP BY
    r.Review_score;

