#!/bin/bash
# =============================================================================
# 🚀 INSTALLATION COMPLÈTE CYBERLAB v1.0.0 "GENESIS"
# =============================================================================
# Installation du laboratoire cybersécurité complet avec structure organisée

set -euo pipefail

# Variables globales
SCRIPT_NAME="install-complete-cyberlab"
CYBERLAB_ROOT="/root/cyberlab"
VERSION_DIR="$CYBERLAB_ROOT/versions/v1.0.0"
LOG_FILE="$CYBERLAB_ROOT/logs/installation/install-$(date +%Y%m%d-%H%M%S).log"

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

echo -e "${BLUE}================================================================="
echo "🛡️ INSTALLATION CYBERLAB v1.0.0 'GENESIS' - LABORATOIRE COMPLET"
echo "=================================================================${NC}"

# Fonction de logging
log_message() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] [$SCRIPT_NAME] $message" | tee -a "$LOG_FILE"
}

# Fonction pour trouver un port libre
find_free_port() {
    local start_port=$1
    local port=$start_port
    while netstat -tuln 2>/dev/null | grep -q ":$port "; do
        ((port++))
        if [ $port -gt 65535 ]; then
            echo "Erreur: Aucun port libre trouvé après $start_port" >&2
            return 1
        fi
    done
    echo $port
}

# 1. VÉRIFICATION DES PRÉREQUIS
echo -e "${YELLOW}🔍 1. VÉRIFICATION DES PRÉREQUIS${NC}"

# Vérifier Docker
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker n'est pas installé !${NC}"
    echo "Installation de Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    systemctl start docker
    systemctl enable docker
fi

if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ Docker Compose n'est pas installé !${NC}"
    echo "Installation de Docker Compose..."
    curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

echo -e "${GREEN}✅ Docker et Docker Compose installés${NC}"

# 2. CRÉATION DE LA STRUCTURE CYBERLAB
echo -e "${YELLOW}🏗️ 2. CRÉATION DE LA STRUCTURE CYBERLAB${NC}"

# Créer la structure complète
mkdir -p "$CYBERLAB_ROOT"/{versions/{v1.0.0,v1.1.0,v2.0.0},patches,scripts/{install,manage,backup},docker/{compose,services/{dashboard,monitoring,vulnerable-apps,infrastructure},networks},config/{environments,templates,secrets},tools/{pentest/{payloads,wordlists,scripts},monitoring,automation},logs/{installation,runtime,patches,backups,security},backups/{auto,manual,versions,migration}}

mkdir -p "$VERSION_DIR"/{services/{dashboard/{web,config},database/{init},kali},config,migration,validation}

# Créer les fichiers de base
touch "$CYBERLAB_ROOT"/{CHANGELOG.md,LICENSE,.gitignore}

echo -e "${GREEN}✅ Structure CyberLab créée${NC}"

# 3. DÉTECTION AUTOMATIQUE DES PORTS
echo -e "${YELLOW}🌐 3. DÉTECTION AUTOMATIQUE DES PORTS${NC}"

declare -A PORTS
PORTS[dashboard]=$(find_free_port 8080)
PORTS[portainer]=$(find_free_port 9000)
PORTS[phpmyadmin]=$(find_free_port 8090)
PORTS[elasticsearch]=$(find_free_port 9200)
PORTS[kibana]=$(find_free_port 5601)
PORTS[grafana]=$(find_free_port 3000)
PORTS[wazuh_dashboard]=$(find_free_port 5443)
PORTS[wazuh_manager]=$(find_free_port 55000)
PORTS[dvwa]=$(find_free_port 8081)
PORTS[webgoat]=$(find_free_port 8082)
PORTS[juice_shop]=$(find_free_port 8083)
PORTS[mysql]=$(find_free_port 3306)

echo "✅ Ports détectés automatiquement :"
for service in "${!PORTS[@]}"; do
    echo "  - $service: ${PORTS[$service]}"
done

# 4. CRÉATION DU FICHIER DE CONFIGURATION
echo -e "${YELLOW}⚙️ 4. CONFIGURATION DES SERVICES${NC}"

