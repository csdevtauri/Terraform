# Définition des Variables : Ce fichier est utilisé pour définir toutes les variables que vous utiliserez dans vos fichiers de configuration Terraform. Il sert de "dictionnaire" pour toutes les variables que vous pouvez paramétrer.

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
