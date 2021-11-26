#!/usr/bin/env bash
clear
blue=$(tput setaf 4)
green=$(tput setaf 2)
normal=$(tput sgr0)

if [[ $# -eq 0 ]] ; then
    echo 'ERROR - You must pass environment argument to initialise toolkit MUST be one of dev|test|prod'
    return
fi

printf "${green}"
figlet Hunter-Labs AWS Toolkit

printf "\nChecking installed tool versions:\n\n" && sleep 1
printf "\n${blue}Ansible version: `ansible --version`\n" && sleep 1
printf "\nAWS CLI version: `aws --version`\n" && sleep 0.5
printf "\nPacker v`packer --version`\n\n" && sleep 1
printf "`terraform --version`\n\n"
printf "${green}Version Check OK\n\n" && sleep 1

# Get rid of any windows weirdness
#dos2unix /tools/terraform/config/*.*
#dos2unix /tools/packer/config/*.*
#dos2unit /tools/ansible/config/*.sh

#printf "Set global TERRAFORM config\n\n ${blue}" && sleep 1
#if [ $1 == "prod" ] ; then
#    source /tools/terraform/config/tf_vars_prod.sh
#elif [ $1 == "test" ] ; then
#    source /tools/terraform/config/tf_vars_test.sh
#elif [ $1 == "dev" ] ; then
#    source /tools/terraform/config/tf_vars_dev.sh
#else
#    echo 'ERROR - Environment argument must be in range - dev|test|prod'
#    return
#fi
#printf "${green}\nGlobal Terraform Config OK\n\n" && sleep 2

printf "Set global Packer config\n\n ${blue}"  && sleep 1

if [ $1 == "prod" ] ; then
    source /tools/packer/config/pkr_vars_prod.sh
elif [ $1 == "test" ] ; then
    source /tools/packer/config/pkr_vars_test.sh
elif [ $1 == "dev" ] ; then
    source /tools/packer/config/pkr_vars_dev.sh
else
    echo 'ERROR - Environment argument must be in range - dev|test|prod'
    return
fi
printf "${green}\nGlobal Packer Config OK\n\n" && sleep 1

printf "Set global Ansible config\n\n ${blue}"  && sleep 1

if [ $1 == "prod" ] ; then
    source /tools/ansible/config/init_ansible_prod.sh
elif [ $1 == "test" ] ; then
    source /tools/ansible/config/init_ansible_test.sh
elif [ $1 == "dev" ] ; then
    source /tools/ansible/config/init_ansible_dev.sh
else
    echo 'ERROR - Environment argument must be in range - dev|test|prod'
    return
fi
printf "${green}\nGlobal Ansible Config OK\n\n" && sleep 1

printf "Hunter Labs Ops Toolkit intialise status = SUCCESS.  Enjoy hacking on AWS :)\n\n ${normal}"

# push environment onto command line - so easy to see what we're using
# help is here https://www.digitalocean.com/community/tutorials/how-to-customize-your-bash-prompt-on-a-linux-vps
export PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \e[0;36m[$TF_VAR_profile]\n\[\033[00m\]\$ '
alias ls='ls --color'