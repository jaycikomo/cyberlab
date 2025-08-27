# CyberLab Genesis

Laboratoire de cybersécurité containerisé avec 13 services intégrés pour l'apprentissage et la pratique.

## Prérequis Système

- **8 GB RAM minimum** recommandé
- **10 GB d'espace disque libre**
- **Connexion Internet** pour télécharger les images Docker
- **Ports libres** : 8080, 9000, 3306, 5601, 3000, 8081, 8090, 9200, 1514, 1515, 55000

## Installation des Prérequis

### Windows

#### Installation Docker Desktop
1. **Télécharger Docker Desktop :**
   - Aller sur https://www.docker.com/products/docker-desktop
   - Télécharger "Docker Desktop for Windows"
   - Exécuter le fichier .exe téléchargé

2. **Installation :**
   - Cocher "Use WSL 2 instead of Hyper-V" si proposé
   - Suivre l'assistant d'installation
   - Redémarrer Windows si demandé

3. **Vérification :**
   ```powershell
   # Ouvrir PowerShell et taper :
   docker --version
   docker-compose --version
   ```

#### Installation Git pour Windows
1. **Télécharger Git :**
   - Aller sur https://git-scm.com/download/win
   - Télécharger la version 64-bit

2. **Installation :**
   - Exécuter le fichier .exe
   - Accepter les paramètres par défaut
   - Choisir "Use Git from the Windows Command Prompt"

3. **Vérification :**
   ```powershell
   git --version
   ```

### macOS

#### Installation Docker Desktop
1. **Télécharger :**
   - Aller sur https://www.docker.com/products/docker-desktop
   - Télécharger "Docker Desktop for Mac"

2. **Installation :**
   - Ouvrir le fichier .dmg téléchargé
   - Glisser Docker dans le dossier Applications
   - Lancer Docker Desktop depuis Applications

3. **Vérification :**
   ```bash
   # Ouvrir Terminal et taper :
   docker --version
   docker-compose --version
   ```

#### Installation Git pour macOS
**Option 1: Avec Homebrew (recommandé)**
```bash
# Installer Homebrew si pas encore fait
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Installer Git
brew install git
```

**Option 2: Téléchargement direct**
```bash
# Git est souvent pré-installé, vérifier :
git --version

# Si absent, télécharger sur https://git-scm.com/download/mac
```

### Linux (Ubuntu/Debian)

#### Installation complète
```bash
# Mettre à jour le système
sudo apt update && sudo apt upgrade -y

# Installer Git
sudo apt install git -y

# Installer les prérequis pour Docker
sudo apt install ca-certificates curl gnupg lsb-release -y

# Ajouter la clé GPG officielle de Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Ajouter le repository Docker
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Mettre à jour les packages
sudo apt update

# Installer Docker et Docker Compose
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

# Ajouter l'utilisateur au groupe docker
sudo usermod -aG docker $USER

# Recharger les groupes (ou redémarrer la session)
newgrp docker

# Démarrer et activer Docker
sudo systemctl start docker
sudo systemctl enable docker
```

#### Vérification Linux
```bash
# Vérifier les installations
git --version
docker --version
docker compose version

# Tester Docker sans sudo
docker run hello-world
```

### Linux (CentOS/RHEL/Fedora)

#### Installation CentOS/RHEL
```bash
# Mettre à jour le système
sudo yum update -y

# Installer Git
sudo yum install git -y

# Installer Docker
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

# Démarrer Docker
sudo systemctl start docker
sudo systemctl enable docker

# Ajouter l'utilisateur au groupe docker
sudo usermod -aG docker $USER
newgrp docker
```

#### Installation Fedora
```bash
# Mettre à jour le système
sudo dnf update -y

# Installer Git
sudo dnf install git -y

# Installer Docker
sudo dnf install docker docker-compose -y

# Démarrer Docker
sudo systemctl start docker
sudo systemctl enable docker

# Ajouter l'utilisateur au groupe docker
sudo usermod -aG docker $USER
newgrp docker
```

## Installation du Laboratoire

