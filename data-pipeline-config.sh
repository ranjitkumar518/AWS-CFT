#!/usr/bin/env bash

##Variables

export SubnetId=subnet-xxxxxxx

export TopicArn=arn:aws:sns:us-west-2:xxxxxxx:abcAlerts
export S3_LogUri=s3bucket-datapipeline-logs
export S3_Staging=s3bucket-datapipeline-data

export RedShift_Uname=RedShiftUser
export RedShift_SG=sg-xxxxxxxxxx
export RedShift_DB=redshiftdb
export Redshift_Endpoint=redshiftdb-prd-redshiftcluster.xx.xx.com
export RedshiftSchema=redshiftdb

export RDS_Uname=RedShiftUser
export RDS_SG=g-xxxxxxxxxx
export RDS_Endpoint=rds-prd-reader-db.xx.xx.net
export RDS_DB=prddb
