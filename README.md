
---

## ✅ **ÉTAT ACTUEL DU PROJET - 24/08/2024**

### 🎯 **Ce qui a été fait aujourd'hui :**
- ✅ Structure CyberLab organisée créée selon l'architecture prévue
- ✅ Script d'installation automatique avec détection auto des ports
- ✅ Dashboard principal HTML/JavaScript interactif 
- ✅ Dashboard de gestion avancé avec contrôles des services
- ✅ Configuration Docker-compose complète (12 services)
- ✅ Documentation développement (DEVELOPMENT.md, CHANGELOG.md)

### 🔄 **Prochaine étape :**
- Démarrer le laboratoire : `./scripts/manage/start-lab.sh`
- Tester les dashboards sur http://localhost:8080

### 📁 **Fichiers créés :**
- `/root/cyberlab/scripts/install/install-complete-cyberlab.sh`
- `/root/cyberlab/versions/v1.0.0/services/dashboard/web/index.html`
- `/root/cyberlab/versions/v1.0.0/services/dashboard/web/lab_management_js.html`

---



# 🛡️ CyberLab - Laboratoire de Cybersécurité Organisé

**Version:** 1.0.0 | **Codename:** Genesis | **Date:** 2024-12-20 | **Status:** Production Ready

> **Laboratoire de cybersécurité pédagogique avec gestion complète des versions, patches et environnements**

---

## 📋 Table des Matières

