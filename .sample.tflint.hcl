plugin "aws" {
    enabled = true
    version = "0.17.0"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

plugin "azurerm" {
    enabled = true
    version = "0.18.0"
    source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}