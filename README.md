# actions-workflows
A set of GitHub Action workflows developed by Automation Library.

# Setup

Depending on the type of package you are developing, you will need to use a different sample file found within this repository to setup your _Continuous Integration_.

## Terraform

The _.sample.tf.yml_ can be added to a _.github/workflows_ directory in your repository to utilize the **AutomationLibrary**'s _Continuous Integration_ workflow templates. 

### Variables

If your modules contain variables without default parameters, then in order to test the release of your module in the CI pipeline, you will need to add a sample file with test values in the root of your repository in a file named _.tfvars_. This file is consumed in the _.github/workflows/release.yml_ in the planning step.

See [TFVar Files](https://www.terraform.io/language/values/variables#variable-definitions-tfvars-files) for more info.

## Docs
- [Reusing Workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows#using-inputs-and-secrets-in-a-reusable-workflow)
- [Managing Actions on Github Enterprise Servr (GHES)](https://docs.github.com/en/enterprise-server@3.5/admin/github-actions/managing-access-to-actions-from-githubcom/about-using-actions-in-your-enterprise)
- [Enable Debug Logging](https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/enabling-debug-logging)
- [Booz Allen CSN Github Actions](https://github.boozallencsn.com/actions)


no domain resolution:
https://github.boozallencsn.com/AutomationLibrary/aws-synthetics-heartbeat-canary/runs/183437?check_suite_focus=true

cache doesn't download:
https://github.boozallencsn.com/AutomationLibrary/aws-synthetics-heartbeat-canary/runs/183432?check_suite_focus=true
