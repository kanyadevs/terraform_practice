output "instance_ids" {
    value = aws_instance.my_server[*].id 
}

output "instance_public_ips" {
    value = aws_instance.my_server[*].public_ip
}

output "server_id_ip" {
    value = [
        for x in aws_instance.my_server :
        "Server with ID: ${x.id} has Public IP: ${x.public_ip}"
    ]
}

output "server_id_ip_map" {
    value = {
        for x in aws_instance.my_server :
        x.id => x.public_ip
    }
}

output "users_all" {
    value = aws_iam_user.user
}