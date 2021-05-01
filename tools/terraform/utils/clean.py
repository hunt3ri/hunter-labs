#!/usr/bin/env python3
# Util script to clean up .terraform config and lock files.  Required if changing accounts or wanting to update
# terraform dependencies to latest version
# Sample command:
#     python clean.py
# Clean files AND lockfiles:
#     python clean.py --all
import click
import os
import shutil

@click.command()
@click.option('--all/--not-all', default=False, help='--all will also remove all .terraform.lock files')
def clean_modules(all):
    for dirpath, dirnames, filenames in os.walk("/tools/terraform/modules"):
        if ".terraform" in dirpath and not ".terraform/" in dirpath:
            click.echo(click.style(f"\nCleaning {dirpath}", fg="bright_red"))
            shutil.rmtree(dirpath)

        if all and ".terraform.lock.hcl" in filenames:
            os.chdir(dirpath)
            click.echo(click.style(f"\nCleaning terraform.lock file in {dirpath}", fg="bright_red"))
            os.remove(".terraform.lock.hcl")

    tfinit = os.environ["TFINIT"]
    for dirpath, dirnames, filenames in os.walk("/tools/terraform/modules"):
        if "config.tf" in filenames:
            click.echo(click.style(f"\nInitialising modules in {dirpath}", fg="bright_green"))
            os.chdir(dirpath)
            os.system(tfinit)

if __name__ == "__main__":
    clean_modules()
