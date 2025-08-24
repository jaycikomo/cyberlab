#!/bin/bash
echo "🚀 Démarrage du CyberLab v1.0.0..."

cd "/root/cyberlab/versions/v1.0.0"
docker-compose up -d

echo "⏳ Attente du démarrage des services..."
sleep 30

echo ""
echo "✅ CyberLab v1.0.0 Genesis démarré avec succès !"
echo "================================================================="
echo "🌐 Dashboard Principal    : http://localhost:8080"
echo "⚙️  Gestion JavaScript    : http://localhost:8080/lab_management_js.html"
echo "🐳 Portainer             : http://localhost:9000"
echo "💾 phpMyAdmin            : http://localhost:8090"
echo "📊 Grafana               : http://localhost:3000 (admin/CyberLab2024!)"
echo "🛡️  Wazuh Dashboard       : https://localhost:5443 (admin/CyberLab2024!)"
echo "🎯 DVWA                  : http://localhost:8081 (admin/password)"
echo "🐐 WebGoat               : http://localhost:8082"
echo "🧃 Juice Shop            : http://localhost:8083"
echo "================================================================="
echo "💻 Kali Linux: docker exec -it cyberlab_kali_attacker bash"
echo "📊 Statut: docker ps"
