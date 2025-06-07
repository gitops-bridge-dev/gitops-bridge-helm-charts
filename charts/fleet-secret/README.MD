# Fleet Secret Helm Chart

## Overview
A Helm chart for managing Kubernetes secrets in a GitOps environment, specifically designed for cluster registration and secret management. This chart handles multiple secret types including cluster credentials, repository access, and ECR authentication, with support for both direct secret creation and external secrets management through External Secrets Operator.

## Prerequisites
- Kubernetes 1.16+
- Helm 3.x
- External Secrets Operator installed in the cluster (required for external secrets functionality)
- AWS credentials configured for Secrets Manager access (when using AWS features)
- ArgoCD installed in the target namespace (typically 'argocd')

## Secret Types Supported

### Cluster Secrets
- Manages ArgoCD cluster secrets for registration
- Supports both direct and external secrets management
- Configurable through `externalSecret` or `secret` values
- Automatically adds required ArgoCD secret labels

### Repository Secrets
- Handles Git repository authentication
- Supports GitHub App authentication
- Configurable through `gitExternalSecrets` values
- Supports multiple repository configurations

### ECR Authentication
- Manages ECR authentication token rotation
- Creates tokens for container registry access
- Configurable through `ecrAuthenticationToken` values
- Supports automatic token refresh

### AWS Secret Store
- Sets up SecretStore/ClusterSecretStore for AWS Secrets Manager
- Configurable through `secretStore` values
- Supports IAM role configuration for cross account

## Configuration

### AWS Secret Store Configuration

```yaml
secretStore:
  enabled: true        # Enable/disable SecretStore creation
  kind: "SecretStore"  # Type of store - SecretStore or ClusterSecretStore
  name: "aws-secrets-manager"  # Name of the SecretStore resource
  region: ""          # AWS region where Secrets Manager is located
  role: ""           # Optional IAM role ARN for accessing Secrets Manager
```

### External Secret Configuration

```yaml
# Configuration for cluster registration secret via External Secrets
externalSecret:
  enabled: true       # Enable/disable cluster registration secret
  secretStoreRefName: "fleet-eks-secret-store"  # Reference to SecretStore
  secretStoreRefKind: "SecretStore"  # Type of secret store to reference
  server: "self"      # Cluster API server - 'self' for local, 'remote' for external
  secretManagerSecretName: ""  # AWS Secrets Manager secret name containing cluster credentials
  clusterName: ""     # Name for the registered cluster
```

### Git External Secrets Configuration

```yaml
gitExternalSecrets:
  enabled: true       # Enable/disable git repository external secrets
  secretStoreRefName: "fleet-eks-secret-store"  # Reference to SecretStore
  secretStoreRefKind: "SecretStore"  # Type of secret store to reference
  externalSecrets:
    addons:          # Configuration for addons repository and external secret name
      gitUrl: ""     # Git repository URL
      secretName: "git-addons"  # K8s secret name to create
      secretManagerSecretName: ""  # AWS Secrets Manager secret name containing git credentials
```

### ECR Authentication Configuration

```yaml
ecrAuthenticationToken:
  enabled: true      # Enable/disable ECR token generation
  region: eu-west-2  # AWS region where ECR is located
  name: "ecr-token"  # Name of the token generator
  namespace: "argocd"  # Namespace where to create the secret
  secretName: "argocd-ecr-credentials"  # Name of the K8s secret for ECR credentials
```

## Parameters

### Global Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `secretStore.enabled` | Enable AWS Secrets Manager store | `false` |
| `secretStore.kind` | Type of secret store | `"SecretStore"` |
| `secretStore.name` | Name of the secret store | `"aws-secrets-manager"` |
| `secretStore.region` | AWS region for Secrets Manager | `""` |
| `secretStore.role` | IAM role ARN for AWS access | `""` |

### External Secret Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `externalSecret.enabled` | Enable external secret creation | `false` |
| `externalSecret.secretStoreRefName` | Reference to secret store | `"fleet-eks-secret-store"` |
| `externalSecret.server` | Server type (self/remote) | `"self"` |
| `externalSecret.clusterName` | Name of the cluster | `""` |
| `externalSecret.secretManagerSecretName` | Name of secret in AWS Secrets Manager | `""` |

### ECR Authentication Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `ecrAuthenticationToken.enabled` | Enable ECR authentication | `false` |
| `ecrAuthenticationToken.region` | AWS region for ECR | `"eu-west-2"` |
| `ecrAuthenticationToken.namespace` | Namespace for ECR secret | `"argocd"` |
| `ecrAuthenticationToken.name` | Name of ECR token generator | `"ecr-token"` |
| `ecrAuthenticationToken.secretName` | Name of ECR secret | `"argocd-ecr-credentials"` |

### Git Secrets Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `gitExternalSecrets.enabled` | Enable external Git secrets | `false` |
| `gitExternalSecrets.secretStoreRefName` | Reference to secret store | `"fleet-eks-secret-store"` |

## Usage Examples

### Basic Cluster Registration Secret

```yaml
externalSecret:
  enabled: true
  secretStoreRefName: "fleet-eks-secret-store"
  server: "remote"
  clusterName: "prod-cluster-01"
  secretManagerSecretName: "cluster-prod-01"
```

### ECR Authentication Setup

```yaml
ecrAuthenticationToken:
  enabled: true
  region: eu-west-2
  namespace: "argocd"
  secretName: "ecr-creds"
```

### Git Repository Authentication

```yaml
gitExternalSecrets:
  enabled: true
  secretStoreRefName: "fleet-eks-secret-store"
  externalSecrets:
    addons:
      secretName: "git-addons"
      secretManagerSecretName: "git-addons-creds"
```

## Notes

- All secrets are created in the ArgoCD namespace by default
- The ECR authentication feature requires External Secrets Operator to be pre-installed
- When using AWS features, ensure proper IAM permissions are configured
- For GitHub App authentication, ensure all required credentials are properly configured in AWS Secrets Manager
- Secret names should be unique within the namespace

## Version Support

- Chart Version: 0.1.0
- App Version: 1.16.0
- Kubernetes: >=1.16.0-0
- Helm: >=3.0.0-0

## License

This chart is licensed under the Apache License 2.0.
```