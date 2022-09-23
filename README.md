# actions-workflows

A set of reusable **GitHub Action** workflows developed by **Automation Library**.

# Setup

Depending on the type of package you are developing, you will need to use a different sample file found within this repository to setup your _Continuous Integration_.

## Terraform

The _.sample.terraform-actions.yml_ can copied into a new _action.yml_ and placed into the _.github/workflows_ directory of your repository to utilize the **AutomationLibrary**'s _Continuous Integration_ **Terraform** workflow template. This file should not need altered, but there is some additional configuration detailed below that is required for these workflows to succeed.

## Layout

The root directory should, at minimum, contain a _/docs/_ directory, a _README.md_, a _.tfvars_ file and a _provider.tf_ file. The _provider.tf_ must exist because its hash is used a key for the installation and plugin caches in the pipeline. See [Documentation](#documentation) for more information on the docs structure and workflow.

Refer to the [terraform-module-template](https://github.boozallencsn.com/AutomationLibrary/terraform-module-template) for a pre-configured project setup according to our best practices guidelines.

## State 

By default, the  **Terraform** _provider.tf_ files from the [terraform-module-template](https://github.boozallencsn.com/AutomationLibrary/terraform-module-template) has a block for the **s3** state backend. If you want to develop locally with your own local state, you must explicitly declare this,

```shell
terraform init -backend=false
```

Alternatively, you can use the remote **s3** state backend by passing in the state key you want to us. **NOTE**: _NEVER EVER USE THE_ state/terrform.tftstate _ key, as that is where the state for the state bucket and table themselves are maintained,

```shell
terraform init -backend-config "key=dev/terraform.tfstate"
```
### Variables

If your modules contain variables without default parameters, then in order to test the release of your module in the CI pipeline, you will need to copy the sample file _.sample.tfvars_ into a file named _.tfvars_ in the root of the repository and adjust the variables to your particular project. This file is consumed in the _.github/workflows/tf-release.yml_ during the `plan`, `apply` and `destroy` steps.

See [TFVar Files](https://www.terraform.io/language/values/variables#variable-definitions-tfvars-files) for more info. 

**NOTE**: Even if your module does _not_ have variables (unlikely, but possible), you will still need an empty _.tfvars_ file in your repository root for the `release` workflow to succeed.

**NOTE**: Do not include sensitive include in the _.tfvars_ file file. Instead, if you need credentials or keys in your parameters, [add a secret](https://docs.github.com/en/actions/security-guides/encrypted-secrets) to your repository and inject it into an [environment variable](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstepsenv).

### Documentation

You will need a _.terraform-docs.yaml_ in the root of your repository for the _Terraform Docs_ workflow to succeed. You can copy the _.sample.terraform-docs.yml_ into the root of your repository and configure its values for your specific project. The values in this file are used to configure `tfdocs` output in the pipeline. See [here](https://terraform-docs.io/user-guide/configuration/) for more information.

_.terraform-docs.yaml_ is configured to output the result of processing the **Terraform** modules' _READMEs_ into _docs/source/OVERVIEW.md_. This is so the outputted markdown files can be hooked into the **Sphinx** markdown-to-html processing. See [GH Pages](#gh-pages) below for more information.

### Security

You will need a _.terraform-security.yml_ in the root of your repository for the _Terraform Scan_ workflow to succeed. You can copy the _.sample.terraform-scan.yml_ into the root of your repository and configure its values for your specific project. The values in this file are used to configure `tfsec` output in the pipeline. See [here](https://aquasecurity.github.io/tfsec/v1.27.6/guides/configuration/config/) for more information.

## GH Pages

Documentation is published to the _gh-pages_ branch of each repository. The _docs_ directory in this master repository has a preconfigured **Sphinx** project that demonstrates how the pipleine process _md_ Markdown files into _html_ webpage documents. Change directory into _docs_ and build the _html_ files,

```shell
cd docs
make html
```

HTML will be generated from the markdown in the _docs/source_ directory and processed into the _docs/build_ directory. See [Sphinx Documentation](https://www.sphinx-doc.org/en/master/usage/quickstart.htm) for more information. You can configure the project name, authors and version displayed on the documentation web page by adjusting the values in _docs/source/conf.py_.

Copy the contents of _docs_ in this repository into a _docs_ directory in your own repository and configure it for your specific project.

**NOTE**: After the pipeline has built the document the first time, you can find the URL for your documentation webpage in your _Repository_ > _Settings_ > _Pages_.

**NOTE**: You will need to initialize the _gh-pages_ branch before the pipeline can hook into it. The branch will need to be empty.

```shell
git checkout -b gh-pages
rm -rf *
```

You will need to add a _.gitignore_ with the following patterns ignored (also included in the _.sample.terraform-gitignore_ file),

```
/docs/build/*
**/.venv
**/.terraform
**/*.tfstate
**/*.tfstate.backup
**/.terraform.lock.hcl
**/bin/**
**/plugins/**
**/docs/build/**
**/*.zip
**/*.tar
**/*.gz
```

And then commit it and push it up to the remote,

```shell
git add . 
git commit -m 'initiailize gh-pages branch'
git push --set-upstream origin gh-pages
```


## Docs
### Github Actions
- [Reusable Workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows#using-inputs-and-secrets-in-a-reusable-workflow)
- [Managing Actions on Github Enterprise Servr (GHES)](https://docs.github.com/en/enterprise-server@3.5/admin/github-actions/managing-access-to-actions-from-githubcom/about-using-actions-in-your-enterprise)
- [Enable Debug Logging](https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/enabling-debug-logging)
- [Booz Allen CSN Github Actions](https://github.boozallencsn.com/actions)
### Terraform Docs
- [Configuration File](https://terraform-docs.io/user-guide/configuration/)
### Terraform Security
- [Configuration File](https://aquasecurity.github.io/tfsec/v1.27.6/guides/configuration/config/)
### Sphinx
- [Sphinx Getting Started](https://www.sphinx-doc.org/en/master/usage/quickstart.html)
- [Material for Sphinx](https://bashtage.github.io/sphinx-material/)