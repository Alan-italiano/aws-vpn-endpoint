resource "aws_acm_certificate" "server_vpn_cert" {
  certificate_body  = file("./certs/server.crt")
  private_key       = file("./certs/server.key")
  certificate_chain = file("./certs/ca.crt")
}

resource "aws_acm_certificate" "client_vpn_cert" {
  certificate_body  = file("./certs/client1.domain.tld.crt")
  private_key       = file("./certs/client1.domain.tld.key")
  certificate_chain = file("./certs/ca.crt")
}