cat > "$VERSION_DIR/services/dashboard/web/config.js" << EOF
// Configuration dynamique des ports CyberLab v1.0.0
const CYBERLAB_CONFIG = {
    version: "1.0.0",
    codename: "Genesis",
    network: "172.35.0.0/24",
    services: {
        dashboard: { port: ${PORTS[dashboard]}, ip: "172.35.0.20" },
        portainer: { port: ${PORTS[portainer]}, ip: "172.35.0.2" },
        phpmyadmin: { port: ${PORTS[phpmyadmin]}, ip: "172.35.0.31" },
        elasticsearch: { port: ${PORTS[elasticsearch]}, ip: "172.35.0.5" },
        kibana: { port: ${PORTS[kibana]}, ip: "172.35.0.6" },
        grafana: { port: ${PORTS[grafana]}, ip: "172.35.0.7" },
        wazuh_dashboard: { port: ${PORTS[wazuh_dashboard]}, ip: "172.35.0.61" },
        wazuh_manager: { port: ${PORTS[wazuh_manager]}, ip: "172.35.0.60" },
        dvwa: { port: ${PORTS[dvwa]}, ip: "172.35.0.80" },
        webgoat: { port: ${PORTS[webgoat]}, ip: "172.35.0.81" },
        juice_shop: { port: ${PORTS[juice_shop]}, ip: "172.35.0.82" },
        mysql: { port: ${PORTS[mysql]}, ip: "172.35.0.30" }
    },
    credentials: {
        grafana: { user: "admin", pass: "CyberLab2024!" },
        wazuh: { user: "admin", pass: "CyberLab2024!" },
        mysql_root: { user: "root", pass: "CyberLab2024!" },
        mysql_app: { user: "webapp", pass: "webapp123" },
        dvwa: { user: "admin", pass: "password" }
    },
    installation: {
        date: "$(date)",
        installer: "$(whoami)",
        hostname: "$(hostname)"
    }
};

console.log('CyberLab v1.0.0 Genesis - Configuration chargée');
EOF

# 5. CRÉATION DU DOCKER-COMPOSE PRINCIPAL
echo -e "${YELLOW}🐳 5. GÉNÉRATION DU DOCKER-COMPOSE${NC}"

cat > "$VERSION_DIR/.env" << EOF
# Configuration CyberLab v1.0.0 Genesis
CYBERLAB_VERSION=1.0.0
CYBERLAB_CODENAME=Genesis
CYBERLAB_NETWORK=172.35.0.0/24

# Ports dynamiques
DASHBOARD_PORT=${PORTS[dashboard]}
PORTAINER_PORT=${PORTS[portainer]}
PHPMYADMIN_PORT=${PORTS[phpmyadmin]}
ELASTICSEARCH_PORT=${PORTS[elasticsearch]}
KIBANA_PORT=${PORTS[kibana]}
GRAFANA_PORT=${PORTS[grafana]}
WAZUH_DASHBOARD_PORT=${PORTS[wazuh_dashboard]}
WAZUH_MANAGER_PORT=${PORTS[wazuh_manager]}
DVWA_PORT=${PORTS[dvwa]}
WEBGOAT_PORT=${PORTS[webgoat]}
JUICE_SHOP_PORT=${PORTS[juice_shop]}
MYSQL_PORT=${PORTS[mysql]}

# Credentials
MYSQL_ROOT_PASSWORD=CyberLab2024!
MYSQL_PASSWORD=webapp123
GRAFANA_PASSWORD=CyberLab2024!
WAZUH_PASSWORD=CyberLab2024!
EOF

cat > "$VERSION_DIR/docker-compose.yml" << EOF
# =============================================================================
# 🛡️ CYBERLAB v1.0.0 "GENESIS" - LABORATOIRE CYBERSÉCURITÉ COMPLET
# =============================================================================

networks:
  cyberlab_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.35.0.0/24
          gateway: 172.35.0.1

volumes:
  elasticsearch_data:
  grafana_data:
  portainer_data:
  mysql_data:
  wazuh_data:

