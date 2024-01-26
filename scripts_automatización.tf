# Configuramos el proveedor de AWS
provider "aws" {
  region = "us-east-1"
}

# Creamos un grupo de seguridad
resource "aws_security_group" "Frontend" {
  name        = "Frontend"
  description = "Grupo de seguridad para la instancia del Frontend"

# Reglas de entrada para permitir el tráfico SSH, HTTP y HTTPS
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Reglas de salida para permitir todas las conexiones salientes
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "Servidor-NFS" {
  name        = "NFS"
  description = "Grupo de seguridad para la instancia del NFS"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Reglas de salida para permitir todas las conexiones salientes
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "Backend" {
  name        = "Backend"
  description = "Grupo de seguridad para la instancia del Backend"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Reglas de salida para permitir todas las conexiones salientes
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "Balanceador" {
  name        = "Balanceador"
  description = "Grupo de seguridad para la instancia del Balanceador"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Reglas de salida para permitir todas las conexiones salientes
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Creamos las instancias EC2 
resource "aws_instance" "Frontend-01" {
  ami           = "ami-00874d747dde814fa"
  instance_type = "t2.small"
  key_name      = "vockey"
  tags = {
    Name = "Frontend-01"
  }
}
resource "aws_instance" "Frontend-2" {
  ami           = "ami-00874d747dde814fa"
  instance_type = "t2.small"
  key_name      = "vockey"
  tags = {
    Name = "Frontend-02"
  }
}
resource "aws_instance" "Backend" {
  ami           = "ami-00874d747dde814fa"
  instance_type = "t2.small"
  key_name      = "vockey"
  tags = {
    Name = "Backend"
  }
}
resource "aws_instance" "Servidor NFS" {
  ami           = "ami-00874d747dde814fa"
  instance_type = "t2.small"
  key_name      = "vockey"
  tags = {
    Name = "Servidor NFS"
  }
}
resource "aws_instance" "load_balancer" {
  ami           = "ami-00874d747dde814fa"
  instance_type = "t2.small"
  key_name      = "vockey"
  tags = {
    Name = "loas_balancer"
  }
}
