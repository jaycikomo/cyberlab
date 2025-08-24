-- CyberLab Database Initialization
USE cyberlab_db;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS audit_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(100) NOT NULL,
    resource VARCHAR(100),
    ip_address VARCHAR(45),
    user_agent TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Données de test
INSERT INTO users (username, email, password, role) VALUES 
('admin', 'admin@cyberlab.local', 'admin123', 'admin'),
('testuser', 'test@cyberlab.local', 'password123', 'user'),
('vulnerable', 'vuln@cyberlab.local', 'weak', 'user');

INSERT INTO audit_logs (user_id, action, resource, ip_address) VALUES 
(1, 'LOGIN', 'dashboard', '172.35.0.1'),
(2, 'ACCESS', 'dvwa', '172.35.0.100'),
(3, 'FAILED_LOGIN', 'dashboard', '172.35.0.100');
