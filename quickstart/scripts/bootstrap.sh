#!/usr/bin/env bash


sudo pip-3.6 --disable-pip-version-check --no-cache-dir install aws-parallelcluster -U

AWS_REGION=eu-west-1
KEY_NAME=amzn

mkdir -p ~/.parallelcluster
cat >> ~/.parallelcluster/config <<EOF
[global]
cluster_template = covid
update_check = true
sanity_check = true

[aws]
aws_region_name = ${AWS_REGION}

[aliases]
ssh = ssh {CFN_USER}@{MASTER_IP} {ARGS}

[cluster covid]
key_name = ${KEY_NAME}
base_os = ubuntu1804
scheduler = slurm
master_instance_type = c5n.18xlarge
compute_instance_type = c5n.18xlarge
vpc_settings = public-private
fsx_settings = fsx
disable_hyperthreading = true
dcv_settings = dcv
post_install = https://covid19hpc-quickstart-161153343288.s3.amazonaws.com/user_data.sh

[fsx fsx]
shared_dir = /fsx
storage_capacity = 1200

[dcv dcv]
enable = master
port = 8443
access_from = 0.0.0.0/0

[vpc public-private]
vpc_id = ${vpc_id}
master_subnet_id = ${master_subnet_id}
compute_subnet_id = ${compute_subnet_id}

EOF
