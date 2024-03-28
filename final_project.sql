CREATE TABLE usertype (
    user_type_id INT AUTO_INCREMENT PRIMARY KEY,
    user_type VARCHAR(255) NOT NULL
);

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    date_joined DATETIME NOT NULL,
    last_login DATETIME,
    fk_user_type_id INT,
    FOREIGN KEY (fk_user_type_id) REFERENCES UserType(user_type_id)
);

CREATE INDEX idx_email ON users(email);
CREATE INDEX idx_username ON users(user_name);

CREATE TABLE 