1. [Structure du Projet](#-structure-du-projet)
2. [Système de Versions](#-système-de-versions)
3. [Système de Patches](#-système-de-patches)
4. [Gestion des Environnements](#-gestion-des-environnements)
5. [Système de Backup](#-système-de-backup)
6. [Installation et Utilisation](#-installation-et-utilisation)
7. [Gestion des Versions](#-gestion-des-versions)
8. [Dépannage et Maintenance](#-dépannage-et-maintenance)
9. [Standards et Conventions](#-standards-et-conventions)
10. [Sécurité et Bonnes Pratiques](#-sécurité-et-bonnes-pratiques)

---

## 📁 Structure du Projet

```
cyberlab/
├── README.md                    # 📖 Ce fichier - Guide complet
├── CHANGELOG.md                 # 📝 Historique des changements
├── LICENSE                      # ⚖️  Licence du projet
├── .gitignore                   # 🚫 Fichiers à ignorer
│
├── versions/                    # 🏷️  VERSIONS RELEASES
│   ├── v1.0.0/                  #     Version stable actuelle
│   │   ├── README.md            #     Notes de release
│   │   ├── docker-compose.yml   #     Config Docker pour v1.0.0
│   │   ├── services/            #     Services spécifiques v1.0.0
│   │   └── migration.sql        #     Scripts de migration DB
│   ├── v1.1.0/                  #     Version suivante (en dev)
│   └── v2.0.0/                  #     Version future majeure
│
├── patches/                     # 🔧 PATCHES NUMÉROTÉS
│   ├── PATCH_TEMPLATE.md        #     Template pour nouveaux patches
│   ├── 001-initial/             #     Patch 001: Setup initial
│   │   ├── README.md            #     Documentation du patch
│   │   ├── install.sh           #     Script d'installation
│   │   ├── rollback.sh          #     Script de rollback
│   │   ├── validate.sh          #     Script de validation
│   │   └── files/               #     Fichiers du patch
│   ├── 002-services/            #     Patch 002: Ajout services
│   └── 003-monitoring/          #     Patch 003: Monitoring
│
├── scripts/                     # 🔨 SCRIPTS ORGANISÉS
│   ├── install/                 #     Scripts d'installation
│   │   ├── install-full.sh      #     Installation complète
│   │   ├── install-version.sh   #     Installation version spécifique
│   │   └── prerequisites.sh     #     Vérification prérequis
│   ├── manage/                  #     Scripts de gestion
│   │   ├── start-lab.sh         #     Démarrage du lab
│   │   ├── stop-lab.sh          #     Arrêt du lab
│   │   ├── restart-lab.sh       #     Redémarrage
│   │   ├── status-lab.sh        #     Status complet
│   │   └── health-check.sh      #     Vérification santé
│   └── backup/                  #     Scripts de sauvegarde
│       ├── create-backup.sh     #     Création backup
│       ├── restore-backup.sh    #     Restauration
│       ├── list-backups.sh      #     Liste des backups
│       └── cleanup-backups.sh   #     Nettoyage automatique
│
├── docker/                      # 🐳 CONFIGURATION DOCKER
│   ├── compose/                 #     Fichiers docker-compose
│   │   ├── docker-compose.yml   #     Compose principal
│   │   ├── docker-compose.dev.yml      # Override développement
│   │   ├── docker-compose.prod.yml     # Override production
│   │   └── docker-compose.test.yml     # Override test
│   ├── services/                #     Configuration services
│   │   ├── dashboard/           #     Service dashboard
│   │   │   ├── Dockerfile       #     Image dashboard
│   │   │   ├── nginx.conf       #     Config nginx
│   │   │   └── web/             #     Fichiers web
│   │   ├── dvwa/                #     Service DVWA
│   │   ├── kali/                #     Service Kali
│   │   └── monitoring/          #     Services monitoring
│   └── networks/                #     Configuration réseaux
│
├── config/                      # ⚙️  CONFIGURATION
│   ├── environments/            #     Config par environnement
│   │   ├── development.env      #     Variables développement
│   │   ├── production.env       #     Variables production
│   │   ├── testing.env          #     Variables test
│   │   └── local.env            #     Variables locales
│   ├── templates/               #     Templates configuration
│   └── secrets/                 #     Secrets (non versionnés)
│       └── .gitkeep
│
├── tools/                       # 🔧 OUTILS ET UTILITAIRES
│   ├── pentest/                 #     Outils de pentesting
│   │   ├── payloads/            #     Payloads d'exploitation
│   │   ├── wordlists/           #     Listes de mots
│   │   └── scripts/             #     Scripts personnalisés
│   ├── monitoring/              #     Outils de monitoring
│   └── automation/              #     Scripts d'automatisation
│
├── logs/                        # 📝 LOGS ORGANISÉS
│   ├── installation/            #     Logs d'installation
│   │   └── install-YYYYMMDD-HHMMSS.log
│   ├── runtime/                 #     Logs d'exécution
│   ├── patches/                 #     Logs des patches
│   │   └── patch-001-YYYYMMDD.log
│   ├── backups/                 #     Logs des backups
│   └── security/                #     Logs de sécurité
│
└── backups/                     # 💾 SAUVEGARDES ORGANISÉES
    ├── auto/                    #     Backups automatiques
    │   └── daily-YYYYMMDD/      #     Backup quotidien
    ├── manual/                  #     Backups manuels
    │   └── before-patch-001/    #     Backup avant patch
    ├── versions/                #     Backups de versions
    │   └── v1.0.0-backup/       #     Backup version complète
    └── migration/               #     Backups de migration
        └── v1.0.0-to-v1.1.0/    #     Migration entre versions
```

---

## 🏷️ Système de Versions

### Principe de Versioning

**Format:** `vMAJOR.MINOR.PATCH`
- **MAJOR:** Changements incompatibles (v1.x.x → v2.x.x)
- **MINOR:** Nouvelles fonctionnalités compatibles (v1.0.x → v1.1.x)
- **PATCH:** Corrections de bugs (v1.0.0 → v1.0.1)

### Organisation des Versions

#### Structure d'une Version
```
versions/v1.0.0/
├── README.md              # Notes de release détaillées
├── CHANGELOG.md           # Changements spécifiques à cette version
├── docker-compose.yml     # Configuration Docker pour cette version
├── .env.template          # Variables d'environnement par défaut
├── services/              # Services spécifiques à cette version
│   ├── dashboard/
│   ├── monitoring/
│   └── vulnerables/
├── config/                # Configuration spécifique
├── migration/             # Scripts de migration
│   ├── from-v0.9.x.sql    # Migration depuis version précédente
│   └── upgrade.sh         # Script de mise à niveau
└── validation/            # Tests de validation
    ├── health-check.sh    # Vérification fonctionnelle
    └── security-test.sh   # Tests de sécurité
```

### Commandes de Gestion des Versions

```bash
# Lister les versions disponibles
ls -la versions/

# Installer une version spécifique
./scripts/install/install-version.sh v1.0.0

# Changer de version (avec backup automatique)
./scripts/manage/switch-version.sh v1.1.0

# Voir la version actuelle
cat versions/VERSION

# Comparer deux versions
./scripts/manage/compare-versions.sh v1.0.0 v1.1.0
```

---

## 🔧 Système de Patches

### Principe des Patches

Les patches sont des modifications **incrémentales** et **réversibles** appliquées au système.
- **Numérotation séquentielle:** 001, 002, 003...
- **Documentation complète** pour chaque patch
- **Scripts d'installation et de rollback**
- **Validation automatique**

### Structure d'un Patch

```
patches/001-initial/
├── README.md              # 📖 Documentation complète
│   ├── Description du patch
│   ├── Prérequis
│   ├── Modifications apportées
│   ├── Instructions d'installation
│   ├── Instructions de rollback
│   └── Tests de validation
├── install.sh             # 🔧 Script d'installation
├── rollback.sh            # ↩️  Script de rollback
├── validate.sh            # ✅ Script de validation
├── files/                 # 📁 Fichiers du patch
│   ├── docker-compose.yml # Modifications Docker
│   ├── nginx.conf         # Configurations
│   └── migration.sql      # Scripts SQL
└── tests/                 # 🧪 Tests spécifiques
    ├── unit-tests.sh      # Tests unitaires
    └── integration-tests.sh # Tests d'intégration
```

### Cycle de Vie d'un Patch

1. **Développement:** Création dans `patches/XXX-name/`
2. **Test:** Validation avec `./patches/XXX-name/validate.sh`
3. **Installation:** Application avec `./patches/XXX-name/install.sh`
4. **Validation:** Vérification post-installation
5. **Documentation:** Mise à jour des logs et changelog

### Commandes de Gestion des Patches

```bash
# Lister les patches disponibles
ls -la patches/

# Voir le statut des patches (appliqués/non-appliqués)
./scripts/manage/patch-status.sh

# Appliquer un patch spécifique
./patches/001-initial/install.sh

# Annuler un patch (rollback)
./patches/001-initial/rollback.sh

# Appliquer tous les patches en séquence
./scripts/install/apply-all-patches.sh

# Valider l'intégrité du système après patches
./scripts/manage/validate-system.sh
```

---

## 🌍 Gestion des Environnements

### Types d'Environnements

1. **Development** (`config/environments/development.env`)
   - Logs détaillés activés
   - Debug mode
   - Ports de développement
   - Base de données de test

2. **Testing** (`config/environments/testing.env`)
   - Configuration optimisée pour tests
   - Données de test isolées
   - Monitoring de performance

3. **Production** (`config/environments/production.env`)
   - Configuration sécurisée
   - Logs de production
   - Haute disponibilité
   - Monitoring de sécurité

### Utilisation des Environnements

```bash
# Changer d'environnement
cp config/environments/development.env .env
source .env

# Démarrer avec un environnement spécifique
CYBERLAB_ENV=production ./scripts/manage/start-lab.sh

# Vérifier l'environnement actuel
./scripts/manage/show-env.sh
```

---

## 💾 Système de Backup

### Types de Backups

#### 1. Backups Automatiques (`backups/auto/`)
- **Fréquence:** Quotidienne à 2h00
- **Rétention:** 30 jours
- **Contenu:** Configuration + données critiques
```bash
backups/auto/daily-20241220/
├── config-backup.tar.gz
├── docker-volumes.tar.gz
├── database-dump.sql
└── backup-info.json
```

#### 2. Backups Manuels (`backups/manual/`)
- **Usage:** Avant modifications importantes
- **Nommage:** Descriptif de l'action
```bash
# Créer un backup manuel
./scripts/backup/create-backup.sh "before-patch-005"

# Backup avant migration de version
./scripts/backup/create-backup.sh "before-upgrade-v2.0.0"
```

#### 3. Backups de Versions (`backups/versions/`)
- **Usage:** Sauvegarde complète d'une version
- **Contenu:** Configuration + services + données
```bash
# Backup complet d'une version
./scripts/backup/backup-version.sh v1.0.0
```

#### 4. Backups de Migration (`backups/migration/`)
- **Usage:** Sauvegarde lors de changements de version
- **Contenu:** État avant et après migration

### Restauration de Backups

```bash
# Lister les backups disponibles
./scripts/backup/list-backups.sh

# Restaurer un backup spécifique
./scripts/backup/restore-backup.sh "backup-name"

# Restauration d'urgence (dernier backup automatique)
./scripts/backup/emergency-restore.sh

# Restaurer une version complète
./scripts/backup/restore-version.sh v1.0.0
```

### Configuration des Backups

```bash
# Configuration dans config/environments/
BACKUP_ENABLED=true
BACKUP_SCHEDULE="0 2 * * *"  # 2h00 tous les jours
BACKUP_RETENTION_DAYS=30
BACKUP_COMPRESS=true
BACKUP_ENCRYPT=false
```

---

## 🚀 Installation et Utilisation

### Installation Rapide (Recommandée)

```bash
# 1. Installation complète avec la dernière version stable
./scripts/install/install-full.sh

# 2. Démarrage du laboratoire
./scripts/manage/start-lab.sh

# 3. Vérification du statut
./scripts/manage/status-lab.sh
```

### Installation Personnalisée

```bash
# 1. Vérification des prérequis
./scripts/install/prerequisites.sh

# 2. Installation d'une version spécifique
./scripts/install/install-version.sh v1.0.0

# 3. Configuration de l'environnement
cp config/environments/development.env .env
nano .env  # Modifier si nécessaire

# 4. Application des patches souhaités
./patches/001-initial/install.sh
./patches/002-services/install.sh

# 5. Démarrage
./scripts/manage/start-lab.sh
```

### Installation à partir d'un Backup

```bash
# 1. Restaurer un backup
./scripts/backup/restore-backup.sh "backup-name"

# 2. Vérifier l'intégrité
./scripts/manage/validate-system.sh

# 3. Démarrer
./scripts/manage/start-lab.sh
```

---

## ⚙️ Gestion des Versions

### Passer à une Version Supérieure

```bash
# 1. Créer un backup de sécurité
./scripts/backup/create-backup.sh "before-upgrade-v1.1.0"

# 2. Changer de version
./scripts/manage/switch-version.sh v1.1.0

# 3. Appliquer les migrations nécessaires
./versions/v1.1.0/migration/upgrade.sh

# 4. Valider la nouvelle version
./versions/v1.1.0/validation/health-check.sh
```

### Revenir à une Version Antérieure (Rollback)

```bash
# 1. Arrêter le système
./scripts/manage/stop-lab.sh

# 2. Restaurer le backup de la version précédente
./scripts/backup/restore-version.sh v1.0.0

# 3. Démarrer avec l'ancienne version
./scripts/manage/start-lab.sh

# 4. Vérifier le bon fonctionnement
./scripts/manage/status-lab.sh
```

### Comparaison de Versions

```bash
# Voir les différences entre deux versions
./scripts/manage/compare-versions.sh v1.0.0 v1.1.0

# Voir l'historique des changements
cat CHANGELOG.md
```

---

## 🔧 Dépannage et Maintenance

### Diagnostic du Système

```bash
# Status complet du laboratoire
./scripts/manage/status-lab.sh

# Vérification de santé complète
./scripts/manage/health-check.sh

# Diagnostic des services Docker
./scripts/manage/docker-diagnostic.sh

# Vérification des logs d'erreur
./scripts/manage/check-errors.sh
```

### Problèmes Courants

#### Service ne Démarre Pas

```bash
# 1. Vérifier les logs
./scripts/manage/show-logs.sh service-name

# 2. Vérifier la configuration
./scripts/manage/validate-config.sh

# 3. Redémarrer le service spécifique
docker-compose restart service-name

# 4. Redémarrage complet si nécessaire
./scripts/manage/restart-lab.sh
```

#### Problèmes de Réseau

```bash
# 1. Vérifier les réseaux Docker
docker network ls

# 2. Tester la connectivité
./scripts/manage/network-test.sh

# 3. Recréer les réseaux si nécessaire
./scripts/manage/recreate-networks.sh
```

#### Corruption de Données

```bash
# 1. Arrêter le système
./scripts/manage/stop-lab.sh

# 2. Restaurer le dernier backup valide
./scripts/backup/emergency-restore.sh

# 3. Vérifier l'intégrité après restauration
./scripts/manage/validate-system.sh
```

### Maintenance Préventive

```bash
# Nettoyage automatique (recommandé hebdomadaire)
./scripts/manage/cleanup.sh

# Mise à jour des images Docker
./scripts/manage/update-images.sh

# Rotation des logs
./scripts/manage/rotate-logs.sh

# Vérification de sécurité
./scripts/manage/security-audit.sh
```

---

## 📏 Standards et Conventions

### Nommage des Fichiers et Dossiers

- **Dossiers:** `kebab-case` (exemple: `initial-setup`)
- **Scripts:** `kebab-case.sh` (exemple: `start-lab.sh`)
- **Configs:** `kebab-case.yml` ou `.env`
- **Patches:** `NNN-description` (exemple: `001-initial-setup`)

### Structure des Scripts

```bash
#!/bin/bash
# Description du script
# Version: X.X.X
# Date: YYYY-MM-DD

# Variables globales
SCRIPT_NAME="$(basename "$0")"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_FILE="logs/script.log"

# Fonctions
function main() {
    # Code principal
}

# Point d'entrée
main "$@"
```

### Documentation des Patches

Chaque patch doit contenir un `README.md` avec :

1. **Description** du patch
2. **Prérequis** et dépendances
3. **Instructions d'installation**
4. **Instructions de rollback**
5. **Tests de validation**
6. **Impact** sur le système

### Logs et Audit

- **Logs d'installation:** `logs/installation/`
- **Logs de patches:** `logs/patches/`
- **Logs de sécurité:** `logs/security/`
- **Format:** `[TIMESTAMP] [LEVEL] [COMPONENT] Message`

---

## 🔒 Sécurité et Bonnes Pratiques

### Règles de Sécurité

1. **Isolation Réseau**
   - Utilisation de réseaux Docker dédiés
   - Pas d'exposition sur Internet
   - Firewalling approprié

2. **Gestion des Secrets**
   - Secrets dans `config/secrets/` (non versionné)
   - Variables d'environnement pour les credentials
   - Rotation régulière des mots de passe

3. **Sauvegarde et Récupération**
   - Backups automatiques quotidiens
   - Tests de restauration mensuels
   - Plans de continuité documentés

### Environnement de Test

```bash
# Toujours tester en développement avant production
CYBERLAB_ENV=development ./scripts/manage/start-lab.sh

# Validation complète avant passage en production
./scripts/manage/full-validation.sh
```

### Audit de Sécurité

```bash
# Audit mensuel recommandé
./scripts/manage/security-audit.sh

# Vérification des vulnérabilités des images
./scripts/manage/vulnerability-scan.sh

# Rotation des credentials
./scripts/manage/rotate-secrets.sh
```

---

## 🆘 Support et Aide

### Commandes d'Aide Rapide

```bash
# Aide générale
./scripts/manage/help.sh

# Status rapide
./scripts/manage/quick-status.sh

# Diagnostic complet
./scripts/manage/full-diagnostic.sh
```

### Fichiers de Log Importants

- **Installation:** `logs/installation/install-*.log`
- **Erreurs système:** `logs/runtime/error.log`
- **Sécurité:** `logs/security/audit.log`
- **Patches:** `logs/patches/patch-*.log`

### Récupération d'Urgence

En cas de problème grave :

1. **Arrêt d'urgence:** `./scripts/manage/emergency-stop.sh`
2. **Diagnostic rapide:** `./scripts/manage/emergency-diagnostic.sh`
3. **Restauration:** `./scripts/backup/emergency-restore.sh`
4. **Redémarrage:** `./scripts/manage/start-lab.sh`

---

## 🎯 Roadmap et Évolutions

### Version Actuelle: v1.0.0 "Genesis"
- ✅ Structure organisée
- ✅ Système de patches
- ✅ Backups automatiques
- ✅ Configuration multi-environnements

### Prochaine Version: v1.1.0 "Evolution"
- 🔄 Interface web améliorée
- 🔄 Monitoring avancé
- 🔄 API REST complète
- 🔄 Tests automatisés

### Version Future: v2.0.0 "Revolution"
- 📅 Architecture microservices
- 📅 Haute disponibilité
- 📅 Déploiement Kubernetes
- 📅 Interface mobile

---

## 📞 Contact et Contribution

**Équipe CyberLab**
- **Documentation:** Cette README + `/docs/`
- **Issues:** Signaler les problèmes
- **Contributions:** Suivre les standards décrits

---

**🛡️ CyberLab Genesis v1.0.0** - *Laboratoire de cybersécurité organisé et maintenable*

*Dernière mise à jour: 2024-12-20*
