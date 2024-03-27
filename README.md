# gitops-bridge-helm-charts

Helper helm chart for the [gitops-bridge project](https://github.com/gitops-bridge-dev)

Add helm repo
```shell
helm repo add gitops-bridge-helm-charts https://gitops-bridge-dev.github.io/gitops-bridge-helm-charts
```

Install a helm chart
```shell
helm install <name> gitops-bridge-helm-charts/<name>
```

Helm Charts Available:
- `aws-ebs-csi` AWS EBS CSI Classes
- `aws-fargate-fluentbit` AWS Fargate FluentBit
- `crossplane-aws-upbound` Crossplane Upbound AWS Provider
- `crossplane-aws` Crossplane AWS Contrib Provider
- `crossplane-helm` Crossplane Helm Provider
- `crossplane-kubernetes` Crossplane Kubernetes Provider

Examples on how to use them in ArgoCD ApplicationSets with gitops-bridge:
- https://github.com/gitops-bridge-dev/gitops-bridge-argocd-control-plane-template/blob/main/bootstrap/control-plane/addons/aws/addons-aws-oss-crossplane-upbound.yaml
- https://github.com/gitops-bridge-dev/gitops-bridge-argocd-control-plane-template/blob/main/bootstrap/control-plane/addons/oss/addons-crossplane-appset.yaml
- https://github.com/gitops-bridge-dev/gitops-bridge-argocd-control-plane-template/blob/main/bootstrap/control-plane/addons/oss/addons-crossplane-helm.yaml
- https://github.com/gitops-bridge-dev/gitops-bridge-argocd-control-plane-template/blob/main/bootstrap/control-plane/addons/oss/addons-crossplane-kubernetes.yaml
- https://github.com/gitops-bridge-dev/gitops-bridge-argocd-control-plane-template/blob/main/bootstrap/control-plane/addons/aws/addons-aws-oss-crossplane-aws.yaml