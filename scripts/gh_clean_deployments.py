#!/usr/bin/env python3
import os
from github import Github

GH_TOKEN = os.getenv("GH_TOEKN")

g = Github(GH_TOKEN)

deployments = g.get_repo("overlordtm/website").get_deployments()

for deployment in deployments:
    # gh.get_repo(deployment.)

    print(deployment)
    # g.get_repo("overlordtm/website").create_
