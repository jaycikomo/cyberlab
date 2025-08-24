// Configuration dynamique des ports CyberLab v1.0.0
const CYBERLAB_CONFIG = {
    version: "1.0.0",
    codename: "Genesis",
    network: "172.35.0.0/24",
    services: {
        dashboard: { port: 8080, ip: "172.35.0.20" },
        portainer: { port: 9000, ip: "172.35.0.2" },
        phpmyadmin: { port: 8090, ip: "172.35.0.31" },
        elasticsearch: { port: 9200, ip: "172.35.0.5" },
        kibana: { port: 5601, ip: "172.35.0.6" },
        grafana: { port: 3000, ip: "172.35.0.7" },
        wazuh_dashboard: { port: 5443, ip: "172.35.0.61" },
        wazuh_manager: { port: 55000, ip: "172.35.0.60" },
        dvwa: { port: 8081, ip: "172.35.0.80" },
        webgoat: { port: 8082, ip: "172.35.0.81" },
        juice_shop: { port: 8083, ip: "172.35.0.82" },
        mysql: { port: 3306, ip: "172.35.0.30" }
    },
    credentials: {
        grafana: { user: "admin", pass: "CyberLab2024!" },
        wazuh: { user: "admin", pass: "CyberLab2024!" },
        mysql_root: { user: "root", pass: "CyberLab2024!" },
        mysql_app: { user: "webapp", pass: "webapp123" },
        dvwa: { user: "admin", pass: "password" }
    },
    installation: {
        date: "dim. 24 août 2025 22:36:10 CEST",
        installer: "root",
        hostname: "kali"
    }
};

console.log('CyberLab v1.0.0 Genesis - Configuration chargée');
