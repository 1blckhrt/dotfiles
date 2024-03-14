#!/bin/bash

install_aws_cli() {
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
    ./aws/install || {
		echo -e "[ERROR] Failed to install AWS CLI. Exiting..."
		exit 1
	}
}

install_aws_cli