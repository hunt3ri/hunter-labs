# Ansible

```commandline
ansible-inventory --graph
ansible-playbook users_create.yml
ansible-playbook users_del.yml
ansible-playbook mount_efs.yml --extra-vars "ssm_efs_key=sandbox_efs_id ssm_efs_ap_key=sandbox_efs_access_pt_id"
```