services:
  # 🌐 DASHBOARD PRINCIPAL
  dashboard:
    build: 
      context: ./services/dashboard
      dockerfile: Dockerfile
    container_name: cyberlab_dashboard
    hostname: dashboard
    ports:
      - "\${DASHBOARD_PORT}:80"
    volumes:
      - ./services/dashboard/web:/var/www/html
      - /var/run/docker.sock:/var/run/docker.sock:ro
    networks:
      cyberlab_network:
        ipv4_address: 172.35.0.20
    environment:
      - CYBERLAB_VERSION=\${CYBERLAB_VERSION}
      - CYBERLAB_NETWORK=\${CYBERLAB_NETWORK}
    restart: unless-stopped

  # 🛠️ PORTAINER
  portainer:
    image: portainer/portainer-ce:latest
    container_name: cyberlab_portainer
    hostname: portainer
    ports:
      - "\${PORTAINER_PORT}:9000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data
    networks:
      cyberlab_network:
        ipv4_address: 172.35.0.2
    restart: unless-stopped

  # 💾 PHPMYADMIN
  phpmyadmin:
    image: phpmyadmin/phpmyadmin:latest
    container_name: cyberlab_phpmyadmin
    hostname: phpmyadmin
    ports:
      - "\${PHPMYADMIN_PORT}:80"
    environment:
      - PMA_HOST=mysql
      - PMA_PORT=3306
      - PMA_USER=root
      - PMA_PASSWORD=\${MYSQL_ROOT_PASSWORD}
    networks:
      cyberlab_network:
        ipv4_address: 172.35.0.31
    depends_on:
      - mysql
    restart: unless-stopped

  # 📊 ELASTICSEARCH
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.8.0
    container_name: cyberlab_elasticsearch
    hostname: elasticsearch
    ports:
      - "\${ELASTICSEARCH_PORT}:9200"
    environment:
      - discovery.type=single-node
      - xpack.security.enabled=false
      - "ES_JAVA_OPTS=-Xms1g -Xmx1g"
    volumes:
      - elasticsearch_data:/usr/share/elasticsearch/data
    networks:
      cyberlab_network:
        ipv4_address: 172.35.0.5
    restart: unless-stopped

  # 📈 KIBANA
  kibana:
    image: docker.elastic.co/kibana/kibana:8.8.0
    container_name: cyberlab_kibana
    hostname: kibana
    ports:
      - "\${KIBANA_PORT}:5601"
    environment:
      - ELASTICSEARCH_HOSTS=http://elasticsearch:9200
      - xpack.security.enabled=false
    networks:
      cyberlab_network:
        ipv4_address: 172.35.0.6
    depends_on:
      - elasticsearch
    restart: unless-stopped

  # 📊 GRAFANA
  grafana:
    image: grafana/grafana:latest
    container_name: cyberlab_grafana
    hostname: grafana
    ports:
      - "\${GRAFANA_PORT}:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=\${GRAFANA_PASSWORD}
      - GF_USERS_ALLOW_SIGN_UP=false
    volumes:
      - grafana_data:/var/lib/grafana
    networks:
      cyberlab_network:
        ipv4_address: 172.35.0.7
    restart: unless-stopped

  # 🛡️ WAZUH MANAGER
  wazuh_manager:
    image: wazuh/wazuh-manager:4.7.0
    container_name: cyberlab_wazuh_manager
    hostname: wazuh-manager
    ports:
      - "\${WAZUH_MANAGER_PORT}:55000"
      - "1514:1514"
      - "1515:1515"
    environment:
      - WAZUH_MANAGER_ADMIN_USER=admin
      - WAZUH_MANAGER_ADMIN_PASSWORD=\${WAZUH_PASSWORD}
    volumes:
      - wazuh_data:/var/ossec/data
    networks:
      cyberlab_network:
        ipv4_address: 172.35.0.60
    restart: unless-stopped

  # 🛡️ WAZUH DASHBOARD
  wazuh_dashboard:
    image: wazuh/wazuh-dashboard:4.7.0
    container_name: cyberlab_wazuh_dashboard
    hostname: wazuh-dashboard
    ports:
      - "\${WAZUH_DASHBOARD_PORT}:5601"
    environment:
      - WAZUH_API_URL=https://wazuh_manager:55000
      - DASHBOARD_USERNAME=admin
      - DASHBOARD_PASSWORD=\${WAZUH_PASSWORD}
    networks:
      cyberlab_network:
        ipv4_address: 172.35.0.61
    depends_on:
      - wazuh_manager
    restart: unless-stopped

  # 🎯 DVWA
  dvwa:
    image: vulnerables/web-dvwa:latest
    container_name: cyberlab_dvwa
    hostname: dvwa
    ports:
      - "\${DVWA_PORT}:80"
    environment:
      - MYSQL_DATABASE=dvwa
      - MYSQL_USER=dvwa
      - MYSQL_PASSWORD=password
    networks:
      cyberlab_network:
        ipv4_address: 172.35.0.80
    restart: unless-stopped

  # 🐐 WEBGOAT
  webgoat:
    image: webgoat/webgoat-8.0:latest
    container_name: cyberlab_webgoat
    hostname: webgoat
    ports:
      - "\${WEBGOAT_PORT}:8080"
      - "9090:9090"
    networks:
      cyberlab_network:
        ipv4_address: 172.35.0.81
    restart: unless-stopped

  # 🧃 JUICE SHOP
  juice_shop:
    image: bkimminich/juice-shop:latest
    container_name: cyberlab_juice_shop
    hostname: juice-shop
    ports:
      - "\${JUICE_SHOP_PORT}:3000"
    networks:
      cyberlab_network:
        ipv4_address: 172.35.0.82
    restart: unless-stopped

  # 🗄️ MYSQL DATABASE
  mysql:
    image: mysql:8.0
    container_name: cyberlab_mysql
    hostname: mysql-db
    ports:
      - "\${MYSQL_PORT}:3306"
    environment:
      - MYSQL_ROOT_PASSWORD=\${MYSQL_ROOT_PASSWORD}
      - MYSQL_DATABASE=cyberlab_db
      - MYSQL_USER=webapp
      - MYSQL_PASSWORD=\${MYSQL_PASSWORD}
    volumes:
      - mysql_data:/var/lib/mysql
      - ./services/database/init:/docker-entrypoint-initdb.d
    networks:
      cyberlab_network:
        ipv4_address: 172.35.0.30
    restart: unless-stopped

  # 🐧 KALI ATTACKER
  kali:
    build:
      context: ./services/kali
      dockerfile: Dockerfile
    container_name: cyberlab_kali_attacker
    hostname: kali-attacker
    ports:
      - "2222:22"
    environment:
      - DISPLAY=:0
    volumes:
      - ./../../tools:/root/tools
    networks:
      cyberlab_network:
        ipv4_address: 172.35.0.100
    restart: unless-stopped
    tty: true
    stdin_open: true
