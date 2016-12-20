resource "aws_key_pair" "ecs" {
  key_name   = "${var.ssh_key_name}"
  public_key = "${file(var.ssh_key_file)}"
}

resource "aws_ecs_cluster" "main" {
    name = "${var.ecs_cluster_name}"
}

resource "aws_launch_configuration" "ecs" {
    name = "ECS ${var.ecs_cluster_name}"
    security_groups = ["${aws_security_group.instance_sg.id}",]

    key_name = "${aws_key_pair.ecs.key_name}"
    image_id = "${lookup(var.ecs_amis, var.region)}"
    instance_type = "${var.ecs_instance_type}"
    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"
    user_data = "#!/bin/bash\necho ECS_CLUSTER='${var.ecs_cluster_name}' > /etc/ecs/ecs.config"
    associate_public_ip_address = true

    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "ecs-cluster" {
    name                 = "ECS ${var.ecs_cluster_name}"
    vpc_zone_identifier  = ["${aws_subnet.main.*.id}"]
    min_size             = "${var.ecs_autoscale_min}"
    max_size             = "${var.ecs_autoscale_max}"
    desired_capacity     = "${var.ecs_autoscale_desired}"
    launch_configuration = "${aws_launch_configuration.ecs.name}"
}
