# actions-workflows
A set of GitHub Action workflows developed by Automation Library.
# Targeted Pipelines
* TF Docs
* Release
    * TF Plan -> TF Apply
* Scan
    * Checkhov
    * tfsec
* TFLint
* Terratest

# Setup

## Terraform

### Variables

If your modules contain variables without default parameters, then in order to test the release of your module in the CI pipeline, you will need to add a sample file with test values in the root of your repository in a file named _.tfvars_. This file is consumed in the _.github/workflows/release.yml_ in the planning step.

See [TFVar Files](https://www.terraform.io/language/values/variables#variable-definitions-tfvars-files) for more info.
## Notes
- TF-Docs will output artifacts of all READMEs in the root and module directory. Pushing those back onto a PR is how a user will update the project's documentation.

## Docs
- [Reusing Workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows#using-inputs-and-secrets-in-a-reusable-workflow)
- [Managing Actions on Github Enterprise Servr (GHES)](https://docs.github.com/en/enterprise-server@3.5/admin/github-actions/managing-access-to-actions-from-githubcom/about-using-actions-in-your-enterprise)
- [Booz Allen CSN Github Actions](https://github.boozallencsn.com/actions)


no domain resolution:
https://github.boozallencsn.com/AutomationLibrary/aws-synthetics-heartbeat-canary/runs/183437?check_suite_focus=true

cache doesn't download:
https://github.boozallencsn.com/AutomationLibrary/aws-synthetics-heartbeat-canary/runs/183432?check_suite_focus=true