Une fois Docker, Docker Compose et Git installés sur votre système, vous pouvez déployer le laboratoire.

### Linux / macOS
```bash
# Cloner le repository
git clone https://github.com/jaycikomo/cyberlab.git

# Aller dans le répertoire
cd cyberlab/versions/v1.0.0/

# Lancer le laboratoire (première installation - peut prendre 10-15 minutes)
docker-compose up --build -d

# Vérifier l'état des services
docker-compose ps
```

### Windows

#### Option 1: PowerShell (Windows natif)
```powershell
# Ouvrir PowerShell en tant qu'administrateur
# Cloner le repository
git clone https://github.com/jaycikomo/cyberlab.git

# Aller dans le répertoire
cd cyberlab\versions\v1.0.0\

# Lancer le laboratoire
docker-compose up --build -d

# Vérifier l'état des services
docker-compose ps
```

#### Option 2: WSL2 (Windows Subsystem for Linux - RECOMMANDÉ)

**Qu'est-ce que WSL2 ?**
WSL2 est un sous-système Linux natif dans Windows 10/11. Il permet d'exécuter un environnement Linux complet directement dans Windows, offrant de meilleures performances pour Docker.

**Installation WSL2 :**

1. **Activer WSL dans Windows :**
   ```powershell
   # Dans PowerShell administrateur
   dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
   dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
   ```

2. **Redémarrer Windows**, puis définir WSL2 par défaut :
   ```powershell
   wsl --set-default-version 2
   ```

3. **Installer Ubuntu depuis Microsoft Store :**
   - Ouvrir le Microsoft Store
   - Rechercher "Ubuntu 22.04 LTS"
   - Installer et lancer

4. **Configuration initiale Ubuntu :**
   ```bash
   # Au premier lancement, créer utilisateur/mot de passe
   # Mettre à jour le système
   sudo apt update && sudo apt upgrade -y
   
   # Installer Git si nécessaire
   sudo apt install git -y
   ```

**Utilisation WSL2 pour le laboratoire :**

1. **Ouvrir le terminal WSL :**
   - Taper `wsl` dans le menu Démarrer, ou
   - Ouvrir l'application Ubuntu installée

2. **Cloner et lancer le laboratoire :**
   ```bash
   # Dans le terminal Ubuntu/WSL2
   git clone https://github.com/jaycikomo/cyberlab.git
   
   # Naviguer dans le répertoire
   cd cyberlab/versions/v1.0.0/
   
   # Lancer tous les services
   docker-compose up --build -d
   
   # Vérifier que tous les conteneurs sont démarrés
   docker-compose ps
   
   # Voir les logs en temps réel (optionnel)
   docker-compose logs -f
   ```

3. **Accéder aux services :**
   Les services seront accessibles depuis Windows via :
   - http://localhost:8080 (Dashboard)
   - http://localhost:9000 (Portainer)
   - etc.

### Linux / macOS
```bash
# Cloner le repository
git clone https://github.com/jaycikomo/cyberlab.git

# Aller dans le répertoire
cd cyberlab/versions/v1.0.0/

# Lancer le laboratoire
docker-compose up --build -d

# Vérifier l'état des services
docker-compose ps
```

### Windows

#### Option 1: PowerShell (Windows natif)
```powershell
# Ouvrir PowerShell en tant qu'administrateur
# Cloner le repository
git clone https://github.com/jaycikomo/cyberlab.git

# Aller dans le répertoire
cd cyberlab\versions\v1.0.0\

# Lancer le laboratoire
docker-compose up --build -d

# Vérifier l'état des services
docker-compose ps
```

#### Option 2: WSL2 (Windows Subsystem for Linux - RECOMMANDÉ)

**Qu'est-ce que WSL2 ?**
WSL2 est un sous-système Linux natif dans Windows 10/11. Il permet d'exécuter un environnement Linux complet directement dans Windows, offrant de meilleures performances pour Docker.

**Installation WSL2 :**

1. **Activer WSL dans Windows :**
   ```powershell
   # Dans PowerShell administrateur
   dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
   dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
   ```

