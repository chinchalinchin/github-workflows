# actions-workflows
A set of GitHub Action workflows developed by Automation Library.

# Setup

Depending on the type of package you are developing, you will need to use a different sample file found within this repository to setup your _Continuous Integration_.

## Terraform

The _.sample.tf.yml_ can be added to a _.github/workflows_ directory in your repository to utilize the **AutomationLibrary**'s _Continuous Integration_ **Terraform** workflow template. 

### Variables

If your modules contain variables without default parameters, then in order to test the release of your module in the CI pipeline, you will need to copy the sample file _.sample.terraform-vars.yml_ into a file named _.terraform_vars_ in the root of the repository and adjust the variables to your particular project. This file is consumed in the _.github/workflows/release.yml_ in the planning step.

See [TFVar Files](https://www.terraform.io/language/values/variables#variable-definitions-tfvars-files) for more info. 

### Documentation

You will need a _.terraform-docs.yaml_ in the root of your repository for the _Terraform Docs_ workflow to succeed. The values in this value are used to configure the documentation output. See [here](https://terraform-docs.io/user-guide/configuration/) for more information.

_terraform-docs.yaml_ is configured to output the result of processing the **Terraform** modules into _docs/source/OVERVIEW.md_. This is so the outputted markdown files can be hooked into the **Sphinx** markdown-to-html processing. See [GH Pages](#gh-pages) below for more information.

**NOTE**: Do not include sensitive include in the **TFVar** file. Instead, [add a secret](https://docs.github.com/en/actions/security-guides/encrypted-secrets) to your repository and inject it into an [environment variable](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstepsenv).

## GH Pages

Documentation is published to the _gh-pages_ branch of each repository. The _docs_ directory in this repository has a preconfigured sphinx project that demonstrates how to process _.md_ Markdown files into _.html_ webpage documents. Change directory into _docs_ and 

```shell
make html
```

HTML will be generated from the markdown in the _docs/source_ directory and processed into the _docs/build_ directory. See [Sphinx Documentation](https://www.sphinx-doc.org/en/master/usage/quickstart.htm) for more information.

**NOTE**: You will also need to add a _.nojekyll_ file to your repository root on the _gh-pages_ branch in order for the **Github Pages** integration to work properly. See [here](https://github.blog/2009-12-29-bypassing-jekyll-on-github-pages/) for more information.

## Docs
### Github Actions
- [Reusable Workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows#using-inputs-and-secrets-in-a-reusable-workflow)
- [Managing Actions on Github Enterprise Servr (GHES)](https://docs.github.com/en/enterprise-server@3.5/admin/github-actions/managing-access-to-actions-from-githubcom/about-using-actions-in-your-enterprise)
- [Enable Debug Logging](https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/enabling-debug-logging)
- [Booz Allen CSN Github Actions](https://github.boozallencsn.com/actions)
### Terraform Docs
- [Configuration File](https://terraform-docs.io/user-guide/configuration/)
### Sphinx
- [Sphinx Getting Started](https://www.sphinx-doc.org/en/master/usage/quickstart.html)
- [Material for Sphinx](https://bashtage.github.io/sphinx-material/)