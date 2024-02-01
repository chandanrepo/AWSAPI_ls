#!/bin/bash

# Get list of all regions
regions=$(aws ec2 describe-regions --query "Regions[*].RegionName" --output text)

# Loop through each region
for region in $regions; do
    echo "Region: $region"

    # List EC2 instances
    echo "EC2 Instances:"
    aws ec2 describe-instances --region "$region" --query "Reservations[*].Instances[*].{ID:InstanceId,Type:InstanceType}" --output text

    # List RDS instances
    echo "RDS Instances:"
    aws rds describe-db-instances --region "$region" --query "DBInstances[*].{DBInstanceIdentifier:DBInstanceIdentifier,DBInstanceClass:DBInstanceClass}" --output text

    # Add other AWS services as needed
done
