#!/bin/bash
echo "📊 STATUT CYBERLAB v1.0.0"
echo "========================="

cd "/root/cyberlab/versions/v1.0.0"
docker-compose ps

echo ""
echo "🌐 Services Web Actifs:"
curl -s http://localhost:8080 >/dev/null && echo "✅ Dashboard: http://localhost:8080" || echo "❌ Dashboard inaccessible"
curl -s http://localhost:9000 >/dev/null && echo "✅ Portainer: http://localhost:9000" || echo "❌ Portainer inaccessible"
