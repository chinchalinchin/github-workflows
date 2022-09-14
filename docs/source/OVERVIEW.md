<!-- BEGIN_TF_DOCS -->
# AWS Synthetics Canary Heartbeat Monitoring and Alerting Module

Simple and reusable heartbeat canary monitoring module written in terraform.

The heartbeat canary monitors provided target urls and takes screenshots.
A configured alarm notifies provided email addresses on failures.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_canary"></a> [canary](#module\_canary) | ./modules/canary | n/a |
| <a name="module_canary_role"></a> [canary\_role](#module\_canary\_role) | ./modules/iam | n/a |
| <a name="module_cloudwatch"></a> [cloudwatch](#module\_cloudwatch) | ./modules/cloudwatch | n/a |
| <a name="module_s3"></a> [s3](#module\_s3) | ./modules/s3 | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_canary_role_arn"></a> [canary\_role\_arn](#input\_canary\_role\_arn) | Optional: ARN for the Canary IAM Role | `string` | `""` | no |
| <a name="input_canary_runtime_version"></a> [canary\_runtime\_version](#input\_canary\_runtime\_version) | AWS Synthetics canary runtime version | `string` | `"syn-nodejs-puppeteer-3.2"` | no |
| <a name="input_canary_schedule_expression"></a> [canary\_schedule\_expression](#input\_canary\_schedule\_expression) | AWS Synthetics canary schedule expression | `string` | `"rate(1 minute)"` | no |
| <a name="input_canary_timeout"></a> [canary\_timeout](#input\_canary\_timeout) | AWS Synthetics canary run timeout | `number` | `60` | no |
| <a name="input_canary_vpc_config"></a> [canary\_vpc\_config](#input\_canary\_vpc\_config) | Map of subnet ids and security group ids | `map(any)` | `{}` | no |
| <a name="input_email_endpoints"></a> [email\_endpoints](#input\_email\_endpoints) | The email address or list of email addresses that are sent alerts | `set(string)` | n/a | yes |
| <a name="input_enable_active_tracing"></a> [enable\_active\_tracing](#input\_enable\_active\_tracing) | Determine whether to enable active tracing | `bool` | `false` | no |
| <a name="input_evaluation_periods"></a> [evaluation\_periods](#input\_evaluation\_periods) | The number of periods over which data is compared to the specified threshold | `string` | `2` | no |
| <a name="input_period"></a> [period](#input\_period) | The period in seconds over which the specified statistic is applied | `string` | `120` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region for Canary Deployment | `string` | `"us-east-1"` | no |
| <a name="input_target_service"></a> [target\_service](#input\_target\_service) | Cannonical name of service this canary is monitoring | `string` | n/a | yes |
| <a name="input_target_urls"></a> [target\_urls](#input\_target\_urls) | URLs of the target service to monitor | `set(string)` | n/a | yes |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | The value against which the specified statistic is compared | `string` | `1` | no |
| <a name="input_vpc_access_policy"></a> [vpc\_access\_policy](#input\_vpc\_access\_policy) | Boolean value to determine whether VPC access policy is needed | `bool` | `false` | no |

## Outputs

No outputs.

## Usage

To use this module, you will need to include it in your terraform (or run it standalone) and pass the required variables, like so:

```hcl
module "canary_external" {
  # Reference the canary repository directly
  # source                = "git::https://github.boozallencsn.com/FRB-SRE/canary-external.git"
  # Reference the canary repository locally
  source                     = "../../"
  target_service             = var.target_service
  region                     = var.region
  target_urls                = var.target_urls
  enable_active_tracing      = var.enable_active_tracing
  canary_role_arn            = var.canary_role_arn
  canary_vpc_config          = var.canary_vpc_config
  vpc_access_policy          = var.vpc_access_policy
  evaluation_periods         = var.evaluation_periods
  period                     = var.period
  threshold                  = var.threshold
  email_endpoints            = var.email_endpoints
  canary_timeout             = var.canary_timeout
  canary_schedule_expression = var.canary_schedule_expression
}
```

Existing examples are listed in following sections

### Generic Heartbeat Canary with Comments

In this example, all the variables are explicitely documented in the tfvars file.

See examples/generic.

### External VPC Canary

In this example, the heartbeat canary is configured to test target urls which are externally accessible (externally of the AWS account).

See examples/vpcexternal.

### Internal VPC Canary

In this example, the heartbeat canary is configured to test target urls which are internally accessible (through a VPC in an AWS account).

See examples/vpcinternal.

### Canary with Xray Tracing enabled

In this example, the heartbeat canary is configured to test target urls with Xray tracing enabled.

See examples/xraytracing.

<!-- END_TF_DOCS -->

## Quickstart

To deploy a minimal canary to monitor a service exposed to the internet, there are three required inputs,

```shell
$ > terraform apply

var.email_endpoints
  The email address or list of email addresses that are sent alerts

  Enter a value: ["an@email.com"]

var.target_service
  Cannonical name of service this canary is monitoring

  Enter a value: google

var.target_urls
  URLs of the target service to monitor

  Enter a value: ["https://google.com"]
```

**NOTE**: `var.email_endpoints` and `var.target_urls` are both of type `set` and need to be passed in as arrays of strings.

**NOTE**: The `IAM` module will attempt to provision a role for the canary, but the account executing the terraform script must have named IAM permissions. If the account does not have named IAM permissions, the ARN of the role must be explicitly passed in under the `canary_role_arn`,

```shell
terraform apply -var canary_role_arn=<iam role arn>
```

To deploy a canary into a VPC to monitor an internal service , you will need to override the default values for the `canary_vpc_config` variable.

## What is Synthetic Monitoring? 

Synthetic monitoring is used to monitor performance and uptime of web applications. This approach monitors the web applicaation from a user experience perspective and the results are used to identify and resolve performance and availability issues. Synthetic monitoring can be used to monitor sites, API endpoints, and workflows to improve customer satisfaction and performance for web apps. 

This module contains the infrastructure as code necessary to deploy a synthetic monitoring tool implementation called AWS Synthetics Canary. This repository only implements the heartbeat monitoring type of canary. AWS provides customizable scripts that allow the canary to load a specified URL and store a screenshot of the page and an HTTP archive file.

## Canary autostart

This module is configured to auto start the AWS Synthetics canary after creation so that there is no need to start the canary manually.

To disable this, find the `start_canary` property of the `aws_synthetics_canary.heartbeat_canary` resource in modules/canary/main.tf.

## Canary metric alerting

AWS Synthetic Canaries post metrics of the results of their runs in AWS Cloudwatch Metrics. A Cloudwatch Alarm is also created which sends SNS messages whenever it detects failed requests, 4xx or 5xx requests from the heartbeat canary.

## VPC Deployment

To run a canary on a VPC, you have to specify the Subnet Id(s) and the Security Group(s).  This will be configured in the terraform.tfvars file in the `canary_vpc_config` variable. If the canary is being configured inside a VPC, then the `vpc_access_policy` must be set to true. This will add the correct IAM permissions to the role.  

*Example of a deployment in a VPC* 
```
canary_vpc_config = { 
   subnet_ids         = ["subnet-123xyz"], 
   security_group_ids = ["sg-123xyz"] 
} 
```

*Example of a deployment outside of a VPC* 
```
Canary_vpc_config = { 
} 
```

To deploy a canary without configuring a VPC, you just leave the `canary_vpc_config` variable empty. Confirm that the `vpc_access_policy` is set to false.

See the examples/vpcinternal folder to see a complete example.

## Adjust Deployment Schedule  

You may configure the canary scheduling and timeout to decrease or increase the frequency of adjust the runtime of the canary. Increasing the runtime could be required if the target url/s take too long to be loaded (especially when adding additional target urls). By default, it is set at a rate of 1 minute, meaning it runs every minute. The different units that can be used are "minute, minutes, and hour". For AWS Canaries, you can set it anywhere from 1 minute to 1 hour. If you set the rate to 0 minutes, this will cause the canary to run one time after it has been started. You also have the ability to set a cron(expression) to set a specific schedule. An optional argument, duration_in_seconds, can also be added which specifies how long the canary should follow the schedule set under expression. If no value is specified, the canary will continue to run until it's stopped.  

*Example schedule for canary to run every 2 minutes with a 2 minute timeout*
```
canary_timeout = 120
canary_schedule_expression = "rate(2 minutes)"
```

## Change region, target service, target URL or enable active tracing. 

You can adjust many of the configuration settings such as the region, target_service, target_url, and the ability to enable active tracing in the terraform.tfvars file. The region indicates where the canary is deployed. The default value is "us-east-1". You can deploy the canary in any of the AWS regions. The `target_service` indicates the name of the service the canary is monitoring. The target URL is the URL of the target service to monitor. All three of these variables can be modified as needed, but the values must be strings. Finally, you can also configure active tracing by providing a boolean value (true, false) for the `enable_active_tracing` variable in the terraform.tfvars file.  

*Example* 
```
region = "us-east-1"
target_service = "test" 
target_url = "https://github.com" 
enable_active_tracing = true 
```

## Change bucket name 

The s3 bucket name is currently dynamically set based on the target service. If you wish to modify it you can do so in the main.tf file (see below). The bucket name must be between 3 and 63 characters, and must start with a letter or a number. The bucket name can consist only of lowercase letters, numbers, dots, and hyphens.  

*Example* 
```
module "s3" {
  source      = "./modules/s3"
  bucket_name = "cw-syn-results-${var.target_service}" # MODIFY THIS LINE IF DESIRED
}
```

## Sensitive screenshots and data

If the canary screenshots / collected data is sensitive, you may configure the s3 bucket and the sns topic to be encrypted.

## Add a managed policy 

If you would like to add a managed policy to the IAM role, this can be added to the main.tf file under the iam module. Any additions can be added in a list format to `managed_policy_arns`.

## Development guide

Any values that aren't expected to be changed may be left hardcoded but all other values should be replaced with variables. 

The .devcontainer folder in this repository is setup to simplify development and manual running of this module. The Dockerfile contains all requires software to run the pre-commit hooks as well as terraform and the awscli.

*How to run pre-commit*
```bash
pre-commit run -a
pre-commit run <hook id> -a
pre-commit run terraform-docs-system -a
# If you desire to install pre-commit hooks to be triggered pre-commit (to not allow commits to be made unless all checks pass):
pre-commit install
```

Pre-commit will only verify terraform formatting, to actually apply terraform formatting, run:

```bash
terraform fmt --recursive
```

.buildspec.yaml is for AWS CodeBuild.