provider "aws" {
  region = "us-east-1"
  
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "test-visa-hp"
    key            = "terraform.tfstate"
    region         = "us-east-1"

   }
  }

resource "aws_vpc" "main" {

  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "uk"
  }

}

resource "aws_subnet" "sub1" {
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
}



resource "aws_subnet" "sub2" {
  cidr_block              = "10.0.2.0/24"
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true

}

resource "aws_subnet" "sub3" {
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.main.id
}


resource "aws_subnet" "import11" {
 vpc_id = aws_vpc.main.id 

 cidr_block = "10.0.133.0/24"
 
}




resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw45.id
  }

}




resource "aws_internet_gateway" "igw45" {
  vpc_id = aws_vpc.main.id
}
resource "aws_route_table_association" "rta" {
  route_table_id = aws_route_table.rt.id

  subnet_id = aws_subnet.sub1.id

}


resource "aws_route_table_association" "rta1231" {
  route_table_id = aws_route_table.rt.id

  subnet_id = aws_subnet.sub2.id
}








resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    self        = true
    cidr_blocks = ["0.0.0.0/0"]
  }



  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true

    cidr_blocks = ["0.0.0.0/0"]


  }

}


# resource "aws_instance" "vm" {

#     subnet_id = aws_subnet.sub1.id
#     instance_type  = "t2.micro"
#     ami =  "ami-0022f774911c1d690"
#     key_name = "testterra"
#     vpc_security_group_ids = [aws_security_group.sg.id]


#    }

