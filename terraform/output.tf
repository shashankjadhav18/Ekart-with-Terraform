output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
  description = "The public IP address of the Jenkins server"
}

output "nexus_public_ip" {
  value = aws_instance.nexus.public_ip
  description = "The public IP address of the Nexus server"
}

output "sonarqube_public_ip" {
  value = aws_instance.sonarqube.public_ip
  description = "The public IP address of SonarQube server" 
}
