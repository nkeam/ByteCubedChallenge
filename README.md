# ByteCubed Challenge

##Description
This repo contains a single main.tf Terraform configuration file that performs the following:
1.  Spins up a publicly accessible AWS EC2 instance that is monitored by AWS Cloudwatch.  
		-  It is configured with a single alarm for if the average CPU utilization is greater than 80 for 2 evaluation periods of 120 seconds.
2.  Downloads, installs, and starts Docker service 
3.  Runs a Docker image that deploys nginx which serves a single index.html 
		-  This index.html file dynamically deploys the hostname as a variable that is entered with `terraform apply` to specify it's value (see Instructions)


## Instructions
1.  Install Terraform v0.12.16 and ensure it is in your path
2.	Clone this repo and cd into it
3.  Install AWS CLI 
4.  Run `aws configure`.  Enter in your AWS Access Key and Secret Access Key
5.  Run `terraform apply -var "hostname=${hostname}"` where ${hostname} is your desired hostname
6.  When Terraform is finished, you will get the link printed to the console
