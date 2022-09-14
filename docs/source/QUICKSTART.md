# Quickstart

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