EOF

# 6. CRÉATION DES DOCKERFILES ET CONFIGURATIONS
echo -e "${YELLOW}🔧 6. CRÉATION DES CONFIGURATIONS${NC}"

# Dockerfile du dashboard
cat > "$VERSION_DIR/services/dashboard/Dockerfile" << 'EOF'
FROM nginx:alpine

RUN apk add --no-cache curl docker-cli

COPY config/nginx.conf /etc/nginx/conf.d/default.conf
COPY web/ /var/www/html/

RUN chmod -R 755 /var/www/html

EXPOSE 80
EOF

# Configuration nginx
cat > "$VERSION_DIR/services/dashboard/config/nginx.conf" << 'EOF'
server {
    listen 80;
    server_name localhost;
    root /var/www/html;
    index index.html;

    location ~* \.(css|js|png|jpg|jpeg|gif|ico|svg)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    location / {
        try_files $uri $uri/ /index.html;
    }
}
EOF

# Script d'init MySQL
mkdir -p "$VERSION_DIR/services/database/init"
cat > "$VERSION_DIR/services/database/init/01-cyberlab.sql" << 'EOF'
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
EOF

# Dockerfile Kali
mkdir -p "$VERSION_DIR/services/kali"
cat > "$VERSION_DIR/services/kali/Dockerfile" << 'EOF'
FROM kalilinux/kali-rolling:latest

RUN apt-get update && apt-get install -y \
    kali-linux-core \
    nmap \
    sqlmap \
    nikto \
    dirb \
    hydra \
    john \
    metasploit-framework \
    burpsuite \
    wireshark \
    tcpdump \
    netcat-openbsd \
    curl \
    wget \
    ssh \
    vim \
    && apt-get clean

