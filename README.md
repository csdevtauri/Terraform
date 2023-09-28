# Tutoriel Complet sur Terraform avec Azure

## Introduction

Ce tutoriel vous guidera à travers les étapes nécessaires pour configurer et déployer une infrastructure Azure à l'aide de Terraform. Nous aborderons les sujets suivants :

1. Installation de l'Azure CLI
2. Authentification Azure
3. Installation de Terraform
4. Vérification de l'installation de Terraform
5. Configuration de l'authentification
6. Configuration de Terraform avec Azure
7. Création d'un groupe de ressources Azure
8. Gestion de code source avec Git

---

## Prérequis

- Compte Azure
- PowerShell ou terminal de commande
- Git (optionnel)

---

## Étape 1: Installation de l'Azure CLI

### Windows (PowerShell)

```powershell
Install-Module -Name Az -AllowClobber -Scope CurrentUser
```

### macOS et Linux

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

---

## Étape 2: Authentification Azure

Exécutez la commande suivante pour vous connecter à votre compte Azure :

```bash
az login
```

Suivez les instructions pour compléter l'authentification.

---

## Étape 3: Installation de Terraform

### Téléchargez et installez Terraform à partir du [site officiel](https://www.terraform.io/downloads.html).

OU

### Utilisation de Chocolatey (Gestionnaire de paquets pour Windows)
Si vous avez Chocolatey installé, l'installation de Terraform devient aussi simple que d'exécuter une seule commande :
```powershell
choco install terraform
```
Après l'installation, vous pouvez vérifier la version de Terraform en exécutant :
```powershell
terraform --version
```

### Avantages et Inconvénients de la méthode Chocolatey
**Avantages** :
- Installation plus rapide et plus simple.
- Gestion facile des mises à jour.

**Inconvénients** :
- Dépendance d'un gestionnaire de paquets tiers.
- Moins de contrôle sur la version spécifique de Terraform à installer.


OU
### Utilisation de Winget (Windows Package Manager)
Si vous utilisez Windows 10 version 1809 (build 17763) ou ultérieure, vous pouvez utiliser Winget :
```powershell
winget install --id=HashiCorp.Terraform
```


#### Sur macOS et Linux
Vous pouvez utiliser la commande suivante:
```bash
brew install terraform
```


---

## Étape 4 Vérification de l'installation de Terraform
Ouvrez un terminal et exécutez:
```bash
terraform --version
```

## Étape 5 Configuration de l'authentification par CLI Azure

Voici comment vous pouvez créer un service principal avec un rôle de "Contributeur"  au niveau de l'abonnement et spécifier les étendues (`--scopes`) pour lesquelles le service principal aura des autorisations. Vous pouvez spécifier une étendue au niveau de l'abonnement, du groupe de ressources ou de la ressource.
Créez un service principal Azure en exécutant la commande suivante:
```bash
az ad sp create-for-rbac --name <Nom_du_Service_Principal> --role Contributor --scopes /subscriptions/<ID d'abonnement principale>
```

exemple: 

```shell
az ad sp create-for-rbac --name Terraname --role Contributor --scopes /subscriptions/0eea535e-a7c0-4958-bffc-aa9ca2dae765 
```

## Étape 6: Configuration de Terraform avec Azure

### Structure du projet

Votre structure de projet devrait ressembler à ceci :

```
.
├── terraform.tf      
├── terraform.tfvars  
└── variables.tf      
```

### Fichier `variables.tf`

Définissez les variables d'environnement suivantes:
```bash
export ARM_SUBSCRIPTION_ID=<Votre_Subscription_ID>
export ARM_CLIENT_ID=<Votre_appId>
export ARM_CLIENT_SECRET=<Votre_password>
export ARM_TENANT_ID=<Votre_tenant>
```

### Fichier `terraform.tfvars`

Initialisez vos variables ici :

