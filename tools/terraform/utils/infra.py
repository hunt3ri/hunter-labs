#!/usr/bin/env python3
# Util to create or destroy playbooks that are defined as global var lists of tuples.  List is then played in
# order to create the infra and reversed to destroy it.  Each playbook contains a list of modules we want to create
# in the order we want to create them, tuple values as follows:
#    ("Module Description", "Path to Module", "Terraform vars file to apply")
# Sample create command:
#     python infra --create --playbook sandbox
# Sample destroy command:
#     python infra --destroy --playbook sandbox
import click
import os
import subprocess

# Creates a single sandbox EC2 instance running on a simple VPC
sandbox = [
    ("Simple VPC", "/tools/terraform/modules/common/vpc", "vars_simple_vpc.tfvars"),
    ("Sandbox Instance", "/tools/terraform/modules/middleware/sandbox", "vars_sandbox.tfvars")
]

# Creates a cluster of sandbox EC2 instance running on a simple VPC
sandbox_cluster = [
    ("Simple VPC", "/tools/terraform/modules/common/vpc", "vars_simple_vpc.tfvars"),
    ("Sandbox Cluster", "/tools/terraform/modules/middleware/sandbox", "vars_sandbox_cluster.tfvars")
]

@click.command()
@click.option('--create/--destroy', default=True, help='Create or destroy infrastructure')
@click.option('--playbook', type=click.Choice(['sandbox', 'sandbox_cluster'], case_sensitive=True),
              help='Playbook to run', prompt="Playbook to run")
def run_infra(create, playbook):
    """ Creates or destroys the supplied playbook """
    click.echo(click.style(f"\nRunning playbook: {playbook}\n", fg="bright_magenta"))
    playbook_modules = (globals().get(playbook))

    try:
        if create:
            for module in playbook_modules:
                click.echo(click.style(f"\nCreating {module[0]}\n", fg="bright_green"))
                os.chdir(module[1])
                apply_cmd = f"terraform apply -var-file={module[2]} -auto-approve"
                subprocess.run(apply_cmd.split(" "), check=True)
        else:
            for module in reversed(playbook_modules):
                click.echo(click.style(f"\nDestroying {module[0]}\n", fg="bright_red"))
                os.chdir(module[1])
                destroy_cmd = f"terraform destroy -var-file={module[2]} -auto-approve"
                subprocess.run(destroy_cmd.split(" "), check=True)
    except subprocess.CalledProcessError as e:
        click.echo(f"Error running terraform command: {e}")
        return

if __name__ == '__main__':
    run_infra()
