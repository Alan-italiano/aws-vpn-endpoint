resource "aws_security_group" "vpn_secgroup" {
 name   = "vpn-sg"
 vpc_id = var.vpc_id
 description = "Allow all traffic to the VPN"
 
  ingress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
  } 
  
  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
  }

}
