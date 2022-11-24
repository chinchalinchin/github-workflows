# Quickstart

Depending on the type of package you are developing, refer to the appropriate section below.

**NOTE**: Currently, we only support **Terraform** module _continuous integration_, with an plans to support **Packer** and **Docker** in the future.

## Terraform

See [Terraform](./TERRAFORM.md) for more information on getting started.

## GH Pages

Documentation is published to the _gh-pages_ branch of each repository. The _docs_ directory in all _AutomationLibrary_ repositories have a preconfigured **Sphinx** project that demonstrates how the pipeline process _md_ Markdown files into _html_ webpage documents. For example, in the [actions-workflow](https://github.boozallencsn.com/AutomationLibrary/actions-workflows) repository, change directory into _docs_ and build the _html_ files,

```shell
cd docs
make html
```

HTML will be generated from the markdown in the _docs/source_ directory and processed into the _docs/build_ directory. See [Sphinx Documentation](https://www.sphinx-doc.org/en/master/usage/quickstart.htm) for more information. You can configure the project name, authors and version displayed on the documentation web page by adjusting the values in _docs/source/conf.py_.

**NOTE**: After the pipeline has built the documentation the first time, you can find the URL for your documentation webpage in your _Repository_ > _Settings_ > _Pages_.

**NOTE**: You will need to initialize the _gh-pages_ branch before the pipeline can hook into it. The branch will need to be empty, or else the pipeline remote will have merge conflicts with the origin. In other words, one of the first steps you should take in setting up your documentation is,

```shell
git checkout -b gh-pages
rm -rf *
```

You will need to add a _.gitignore_ with the following patterns ignored,

```
**/.DS_Store
**/.terraform
**/*.tfstate
**/*.tfstate.backup
**/.terraform.lock.hcl
**/bin/**
**/docs/build/**
**/*.zip
**/*.tar
**/*.gz
**/.venv
**/*.lock.info
**/*.env
**/*values.yml
**/*values.yaml
objects.inv
notes
!**/*.sample.values.yaml
!**/*.sample.values.yml
!**/*.sample.env

```

And a _.gitattributes_ with the following content,

```
* text=auto eol=lf
*.{cmd,[cC][mM][dD]} text eol=crlf
*.{bat,[bB][aA][tT]} text eol=crlf
```

This _.gitattributes_ line ending configuration is necessary, or else the pipeline documentation build process will exhibit strange failures. 

Commit these two files to the `gh-pages` branch and push them up to the remote,

```shell
git add . 
git commit -m 'initiailize gh-pages branch'
git push --set-upstream origin gh-pages
```

After this, your documentation should auto-compile each time a pull request is opened in either the `dev` or `master` branch. 

## DevPortal Integration

The [Developer Portal](https://developerportal.bah.com) is a company wide registry for reusable projects and code scaffolding/templates. After your project has passed the _AutomationLibrary_ continuous integration pipeline, your repository is eligible for promotion into the portal. To add your repository to the developer portal, you must do three things:

1. Add a _catalog-info.yml_ to the root of your repository.
2. Add your repository to the _AutomationLibrary's_ fork of the DeveloperPortal helm chart.
3. Create a pull request from the _AutomationLibrary_ fork into the `develop` branch of the upstream DeveloperPortal repository.

### catalog-info

This file contains metadata about your repository that is ingested into the developer portal to populate the web UI. 

[A sample file for the aws-synthetics-heartbeat-canary repo can be found here](https://github.boozallencsn.com/AutomationLibrary/aws-synthetics-heartbeat-canary/blob/master/catalog-info.yml).

See [developer portal documentation](https://github.boozallencsn.com/solutionscenter-sandbox/developer-portal-user-guide/blob/develop/docs/how-to/solution-intake/defining-entity.md) for more information on configuring the _catalog-info.yml_.

### Helm Chart

Clone the [AutomationLibrary/charts](https://github.boozallencsn.com/AutomationLibrary/charts) repository. Add links to your repository in the [/charts/backstage/config/envs/dev/app-config.yml](https://github.boozallencsn.com/AutomationLibrary/charts/blob/develop/charts/backstage/config/envs/dev/app-config.yaml#L242) and [/charts/backstage/config/envs/prod/app-config.yml](https://github.boozallencsn.com/AutomationLibrary/charts/blob/develop/charts/backstage/config/envs/prod/app-config.yaml#L242), underneath `catalogue.locations`.

### Pull Request

Create a pull request into the upstream `develop` branch of [solutionscenter-sandbox/charts](https://github.boozallencsn.com/solutionscenter-sandbox/charts) repository. Inform someone on the team that a pull request has been submitted; the best way to do this is to post a message in the _software-studio_ **Slack** channel.