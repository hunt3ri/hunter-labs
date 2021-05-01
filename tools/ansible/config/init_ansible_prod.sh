# Initialise ansible for prod environment
printf "Setting global Ansible vars for prod environment\n\n" && sleep 0.5
export AWS_PROFILE=hunter_ops_prod && printf "AWS_PROFILE: `echo $AWS_PROFILE`\n"

# Install ansible-galaxy requirements
ansible-galaxy install -r /tools/ansible/config/requirements.yml