```hcl
ARM_SUBSCRIPTION_ID = "votre_subscription_id"
ARM_TENANT_ID       = "votre_tenant_id"
ARM_CLIENT_ID       = "votre_client_id"
ARM_CLIENT_SECRET   = "votre_client_secret"
```

### Fichier `terraform.tf`

Votre fichier principal de configuration Terraform :

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.87.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.ARM_SUBSCRIPTION_ID
  tenant_id       = var.ARM_TENANT_ID
  client_id       = var.ARM_CLIENT_ID
  client_secret   = var.ARM_CLIENT_SECRET
}

resource "azurerm_resource_group" "resourcegroup" {
    name = "GRTerraformChok"
    location = "West Europe"
}

# Votre code ici


```

### Fichier `variables.tf`

Définition des Variables : Ce fichier est utilisé pour définir toutes les variables que vous utiliserez dans vos fichiers de configuration Terraform. Il sert de "dictionnaire" pour toutes les variables que vous pouvez paramétrer.

La séparation des fichiers `variables.tf` et `terraform.tfvars` dans un projet Terraform est une pratique courante qui offre plusieurs avantages en termes de modularité, de réutilisabilité et de sécurité. 
```


variable "ARM_SUBSCRIPTION_ID" {
  description = "ID de l'abonnement Azure"
}

variable "ARM_TENANT_ID" {
  description = "ID du locataire Azure"
}

variable "ARM_CLIENT_ID" {
  description = "ID du client Azure"
}

variable "ARM_CLIENT_SECRET" {
  description = "Secret du client Azure"
}

```

**Avantages** :

- **Modularité** : Vous pouvez réutiliser le même code pour différents environnements (dev, test, prod) en changeant simplement les valeurs dans `terraform.tfvars`.
    
- **Sécurité** : Vous pouvez exclure `terraform.tfvars` de votre dépôt si celui-ci contient des données sensibles.
### Initialisation de Terraform
Dans le répertoire où se trouve votre fichier de configuration Terraform (`main.tf`), exécutez:
```bash
terraform init
```


### Application du Plan
Après avoir vérifié le plan d'exécution avec 
`terraform plan`, appliquez-le avec:
```bash
terraform apply
```

### Avantages et Inconvénients
**Avantages** :
- Automatisation complète de votre infrastructure.
- Gestion fine des accès grâce aux service principals.

**Inconvénients** :
- Nécessite une bonne compréhension des services Azure et de Terraform.
---

## Étape 7: Gestion de code source avec Git

### Fichier `.gitignore`

Créez un fichier `.gitignore` à la racine de votre projet et ajoutez les lignes suivantes :

```gitignore
.terraform/
.terraform.lock.hcl
*.tfvars
*.tfplan
*.tfstate
*.tfstate.backup
```

---

## Étape 8: Déploiement

1. Initialisez Terraform :

    ```bash
    terraform init
    ```

2. Vérifiez le plan de déploiement :

    ```bash
    terraform plan
    ```

3. Appliquez les changements :

    ```bash
    terraform apply
    ```

---

## Conclusion

Vous avez maintenant une infrastructure Azure basique déployée à l'aide de Terraform. Vous pouvez ajouter plus de ressources et de fonctionnalités selon vos besoins.

### Avantages et Inconvénients

**Avantages** :

- **Automatisation**: Tout est codé, ce qui facilite la réplication et la maintenance.
- **Transparence**: Vous pouvez voir exactement ce qui sera déployé avant de l'appliquer.

**Inconvénients** :

- **Complexité initiale**: Il peut être difficile de tout configurer au début, mais cela en vaut la peine pour les avantages à long terme.

### Analogie

Pensez à Terraform comme un jardinier qui s'occupe de votre jardin (infrastructure). Vous lui donnez un plan (fichier `.tf`), et il s'occupe du reste, assurant que tout pousse comme prévu.

---

J'espère que ce tutoriel vous sera utile. Si vous avez des questions ou des clarifications, n'hésitez pas à demander.