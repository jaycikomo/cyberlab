#!/bin/bash
echo "⏹️ Arrêt du CyberLab..."

cd "/root/cyberlab/versions/v1.0.0"
docker-compose down

echo "✅ CyberLab arrêté"
