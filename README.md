## About
The ethos of the toolkit is take care of the DevOps plumbing and allow me to focus on the interesting problems 

The core goals are threefold:
1.	Use best of breed tools, namely Terraform / Packer / Ansible and other Linux Tools
2.	The code is the documentation.  Capture best practice in the toolkit to allow me to apply to the day job.
3.	Configure all tools with one click.  Configuring tooling is complex, tedious and error prone – hide all that pain

## Pre-Requisites
* [Docker](https://www.docker.com/) - You must have ability to launch docker containers locally
* [S3 Bucket for Terraform State](https://www.terraform.io/docs/language/settings/backends/s3.html) - You must have created a S3 bucket to hold Terraform state
* [IAM User Credentials for Terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#shared-credentials-file) - You must have generated AWS credentials for Terraform to run as.  [Credentials file](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/guide_credentials_profiles.html) will be stored in the .aws directory described in Config section below.

## Config
### Secrets Management
You must create two directories above the directory you install the toolkit to store secrets.

* .aws - Stores your [aws credentals file](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/guide_credentials_profiles.html)
* .ssh - Stores your private ssh keys

Directories should look like this:

```
.aws\
.ssh\
aws-toolkit\
```
### Generate Tools Config
Next you can launch the container, see Running section below.  Once the container has started you can navigate to the utils section and run the ansible-playbook to generate config for your aws setup and for the toolkit tools, namely Ansible, Packer, Teraform and AWS CLI

```commandline
cd utils
ansible-playbook config_toolkit.yml
```
You will require answers to the following 3 questions:

1. What is the name of the aws_profile for the environment:
1. What is the name of the AWS Region infrastructure will be build it, eg us-east-1:
1. What is the name of the Organisation config is being built for (eg hunter-labs):

### Initialize all tools with generated config
With our config successfully generated we now need to initialize the tools with it.  This is done by sourcing the init_tools.sh script specifying the environment to configure.  The environment MUST match the environment name specified in Q1 above.  So if you set up a test environment you must pass test to the init script, eg

```commandline
cd /utils
. init_tools.sh test
```
You should now see your config echoed to the screen as all tools are configured.  You can test if it has worked by running an aws cli command, eg:

```commandline
aws s3 ls
```
You are now able to being hacking on AWS :)

## Utils
To help you get started I've added a few utils 

### Terraform

[Use my powerful config tool Terragen to control Terraform](https://github.com/hunt3ri/terragen)

### Packer
A simple packer build is included that will construct a Ubuntu base image with Ansible installed on it.  To run:

```commandline
cd /tools/packer
packer validate sandbox_ami.pkr.hcl
packer build sandbox_ami.pkr.hcl
```
### Ansible
The Ansible directory contains a sample playbook to show how users could be managed on your infrastructure.  You can create the sample user, and then delete using as follows.  You can amend the public key to one you own

```commandline
ansible-inventory --graph
ansible-playbook users_create.yml
```

## Quickstart
Before running for the first time ensure you have referred to the Config section above

```commandline
.\launch.bat
cd tools
. ./init_tools.sh test
```

## SSH
docker-compose file maps local ../.ssh directory into container, so private keys can be safely stored out of github.  Best practice is save your .pem file as id_rsa meaning you can connect without specifying .pem location

Useful commands
```shell
# Without id_rsa, pem file must have 400 permission
ssh -i /home/.ssh/iain.pem iain@host
# With id_rsa
ssh ubuntu@host
```

## AWSCLI

Supply profile name to access different accounts/users
```shell
aws s3 ls
aws iam list-roles --profile hunter_ops_test
```
### Useful commands
```shell
# List all available profiles
aws configure list-profiles
# Filter ami images to test filters
aws ec2 describe-images --filters "Name=name,Values=ubuntu/images*ubuntu-focal-20.04-amd64-server-*"
```