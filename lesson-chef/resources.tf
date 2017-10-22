/* First we'll set some variables for AWS authentication. */

variable "aws_access_key" {
    default = ""
}

variable "aws_secret_key" {
    default = ""
}


/* These are dummy resources pointing to the default VPC and
   subnets in our AWS account. We'll be referencing these later. */

resource "aws_default_vpc" "default" {
}

variable "default_zones" {
    default = {
        zone0 = "eu-west-1a"
        zone1 = "eu-west-1b"
        zone2 = "eu-west-1c"
    }
}

resource "aws_default_subnet" "default" {
  availability_zone = "${lookup(var.default_zones, format("zone%d", count.index))}"
  count = 2
}



/* We'll be using AWS for provisioning the instances,
   so we'll set "aws" as the provider. */

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "eu-west-1"
}


/* Security group for the load balancer. We'll open port 80/tcp
   to the world. We'll allow everything outbound. */

resource "aws_security_group" "gid-lb" {
    name = "GID lb"
    description = "Security group for the load balancer"
    vpc_id = "${aws_default_vpc.default.id}"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Author = "Get into DevOps"
    }
}


/* Security group for the app nodes. We'll allow 8484/tcp from our load
   balancer, and 22/tcp from the world (see note below). */

resource "aws_security_group" "gid-app" {
    name = "gid app"
    description = "Security group for the app instances"
    vpc_id = "${aws_default_vpc.default.id}"
    ingress {
        from_port = 8484
        to_port = 8484
        protocol = "tcp"
        security_groups = ["${aws_security_group.gid-lb.id}"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"

        /* Good practice would be to set the following to "your.ip.address/32"
           instead of "0.0.0.0/0", which will open SSH to the world. */
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Author = "Get into DevOps"
    }
}


/* Our root SSH key pair is created by the wrapper script. */

resource "aws_key_pair" "root" {
    key_name = "root-key"
    public_key = "${file("id_rsa_example.pub")}"
}


/* The app nodes are t2.micros running Ubuntu 16.04 LTS
   for simplicity. We place the app nodes in different AZs. */

resource "aws_instance" "gid-app" {
    ami = "ami-eed00d97"
    instance_type = "t2.micro"
    count = 2

    tags {
        Name = "gid-app${count.index}"
        Author = "Get into DevOps"
    }

    subnet_id = "${element(aws_default_subnet.default.*.id, count.index)}"
    associate_public_ip_address = true

    key_name = "${aws_key_pair.root.key_name}"
    vpc_security_group_ids = ["${aws_security_group.gid-app.id}"]

    provisioner "file" {
        source = "chef"
        destination = "/home/ubuntu"
        connection {
            user = "ubuntu"
            private_key = "${file("id_rsa_example")}"
            timeout = "60s"
        }
    }

    provisioner "remote-exec" {
        inline = [
            "curl -L https://www.opscode.com/chef/install.sh | sudo bash",
            "sudo chef-solo -c /home/ubuntu/chef/solo.rb -o example_app"
        ]
        connection {
            user = "ubuntu"
            private_key = "${file("id_rsa_example")}"
            timeout = "60s"
        }
    }
}


/* This is the load balancer. */

resource "aws_lb" "gid" {
  name            = "gid-lb"
  internal        = false
  security_groups = ["${aws_security_group.gid-lb.id}"]
  subnets         = ["${aws_default_subnet.default.*.id}"]

  tags {
    Author = "Get into DevOps"
  }
}

resource "aws_lb_listener" "gid" {
  load_balancer_arn = "${aws_lb.gid.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.gid.arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group" "gid" {
  name     = "gid-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_default_vpc.default.id}"
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = "${aws_lb_target_group.gid.arn}"
  target_id        = "${element(aws_instance.gid-app.*.id, count.index)}"
  port             = 8484
  count            = 2
}


/* We'll need the load balancer hostname */

output "lb-hostname" {
    value = "${aws_lb.gid.dns_name}"
}
