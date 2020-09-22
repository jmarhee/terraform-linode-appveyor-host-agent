terraform {
  required_providers {
    linode = {
      source = "terraform-providers/linode"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  required_version = ">= 0.13"
}
