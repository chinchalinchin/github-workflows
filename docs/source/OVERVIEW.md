# actions-workflows

This repository contains a set of reusable **GitHub Action** workflows and configuration files for hooking into the **Automation Library**'s _Continuous Integration_. It currently supports **Terraform** workflows only, but in a future release will support **Packer**  and **Docker** templates.

## Terraform Pipeline

### Stages

The **Terraform** pipeline has four stages, three unique to Terraform and one that applies to all _AutomationLibrary_ repositories. 

- Scan
- Lint 
- Docs
- Release

`Scan`, `Lint` and `Release` are special **Terraform** jobs. `Docs` is a general job.

**Scan**

The `Scan` job will run [tf-sec]() and [checkov]() against the repository's infrastructure-as-code. The pipeline will fail if any vulnerabilities are found.

**Lint**

The `Lint` job will run [tf-lint]() against the repository's infrastructure-as-code. The pipeline will fail if any styling issues are found.

**Dods**

The `Docs` job will run [tf-docs]() to process _.tf_ files into _.md_ files. [Spinx]() is then run to process the _.md_ files into _.html_, which is then pushed to the `gh-pages` branch of your repository. If the documentation fails to build, the pipeline will fail.

**Release**

The `Release` job will run `terraform apply`, `terraform plan` and `terraform destroy` against each **Terraform** module in your project. The pipeline will fail if any step in the process fails.