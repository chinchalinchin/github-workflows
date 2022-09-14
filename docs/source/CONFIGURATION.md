# Configuration

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