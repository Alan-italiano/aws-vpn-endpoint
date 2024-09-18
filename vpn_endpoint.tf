### VPN Endpoint ###
resource "aws_ec2_client_vpn_endpoint" "my_client_vpn" {
  description            = "My Client VPN"
  server_certificate_arn = aws_acm_certificate.server_vpn_cert.arn
  client_cidr_block      = var.client_cidr_block
  vpc_id                 = var.vpc_id
  
  security_group_ids     = [aws_security_group.vpn_secgroup.id]
  split_tunnel           = true


### Client Authentication ###
  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.client_vpn_cert.arn
  }

  connection_log_options {
    enabled = false
   }

  depends_on = [
    aws_acm_certificate.server_vpn_cert,
    aws_acm_certificate.client_vpn_cert
  ]
}


### Subnets Association ###
resource "aws_ec2_client_vpn_network_association" "client_vpn_association_private_1" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.my_client_vpn.id
  subnet_id              = var.subnet_id_1
}

resource "aws_ec2_client_vpn_network_association" "client_vpn_association_private_2" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.my_client_vpn.id
  subnet_id              = var.subnet_id_2
}

resource "aws_ec2_client_vpn_network_association" "client_vpn_association_private_3" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.my_client_vpn.id
  subnet_id              = var.subnet_id_3
}

### Authorization ###
resource "aws_ec2_client_vpn_authorization_rule" "authorization_rule" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.my_client_vpn.id
  target_network_cidr    = "0.0.0.0/0"
  authorize_all_groups   = true
}