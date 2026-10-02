use db_cleaning;

DESCRIBE dataset_customers;
ALTER TABLE dataset_customers
MODIFY CustomerID INT NOT NULL PRIMARY KEY;

DESCRIBE dataset_products;
ALTER TABLE dataset_products 
MODIFY ProdNumber VARCHAR(50) NOT NULL PRIMARY KEY;

DESCRIBE dataset_orders;
ALTER TABLE dataset_orders 
MODIFY OrderID VARCHAR(50) NOT NULL PRIMARY KEY;

DESCRIBE dataset_categoryproduct;
ALTER TABLE dataset_categoryproduct 
MODIFY CategoryID INT NOT NULL PRIMARY KEY;

ALTER TABLE dataset_products 
RENAME COLUMN Category TO CategoryID;

ALTER TABLE dataset_orders
ADD FOREIGN KEY (CustomerID) REFERENCES dataset_customers(CustomerID);

ALTER TABLE dataset_orders
ADD FOREIGN KEY (ProdNumber) REFERENCES dataset_products(ProdNumber);

ALTER TABLE dataset_products
ADD FOREIGN KEY (CategoryID) REFERENCES dataset_categoryproduct(CategoryID);

SELECT 
    STR_TO_DATE(o.Date, '%d/%m/%Y') AS order_date,
    c.CategoryName AS category_name,
    p.ProdName AS product_name,
    p.Price AS product_price,
    o.Quantity AS order_qty,
    (o.Quantity * p.Price) AS total_sales,
    cu.CustomerEmail AS cust_email,
    cu.CustomerCity AS cust_city
FROM dataset_orders o
JOIN dataset_customers cu ON o.CustomerID = cu.CustomerID
JOIN dataset_products p ON o.ProdNumber = p.ProdNumber
JOIN dataset_categoryproduct c ON p.CategoryID = c.CategoryID
ORDER BY order_date ASC;