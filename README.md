# ByteCubed Challenge

## Description
This repo contains a single main.tf Terraform configuration file that performs the following:
1.  Spins up a publicly accessible AWS EC2 instance that is monitored by AWS Cloudwatch. It is configured with a single alarm for if the average CPU utilization is greater than 80 for 2 evaluation periods of 120 seconds
2.  Downloads, installs, and starts Docker service on the EC2 instance
3.  Runs a Docker image that deploys nginx which serves a single index.html. This index.html file dynamically displays the hostname as a variable that is entered with `terraform apply` to specify it's value (see Instructions)


## Instructions
1.  Install AWS CLI and Terraform v0.12.16 making sure they are in your path
2.	Clone this repo and cd into it
3.  Run `aws configure`.  Enter in your AWS Access Key and Secret Access Key
4.  Run `terraform apply -var "hostname=${hostname}"` where ${hostname} is your desired hostname
5.  When Terraform is finished, you will get a link printed to the console that can be copied and pasted in a browser where the index.html will be displayed
