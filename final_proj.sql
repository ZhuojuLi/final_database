-- UserType Table
CREATE TABLE usertype (
    user_type_id INT AUTO_INCREMENT PRIMARY KEY,
    user_type VARCHAR(255) NOT NULL
);

-- Users Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    date_joined DATETIME NOT NULL,
    last_login DATETIME,
    user_type_id INT NOT NULL,
    FOREIGN KEY (user_type_id) REFERENCES usertype(user_type_id)
);

-- Brands Table
CREATE TABLE brands (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(255) NOT NULL,
    description TEXT,
    eco_friendly_rating INT NOT NULL,
    foundation_year YEAR,
    INDEX (brand_name),
    INDEX (eco_friendly_rating)
);

-- Products Table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    eco_rating INT NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
    FOREIGN KEY (category_id) REFERENCES productcategories(category_id),
    INDEX (name),
    INDEX (brand_id),
    INDEX (category_id),
    INDEX (price),
    INDEX (eco_rating)
);

-- ProductCategories Table
CREATE TABLE productcategories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL,
    description TEXT,
    INDEX (category_name)
);

-- ProductReviews Table
CREATE TABLE productreviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT NOT NULL,
    comment TEXT,
    date_submitted DATETIME NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    INDEX (product_id),
    INDEX (user_id),
    INDEX (rating)
);

-- Orders Table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    address_id INT NOT NULL,
    date_placed DATETIME NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (address_id) REFERENCES addresses(address_id),
    INDEX (user_id),
    INDEX (date_placed)
);

-- OrderDetails Table
CREATE TABLE orderdetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    INDEX (order_id),
    INDEX (product_id)
);

-- ProductMaterials Table
CREATE TABLE productmaterials (
    material_id INT AUTO_INCREMENT PRIMARY KEY,
    material_name VARCHAR(255) NOT NULL,
    eco_friendly_score INT NOT NULL,
    recyclable BOOLEAN NOT NULL,
    INDEX (eco_friendly_score),
    INDEX (recyclable)
);

-- ProductMaterialLink Table (Junction Table)
CREATE TABLE productmateriallink (
    product_id INT NOT NULL,
    material_id INT NOT NULL,
    PRIMARY KEY (product_id, material_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (material_id) REFERENCES productmaterials(material_id)
);

-- Addresses Table
CREATE TABLE addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    address_line1 VARCHAR(255) NOT NULL,
    address_line2 VARCHAR(255),
    zip_code VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    INDEX (zip_code)
);

-- InventoryTransactions Table
CREATE TABLE inventorytransactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    type ENUM('Sale', 'Purchase', 'Adjustment') NOT NULL,
    quantity_change INT NOT NULL,
    transaction_date DATETIME NOT NULL,
    notes TEXT,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    INDEX (product_id),
    INDEX (transaction_date),
    INDEX (type)
);
