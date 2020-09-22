provider "linode" {
  token = var.linode_token
}

resource "random_string" "runner_label" {
  length      = 6
  special     = false
  upper       = false
  min_lower   = 3
  min_numeric = 3
}

resource "linode_stackscript" "runner" {
  label       = "runner-${random_string.runner_label.result}"
  description = "Installs AppVeyor Host Agent"
  is_public   = false
  script      = <<EOF
#!/bin/bash
# <UDF name="appveyor_url" label="AppVeyor URL" example="" default="">
# <UDF name="appveyor_token" label="AppVeyor API Token" example="" default="">
snap install powershell --classic
pwsh -Command "Install-Module AppVeyorBYOC -Scope CurrentUser -Force; Import-Module AppVeyorBYOC; Connect-AppVeyorToComputer -AppVeyorUrl $APPVEYOR_URL -ApiToken $APPVEYOR_TOKEN "
EOF
  images      = ["linode/ubuntu18.04"]
  rev_note    = "Runner (${random_string.runner_label.result}"
}

resource "linode_instance" "runner_node" {
  region          = "us-central"
  type            = "g6-nanode-1"
  label           = "runner-${random_string.runner_label.result}"
  image           = "linode/ubuntu18.04"
  authorized_keys = ["${chomp(file(var.ssh_key))}"]
  stackscript_id  = linode_stackscript.runner.id
  stackscript_data = {
    "appveyor_url"   = var.appveyor_url
    "appveyor_token" = var.appveyor_token
  }
}
