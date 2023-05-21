resource "null_resource" "null"{
 triggers = {
    public_ip = aws_instance.publicinstance.public_ip
  }


provisioner "local-exec" {
    
command =  <<EOH
echo"${aws_instance.publicinstance.public_ip}" >> details
EOH
}

provisioner "remote-exec" {
inline = [
   "touch file.txt",
   "touch file3.txt",
   "sudo apt update"
]
connection {
    type = "ssh"
    user = "ubuntu"
    #password = "ubuntu"
    private_key = file("Key98.pem")
    host = aws_instance.publicinstance.public_ip
    timeout="1m"
}
}
depends_on = [aws_instance.publicinstance]
}
