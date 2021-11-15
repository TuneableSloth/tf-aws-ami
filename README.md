# tf-aws-ami
Create AWS AMI using Terraform

## AWS CLI

You'll need an AWS account

Access your "My Security Credentials" section in your profile.

Create an access key if you don't have one.

### Configure AWS CLI

> $ aws configure
AWS Access Key ID [None]: "Your access key id"
AWS Secret Access Key [None]: "Your secret access key"
Default region name [None]: "Your preferred region"
Default output format [None]: json

## Create EC2 Key Pair

https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html

## Change Permissions on your key ** 

chmod 400 my_ec2_private_key.pem 

Referece: https://stackoverflow.com/questions/9270734/ssh-permissions-are-too-open-error

## Connect to your EC2 instance ** 

ssh -i my_ec2_private_key.pem ec2-user@ec2-a-b-c-d.us-west-2.compute.amazonaws.com




