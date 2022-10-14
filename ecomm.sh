
#! /bin/bash
sudo yum update -y
sudo yum install -y httpd git
sudo systemctl start httpd
sudo systemctl enable httpd
git clone https://github.com/ravi2krishna/ecomm.git /var/www/html
