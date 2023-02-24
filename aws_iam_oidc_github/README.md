# AWS federation for GitHub Actions

```hcl
module "github" {
  source  = ""

  github_repositories = [
    "org/repo",
  ]
}
```

Based on https://github.com/unfunco/terraform-aws-oidc-github
