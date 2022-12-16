# Action Catalogue

These reusable workflows can be composed in any order that fits your project. See the sample action file for [maintaining a Docker image](https://github.boozallencsn.com/AutomationLibrary/actions-workflows/blob/main/.sample.action.ecr.yml), [updating a Lambda function](https://github.boozallencsn.com/AutomationLibrary/actions-workflows/blob/main/.sample.action.lambda.yml) or [maintaining a Terraform project](https://github.boozallencsn.com/AutomationLibrary/actions-workflows/blob/main/.sample.action.terraform.yml) for examples of how to compose these workflows.

## Secrets

All reusable workflows have the following secrets injected in their execution environment,

| Name | Description | 
| ---- | ----------- |
| AWS_ACCOUNT_ID | Account ID of the pipeline AWS service account |
| AWS_IAM_USER | IAM username of the pipeline AWS service account |
| AWS_ACCESS_KEY_ID | Access key ID of the pipeline AWS service account |
| AWS_SECRET_ACCESS_KEY | Secret access key of the pipeline AWS service account |
| AWS_DEFAULT_REGION | Default region of the pipeline AWS service account |

## ecr-push

[Source](https://github.com/chinchalinchin/github-workflows/blob/main/.github/workflows/ecr-push.yml)

This workflow will build a **Docker** image and then push the image up to an **ECR** in the _Northern Lights_ account.

### Inputs

| Name | Description | Type | Required | 
| ---- | ----------- | ---- | -------- |
| IMAGE_NAME | Name of the image to build | string | true |
| IMAGE_TAG | Tag of the image to build | string | true |
| DOCKERFILE_DIR |  Location of the Dockerfile to build, relative to the repository root directory. Do not include trailing slash. | string | true |
| DOCKER_BUILD_CONTEXT | Location of the Docker build context, relative to the repository root directory. Do not include trailing slash. | string | true|
 
## gh-pages

[Source](https://github.com/chinchalinchin/github-workflows/blob/main/.github/workflows/gh-pages.yml)

This workflow will compile documentation into the `gh-pages` branch of the repository. Based on the files it finds in your repository, it will attempt to construct the documentation through different methods. For example, if your repository has a _.terraform-docs.yml_, it will use `tf-docs` to process the _.tf_ files into _.md_ files.

This workflow uses a **Python** library, [Sphinx](), to transpile _.md_ markdown files into web-hostable _.html_ files. The result of this transpilation is pushed to the `gh-pages` and hosted using the [Github Pages functionality](https://pages.github.com).

### Secrets

This job gets additional, optional secrets injected into its environment.

| Name | Description | Type | Required | Default | 
| ---- | ----------- | ---- | -------- | ------- |
| ACTIONS_BOT_USERNAME| Username of the bot that pushes commits to the "gh-pages" branch | string | true | github-slave-bot |
| ACTIONS_BOT_EMAIL | Email of the bot that pushes commits to the "gh-pages" branch | string | true | slave@github.com |

## lambda-update

[Source](https://github.com/chinchalinchin/github-workflows/blob/main/.github/workflows/lambda-update.yml)

This workflow performs an update on existing **Lambda** function using an **ECR** image and tag. 

### Inputs

| Name | Description | Type | Required | 
| ---- | ----------- | ---- | -------- |
| FUNCTION_NAME | Name of the function to deploy | string | true |
| IMAGE_NAME | Name of the ECR repo where the function's image is hosted | string | true |
| IMAGE_TAG | Tag in the ECR to deploy | string | true |

## tf-lint

[Source](https://github.com/chinchalinchin/github-workflows/blob/main/.github/workflows/tf-lint.yml)

This workflow runs [tf-lint](https://github.com/terraform-linters/tflint) from the repository's root directory. It requires a _.tflint.hcl_ file to be located in the root directory to configure its execution. See [documentation](https://github.com/terraform-linters/tflint/blob/master/docs/user-guide/config.md) for more information on setting up this file.

## tf-scan

[Source](https://github.com/chinchalinchin/github-workflows/blob/main/.github/workflows/tf-scan.yml)

This workflow runs [tf-sec](https://github.com/aquasecurity/tfsec) and [checkov]() from the repository's root directory. It requires a _.terraform-security.yml_ located in the root directory to configure its execution. See [documentation](https://aquasecurity.github.io/tfsec/v1.28.0/guides/configuration/config/) for more information on setting up this file.

## tf-release

[Source](https://github.com/chinchalinchin/github-workflows/blob/main/.github/workflows/tf-release.yml)

This workflow runs `terraform plan`, `terraform apply` and `terraform destroy` in a sequence of steps. Each step is dependent on the success of the previous step. Each step ingests the _.tfvars_ file found in the repository root directory. See [documentation](https://developer.hashicorp.com/terraform/language/values/variables#variable-definitions-tfvars-files) for more information on setting up this file.

However, do not add secret information to this file, as it gets committed. Instead, use a [Github Secret](https://docs.github.com/en/rest/actions/secrets). See [TF_ENV](./QUICKSTART.md#tf_env) for more information and an example of setting up a new secret.

### Inputs

| Name | Description | Type | Required | 
| ---- | ----------- | ---- | -------- |
| MODULES | Comma separated list of Terraform moduels that will be deployed. Modules will be deployedi n the order in which they are listed. | string | true |