2. **Redémarrer Windows**, puis définir WSL2 par défaut :
   ```powershell
   wsl --set-default-version 2
   ```

3. **Installer Ubuntu depuis Microsoft Store :**
   - Ouvrir le Microsoft Store
   - Rechercher "Ubuntu 22.04 LTS"
   - Installer et lancer

4. **Configuration initiale Ubuntu :**
   ```bash
   # Au premier lancement, créer utilisateur/mot de passe
   # Mettre à jour le système
   sudo apt update && sudo apt upgrade -y
   
   # Installer Git si nécessaire
   sudo apt install git -y
   ```

**Utilisation WSL2 pour le laboratoire :**

1. **Ouvrir le terminal WSL :**
   - Taper `wsl` dans le menu Démarrer, ou
   - Ouvrir l'application Ubuntu installée

2. **Cloner et lancer le laboratoire :**
   ```bash
   # Dans le terminal Ubuntu/WSL2
   git clone https://github.com/jaycikomo/cyberlab.git
   
   # Naviguer dans le répertoire
   cd cyberlab/versions/v1.0.0/
   
   # Lancer tous les services
   docker-compose up --build -d
   
   # Vérifier que tous les conteneurs sont démarrés
   docker-compose ps
   
   # Voir les logs en temps réel (optionnel)
   docker-compose logs -f
   ```

3. **Accéder aux services :**
   Les services seront accessibles depuis Windows via :
   - http://localhost:8080 (Dashboard)
   - http://localhost:9000 (Portainer)
   - etc.

## Accès au Laboratoire

Une fois tous les conteneurs démarrés :

- **Dashboard Principal** : http://localhost:8080
- **Portainer (Gestion Docker)** : http://localhost:9000
- **Kali Linux** : `docker exec -it cyberlab_kali_attacker /bin/bash`

## Services Disponibles

| Service | URL | Description |
|---------|-----|-------------|
| Dashboard | http://localhost:8080 | Interface principale du lab |
| Portainer | http://localhost:9000 | Gestion des conteneurs Docker |
| DVWA | http://localhost:8081 | Damn Vulnerable Web Application |
| WebGoat | http://localhost:8080/WebGoat | Plateforme d'apprentissage OWASP |
| Juice Shop | http://localhost:3000 | Application e-commerce vulnérable |
| Kibana | http://localhost:5601 | Visualisation des logs Elasticsearch |
| Grafana | http://localhost:3000 | Monitoring et métriques |
| phpMyAdmin | http://localhost:8090 | Administration MySQL |
| Wazuh | http://localhost:443 | SIEM et détection d'intrusions |

## Installation Docker, Docker Compose et Git

### Windows

#### Installation Docker Desktop
1. **Télécharger Docker Desktop :**
   - Aller sur https://www.docker.com/products/docker-desktop
   - Télécharger "Docker Desktop for Windows"
   - Exécuter le fichier .exe téléchargé

2. **Installation :**
   - Cocher "Use WSL 2 instead of Hyper-V" si proposé
   - Suivre l'assistant d'installation
   - Redémarrer Windows si demandé

3. **Vérification :**
   ```powershell
   # Ouvrir PowerShell et taper :
   docker --version
   docker-compose --version
   ```

#### Installation Git pour Windows
1. **Télécharger Git :**
   - Aller sur https://git-scm.com/download/win
   - Télécharger la version 64-bit

2. **Installation :**
   - Exécuter le fichier .exe
   - Accepter les paramètres par défaut
   - Choisir "Use Git from the Windows Command Prompt"

3. **Vérification :**
   ```powershell
   git --version
   ```

### macOS

#### Installation Docker Desktop
1. **Télécharger :**
   - Aller sur https://www.docker.com/products/docker-desktop
   - Télécharger "Docker Desktop for Mac"

2. **Installation :**
   - Ouvrir le fichier .dmg téléchargé
   - Glisser Docker dans le dossier Applications
   - Lancer Docker Desktop depuis Applications

3. **Vérification :**
   ```bash
   # Ouvrir Terminal et taper :
   docker --version
   docker-compose --version
   ```

