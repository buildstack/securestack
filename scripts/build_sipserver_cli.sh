#!/bin/bash

# These variables will be different for you!
# This AMI is the Sydney SecureStack SIPServer 1.1 image.  Change as needed.
AMI=ami-57e10f35
SECGROUPS='sg-xxxxxxxx sg-xxxxxxxx sg-xxxxxxxx'

aws ec2 run-instances --count 1 \
	--instance-type m4.large \
	--iam-instance-profile Name=securestack-server-role \
	--key-name kryptonite \
	--tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$1},{Key=securestack_managed,Value=yes}]" \
	--image-id $AMI \
	--security-group-ids $SECGROUPS