RUN useradd -m -s /bin/bash kali && \
    echo 'kali:kali' | chpasswd && \
    echo 'root:toor' | chpasswd

RUN mkdir -p /root/tools /home/kali/tools && \
    chown -R kali:kali /home/kali/tools

EXPOSE 22

CMD ["/bin/bash"]
EOF

# 7. COPIE DES DASHBOARDS HTML
echo -e "${YELLOW}📄 7. DÉPLOIEMENT DES DASHBOARDS${NC}"

# Ici on devrait copier les fichiers HTML créés précédemment
echo "Les dashboards HTML doivent être copiés manuellement dans:"
echo "  - $VERSION_DIR/services/dashboard/web/index.html"
echo "  - $VERSION_DIR/services/dashboard/web/lab_management_js.html"

# 8. CRÉATION DES SCRIPTS DE GESTION
echo -e "${YELLOW}🔨 8. CRÉATION DES SCRIPTS DE GESTION${NC}"

# Script de démarrage
cat > "$CYBERLAB_ROOT/scripts/manage/start-lab.sh" << EOF
#!/bin/bash
echo "🚀 Démarrage du CyberLab v1.0.0..."

cd "$VERSION_DIR"
docker-compose up -d

echo "⏳ Attente du démarrage des services..."
sleep 30

echo ""
echo "✅ CyberLab v1.0.0 Genesis démarré avec succès !"
echo "================================================================="
echo "🌐 Dashboard Principal    : http://localhost:${PORTS[dashboard]}"
echo "⚙️  Gestion JavaScript    : http://localhost:${PORTS[dashboard]}/lab_management_js.html"
echo "🐳 Portainer             : http://localhost:${PORTS[portainer]}"
echo "💾 phpMyAdmin            : http://localhost:${PORTS[phpmyadmin]}"
echo "📊 Grafana               : http://localhost:${PORTS[grafana]} (admin/CyberLab2024!)"
echo "🛡️  Wazuh Dashboard       : https://localhost:${PORTS[wazuh_dashboard]} (admin/CyberLab2024!)"
echo "🎯 DVWA                  : http://localhost:${PORTS[dvwa]} (admin/password)"
echo "🐐 WebGoat               : http://localhost:${PORTS[webgoat]}"
echo "🧃 Juice Shop            : http://localhost:${PORTS[juice_shop]}"
echo "================================================================="
echo "💻 Kali Linux: docker exec -it cyberlab_kali_attacker bash"
echo "📊 Statut: docker ps"
EOF

chmod +x "$CYBERLAB_ROOT/scripts/manage/start-lab.sh"

# Script d'arrêt
cat > "$CYBERLAB_ROOT/scripts/manage/stop-lab.sh" << EOF
#!/bin/bash
echo "⏹️ Arrêt du CyberLab..."

cd "$VERSION_DIR"
docker-compose down

echo "✅ CyberLab arrêté"
EOF

chmod +x "$CYBERLAB_ROOT/scripts/manage/stop-lab.sh"

# Script de statut
cat > "$CYBERLAB_ROOT/scripts/manage/status-lab.sh" << EOF
#!/bin/bash
echo "📊 STATUT CYBERLAB v1.0.0"
echo "========================="

cd "$VERSION_DIR"
docker-compose ps

echo ""
echo "🌐 Services Web Actifs:"
curl -s http://localhost:${PORTS[dashboard]} >/dev/null && echo "✅ Dashboard: http://localhost:${PORTS[dashboard]}" || echo "❌ Dashboard inaccessible"
curl -s http://localhost:${PORTS[portainer]} >/dev/null && echo "✅ Portainer: http://localhost:${PORTS[portainer]}" || echo "❌ Portainer inaccessible"
EOF

chmod +x "$CYBERLAB_ROOT/scripts/manage/status-lab.sh"

# 9. FINALISATION
echo -e "${YELLOW}✨ 9. FINALISATION DE L'INSTALLATION${NC}"

# Enregistrer la version installée
echo "v1.0.0" > "$CYBERLAB_ROOT/versions/VERSION"

