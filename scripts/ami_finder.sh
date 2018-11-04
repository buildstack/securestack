#!/bin/bash
# copyright 2018 paulm@securestack.com.au
# ami_finder finds the ami_ids for all regions for an aws marketplace product

if [ -z $1 ]; then echo "You must provide a Product ID."; echo "Example: ami_finder.sh 9566ccc2-d817-4c8e-a2e9-b962addec48b"; exit 1; fi

regions=$(aws ec2 describe-regions --output text | cut -f3 | sort)

echo
echo "==========================="
echo "AWS Region | ami_id"
echo "==========================="

for i in $regions; 
do 
	echo "$i $(aws ec2 describe-images \
		--owners 'aws-marketplace' \
		--filters "Name=name,Values=*$1*" \
		--query 'sort_by(Images, &CreationDate)[-1].[ImageId] ' \
		--region $i)";
done
echo
