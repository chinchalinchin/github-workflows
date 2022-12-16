# actions-workflows

This repository contains a set of reusable **GitHub Action** workflows and configuration files for setting up **Terraform** _Continuous Integration_. 
## Terraform Pipeline

### Stages

The **Terraform** pipeline has four stages, three unique to Terraform and one that applies to all _AutomationLibrary_ repositories. 

- Scan
- Lint 
- Docs
- Release

`Scan`, `Lint` and `Release` are special **Terraform** jobs. `Docs` is a general job.

**Scan**

The `Scan` job will run [tf-sec](https://aquasecurity.github.io/tfsec/v1.28.1/) and [checkov](https://www.checkov.io) against the repository's infrastructure-as-code. The pipeline will fail if any vulnerabilities are found.

**Lint**

The `Lint` job will run [tf-lint](https://github.com/terraform-linters/tflint) against the repository's infrastructure-as-code. The pipeline will fail if any styling issues are found.

**Docs**

The `Docs` job will scan your repository for several files. If it encounters a _.terraform-docs.yml_, it will run [tf-docs](https://terraform-docs.io) to process _.tf_ files into _.md_ files. 

In the final stage of the **Docs** job, [Sphinx](https://www.sphinx-doc.org/en/master/) is run to process any _.md_ files into _.html_, which is then pushed to the `gh-pages` branch of your repository, where it is statically hosted through [Github Pages](https://pages.github.com).

**Release**

The `Release` job will run `terraform apply`, `terraform plan` and `terraform destroy` against each **Terraform** module specified from your project.

In order for this job to succeed, the pipeline will need permission to deploy the associated resources. You will need to attach the necessary **AWS API** permissions to the pipeline service account before this job can pass the pipeline.