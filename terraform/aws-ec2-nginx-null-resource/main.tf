provider aws {
    region = "ap-south-1"
    access_key = "<ACCESS-KEY>"
    secret_key = "<SECRET-KEY>"
}

resource "aws_instance" "tf_ec2_nginx" {
    ami = "ami-0f58b397bc5c1f2e8"
    instance_type = "t2.micro"
    key_name = "tf-ec2-key"
    vpc_security_group_ids  = [aws_security_group.main.id]

  

   tags = {
           Name = "Terraform EC2 Nginx"
   }
}

resource "null_resource" "example" {

  depends_on = [
    aws_instance.tf_ec2_nginx
  ]

  connection {
      type        = "ssh"
      host        = aws_instance.tf_ec2_nginx.public_ip
      user        = "ubuntu"
      private_key = file("<PRIVATE-KEY-PATH>")
      timeout     = "4m"
  }

  provisioner "file" {
        source      = "nginx_install.sh"
        destination = "/tmp/nginx_install.sh"
  }

  provisioner "file" {
        source      = "index.html"
        destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/nginx_install.sh",
      "/tmp/nginx_install.sh",
      "sudo mv /tmp/index.html /var/www/html/index.html"
    ]
  }

  

}


resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress = [
            {
                cidr_blocks      = [ "0.0.0.0/0", ]
                description      = ""
                from_port        = 22
                ipv6_cidr_blocks = []
                prefix_list_ids  = []
                protocol         = "tcp"
                security_groups  = []
                self             = false
                to_port          = 22
            },
            {
                cidr_blocks      = [ "0.0.0.0/0", ]
                description      = ""
                from_port        = 80
                ipv6_cidr_blocks = []
                prefix_list_ids  = []
                protocol         = "tcp"
                security_groups  = []
                self             = false
                to_port          = 80
            }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "tf-ec2-key"
  public_key = "ssh-ed25519 <PUBLIC-KEY> <EMAIL>"
}

