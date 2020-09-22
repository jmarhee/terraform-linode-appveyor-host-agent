output "Runner_Host" {
  value = "Runner for ${var.appveyor_url} configured on ${linode_instance.runner_node.ip_address}"
}