#### Installation Git pour macOS
**Option 1: Avec Homebrew (recommandé)**
```bash
# Installer Homebrew si pas encore fait
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Installer Git
brew install git
```

**Option 2: Téléchargement direct**
```bash
# Git est souvent pré-installé, vérifier :
git --version

# Si absent, télécharger sur https://git-scm.com/download/mac
```

### Linux (Ubuntu/Debian)

#### Installation complète
```bash
# Mettre à jour le système
sudo apt update && sudo apt upgrade -y

# Installer Git
sudo apt install git -y

# Installer les prérequis pour Docker
sudo apt install ca-certificates curl gnupg lsb-release -y

# Ajouter la clé GPG officielle de Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Ajouter le repository Docker
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Mettre à jour les packages
sudo apt update

# Installer Docker et Docker Compose
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

# Ajouter l'utilisateur au groupe docker
sudo usermod -aG docker $USER

# Recharger les groupes (ou redémarrer la session)
newgrp docker

# Démarrer et activer Docker
sudo systemctl start docker
sudo systemctl enable docker
```

#### Vérification Linux
```bash
# Vérifier les installations
git --version
docker --version
docker compose version

# Tester Docker sans sudo
docker run hello-world
```

### Linux (CentOS/RHEL/Fedora)

#### Installation CentOS/RHEL
```bash
# Mettre à jour le système
sudo yum update -y

# Installer Git
sudo yum install git -y

# Installer Docker
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

# Démarrer Docker
sudo systemctl start docker
sudo systemctl enable docker

# Ajouter l'utilisateur au groupe docker
sudo usermod -aG docker $USER
newgrp docker
```

#### Installation Fedora
```bash
# Mettre à jour le système
sudo dnf update -y

# Installer Git
sudo dnf install git -y

# Installer Docker
sudo dnf install docker docker-compose -y

# Démarrer Docker
sudo systemctl start docker
sudo systemctl enable docker

# Ajouter l'utilisateur au groupe docker
sudo usermod -aG docker $USER
newgrp docker
```

## Utilisation

### Démarrer le lab
```bash
docker-compose up -d
```

### Arrêter le lab
```bash
docker-compose down
```

### Voir les logs d'un service
```bash
docker-compose logs [nom-service]
```

### Redémarrer un service
```bash
docker-compose restart [nom-service]
```

## Dépannage

### Erreur de port déjà utilisé
```bash
# Voir les ports utilisés
netstat -tulpn | grep :8080

# Modifier le port dans docker-compose.yml si nécessaire
# Exemple: "8081:80" au lieu de "8080:80"
```

### Conteneurs qui ne démarrent pas
```bash
# Voir les logs détaillés
docker-compose logs

# Reconstruire les images
docker-compose build --no-cache
docker-compose up -d
```

### Problème de permissions (Linux)
```bash
# Ajouter l'utilisateur au groupe docker
sudo usermod -aG docker $USER
newgrp docker
```

### Manque de mémoire
- Fermer les applications non nécessaires
- Augmenter la mémoire allouée à Docker Desktop
- Désactiver temporairement certains services dans docker-compose.yml

## Structure du Projet

```
cyberlab/
├── versions/v1.0.0/
│   ├── docker-compose.yml          # Configuration des services
│   ├── .env                        # Variables d'environnement
│   └── services/
│       ├── dashboard/              # Interface web principale
│       │   ├── Dockerfile
│       │   └── web/                # Pages HTML
│       ├── kali/                   # Machine d'attaque Kali Linux
│       └── database/               # Configuration base de données
└── backups/                        # Sauvegardes de développement
```

## Sécurité

Ce laboratoire contient des applications intentionnellement vulnérables. 

**IMPORTANT** :
- Utiliser uniquement dans un environnement isolé
- Ne pas exposer sur Internet
- Désactiver le laboratoire après utilisation

## Support

Pour signaler un problème ou une amélioration :
1. Vérifier les [issues existantes](https://github.com/jaycikomo/cyberlab/issues)
2. Créer une nouvelle issue avec les détails de votre environnement

## Licence

Usage éducatif et formation en cybersécurité uniquement.
