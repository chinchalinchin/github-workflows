# actions-workflows

A set of reusable **GitHub Action** workflows developed by **Automation Library**.

# Setup

Depending on the type of package you are developing, you will need to use a different sample file found within this repository to setup your _Continuous Integration_.

## Terraform

The _.sample.terraform-actions.yml_ can be added to a _.github/workflows_ directory in your repository to utilize the **AutomationLibrary**'s _Continuous Integration_ **Terraform** workflow template. 

### Variables

If your modules contain variables without default parameters, then in order to test the release of your module in the CI pipeline, you will need to copy the sample file _.sample.tfvars_ into a file named _.tf_vars_ in the root of the repository and adjust the variables to your particular project. This file is consumed in the _.github/workflows/tf-release.yml_ during the `plan`, `apply` and `destroy` steps.

See [TFVar Files](https://www.terraform.io/language/values/variables#variable-definitions-tfvars-files) for more info. 

**NOTE**: Do not include sensitive include in the _.tfvars_ file file. Instead, if you need credentials or keys in your parameters, [add a secret](https://docs.github.com/en/actions/security-guides/encrypted-secrets) to your repository and inject it into an [environment variable](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstepsenv).

### Documentation

You will need a _.terraform-docs.yaml_ in the root of your repository for the _Terraform Docs_ workflow to succeed. You can copy the _.sample.terraform-docs.yml_ into the root of your repository and configure its value for your specific project. The values in this file are used to configure the documentation output in the pipeline. See [here](https://terraform-docs.io/user-guide/configuration/) for more information.

_terraform-docs.yaml_ is configured to output the result of processing the **Terraform** modules' _READMEs_ into _docs/source/OVERVIEW.md_. This is so the outputted markdown files can be hooked into the **Sphinx** markdown-to-html processing. See [GH Pages](#gh-pages) below for more information.


## GH Pages

Documentation is published to the _gh-pages_ branch of each repository. The _docs_ directory in this master repository has a preconfigured **Sphinx** project that demonstrates how the pipleine process _md_ Markdown files into _html_ webpage documents. Change directory into _docs_ and build the _html_ files,

```shell
cd docs
make html
```

HTML will be generated from the markdown in the _docs/source_ directory and processed into the _docs/build_ directory. See [Sphinx Documentation](https://www.sphinx-doc.org/en/master/usage/quickstart.htm) for more information. You can configure the project name, authors and version displayed on the documentation web page by adjusting the values in _docs/source/conf.py_.

Copy the contents of _docs_ in this repository into a _docs_ directory in your own repository and configure it for your specific project.

**NOTE**: You will also need to add a _.nojekyll_ file to your repository root on the _gh-pages_ branch in order for the **Github Pages** integration to work properly. See [here](https://github.blog/2009-12-29-bypassing-jekyll-on-github-pages/) for more information.

**NOTE**: After the pipeline has built the document the first time, you can find the URL for your documentation webpage in your _Repository_ > _Settings_ > _Pages_.

**NOTE**: You will need to initialize the _gh-pages_ branch before the pipeline can hook into it. The branch will need to be empty.

```shell
git checkout -b gh-pages
rm -rf *
```

You will need to add a _.gitignore_ with the following patterns ignored,

```
**/.venv
**/bin
/docs/build/*
*.tfstate
*.tfstate.backup
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
### Sphinx
- [Sphinx Getting Started](https://www.sphinx-doc.org/en/master/usage/quickstart.html)
- [Material for Sphinx](https://bashtage.github.io/sphinx-material/)