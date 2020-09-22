variable "linode_token" {}
variable "ssh_user" {
  default = "root"
}
variable "ssh_key" {
  default = "~/.ssh/id_rsa.pub"
}
variable "appveyor_token" {
  description = "appveyor API token"
}

variable "appveyor_url" {
  description = "Your appveyor instance URL (i.e. https://ci.yourorg.com)"
}
