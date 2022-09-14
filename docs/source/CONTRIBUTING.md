# Contributing

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
