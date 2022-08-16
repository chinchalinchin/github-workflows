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

## Notes
TF-Docs will output artifacts of all READMEs in the root and module directory. Pushing those back onto a PR is how a user will update the project's documentation.