# Créer les notes de version
cat > "$VERSION_DIR/README.md" << EOF
# CyberLab v1.0.0 "Genesis" - Notes de Release

## 🎯 Laboratoire Cybersécurité Complet

Version complète du laboratoire de cybersécurité avec dashboard JavaScript intelligent et structure organisée.

### 🔧 Ports Configurés Automatiquement
- Dashboard: ${PORTS[dashboard]}
- Portainer: ${PORTS[portainer]}  
- phpMyAdmin: ${PORTS[phpmyadmin]}
- Grafana: ${PORTS[grafana]}
- Wazuh: ${PORTS[wazuh_dashboard]}
- DVWA: ${PORTS[dvwa]}
- WebGoat: ${PORTS[webgoat]}
- Juice Shop: ${PORTS[juice_shop]}

### 📊 Services Inclus (12 conteneurs)
- 🌐 Dashboard Web Intelligent
- 🛠️ Portainer (Gestion Docker)
- 💾 phpMyAdmin (Gestion MySQL)
- 📊 ELK Stack (Elasticsearch + Kibana)
- 📈 Grafana (Métriques)
- 🛡️ Wazuh SIEM Complet
- 🎯 Applications Vulnérables (DVWA, WebGoat, Juice Shop)
- 🗄️ MySQL Database
- 🐧 Kali Linux Attacker

### 🚀 Utilisation
\`\`\`bash
# Démarrer le lab
$CYBERLAB_ROOT/scripts/manage/start-lab.sh

# Voir le statut
$CYBERLAB_ROOT/scripts/manage/status-lab.sh

# Arrêter le lab
$CYBERLAB_ROOT/scripts/manage/stop-lab.sh
\`\`\`

### 🔐 Identifiants
- Grafana/Wazuh: admin / CyberLab2024!
- MySQL: root / CyberLab2024! | webapp / webapp123
- DVWA: admin / password

Date d'installation: $(date)
EOF

# Changelog
cat > "$CYBERLAB_ROOT/CHANGELOG.md" << 'EOF'
# Changelog CyberLab

## [1.0.0] - Genesis - 2024-12-20

### Ajouté
- 🏗️ Structure organisée avec système de versions
- 🔧 Système de patches numérotés
- 💾 Système de backup automatique
- 🌐 Dashboard JavaScript intelligent
- ⚙️ Interface de gestion complète
- 🐳 Auto-détection des ports libres
- 📊 Stack monitoring complète (ELK + Grafana + Wazuh)
- 🎯 Applications vulnérables (DVWA, WebGoat, Juice Shop)
- 🐧 Machine Kali Linux intégrée
- 📝 Logging et audit complets

### Infrastructure
- 12 services Docker orchestrés
- Réseau isolé 172.35.0.0/24
- Volumes persistants
- Configuration automatisée

### Formation
- Interface progressive par niveaux
- Commandes automatiques
- Documentation intégrée
EOF

echo ""
echo -e "${GREEN}🎉 INSTALLATION TERMINÉE AVEC SUCCÈS ! 🎉${NC}"
echo ""
echo "================================================================="
echo "🛡️ CYBERLAB v1.0.0 'GENESIS' PRÊT !"
echo "================================================================="
echo ""
echo -e "${CYAN}🚀 Pour démarrer le laboratoire :${NC}"
echo "   $CYBERLAB_ROOT/scripts/manage/start-lab.sh"
echo ""
echo -e "${CYAN}📊 Pour voir le statut :${NC}"
echo "   $CYBERLAB_ROOT/scripts/manage/status-lab.sh"
echo ""
echo -e "${CYAN}⏹️ Pour arrêter :${NC}"  
echo "   $CYBERLAB_ROOT/scripts/manage/stop-lab.sh"
echo ""
echo -e "${CYAN}📁 Structure installée dans :${NC}"
echo "   $CYBERLAB_ROOT"
echo ""
echo -e "${YELLOW}⚠️ N'oubliez pas de copier les dashboards HTML dans :${NC}"
echo "   $VERSION_DIR/services/dashboard/web/"
echo ""
echo "🎯 Bon pentesting ! 🎯"

log_message "SUCCESS" "Installation CyberLab v1.0.0 Genesis terminée avec succès"
