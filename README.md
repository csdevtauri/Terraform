Tutoriel complet pour installer Azure CLI et configurer Terraform dans un environnement Azure.

### Prérequis
- Un abonnement Azure actif. Si vous n'en avez pas, vous pouvez créer un compte gratuit [ici](https://azure.microsoft.com/en-us/free/).

### Étape 1: Installation de Azure CLI
#### Sur Windows
1. Téléchargez l'installateur MSI à partir de [ce lien](https://aka.ms/installazurecliwindows).
2. Exécutez l'installateur et suivez les instructions à l'écran.
https://learn.microsoft.com/fr-fr/cli/azure/install-azure-cli-windows?tabs=powershell
#### Sur macOS
Ouvrez le terminal et exécutez la commande suivante:
```bash
brew update && brew install azure-cli
```

#### Sur Linux
Pour Ubuntu, vous pouvez utiliser la commande suivante:
```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

### Étape 2: Vérification de l'installation de Azure CLI
Ouvrez un terminal et exécutez:
```bash
az --version
```

### Étape 3: Connexion à Azure
Exécutez la commande suivante pour vous connecter à votre compte Azure.
```bash
az login
```
Suivez les instructions à l'écran pour vous connecter.


### Étape 4: Installation de Terraform
#### Sur Windows
1. Téléchargez l'installateur MSI à partir de [ce lien](https://www.terraform.io/downloads.html).
2. Exécutez l'installateur et suivez les instructions à l'écran.
https://learn.microsoft.com/fr-fr/cli/azure/install-azure-cli-windows?tabs=powershell
#### Sur macOS
Ouvrez le terminal et exécutez la commande suivante:
```bash
brew update && brew install terraform
```

#### Sur Linux
Pour Ubuntu, vous pouvez utiliser la commande suivante:
```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update
sudo apt-get install terraform
```

