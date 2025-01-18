#!/bin/bash

terraform fmt

terraform validate

terraform plan -out="plan"

terraform apply -auto-approve "plan"
