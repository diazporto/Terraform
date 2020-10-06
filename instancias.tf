resource "aws_instance" "terraform-practico-Wireless" {
  ami           = "ami-0817d428a6fb68645"
  instance_type = "t2.micro"
  key_name      = "ubuntu"
  vpc_security_group_ids = [aws_security_group.practico.id,
  ]
  subnet_id = aws_subnet.practico-private-subnet.id
  tags = {
    Name = "terraform-practico-Wireless"
  }
  connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("/home/marcos/.aws/ubuntu.pem")
      host = self.public_ip
      }

      provisioner "remote-exec" {
        inline = [
          "sudo apt-get update -y",
          "sudo apt-get install -y ca-certificates wget",
          "wget https://get.glennr.nl/unifi/install/unifi-5.13.32.sh",
          ]

      }
     
}