# terraform-eks

> Terraform으로 구성하는 **AWS EKS(Elastic Kubernetes Service) 클러스터** 인프라 자동화 프로젝트  
> EKS Cluster, IAM Role, Security Group을 코드로 프로비저닝하고 AWS Load Balancer Controller를 연동합니다.

---

## Tech Stack

| Category | Tool |
|---|---|
| IaC | Terraform |
| Container Orchestration | AWS EKS (Kubernetes) |
| Ingress | AWS Load Balancer Controller |
| App Packaging | Helm |

---

## 파일 구조

```
.
├── eks_cluster.tf             # EKS Cluster, Node Group
├── eks_iam.tf                 # EKS용 IAM Role 및 Policy
├── eks_sg.tf                  # EKS Control Plane / Node 보안 그룹
├── _vars.tf                   # 변수 정의
├── _terraform.auto.tfvars     # 변수 값 (vpc_id, subnet, sg 등)
├── _backend.tf                # Terraform Backend 설정
├── _data.tf                   # Data Source (VPC, Subnet 등)
└── update-kubeconfig.sh       # kubeconfig 업데이트 스크립트
```

---

## 1. EKS Cluster 생성

![EKS Cluster](https://user-images.githubusercontent.com/77256060/166134633-da33acc1-f6bb-49df-890a-3a2eb2d17c2a.png)

```bash
# 1. 레포지토리 클론
git clone https://github.com/DACHANCHOI/terraform-eks.git
cd terraform-eks

# 2. 환경변수 설정
# _terraform.auto.tfvars에서 아래 항목 수정
# - vpc_id
# - private_subnet_id
# - azs
# - default_sg_id

# 3. 프로비저닝
terraform init
terraform apply

# 4. kubeconfig 업데이트 (Provisioning 완료 후 kubeconfig_{CLUSTER_NAME} 파일 생성됨)
aws eks update-kubeconfig --region=ap-northeast-2 --name=dcc --alias=dcc
```

---

## 2. AWS Load Balancer Controller 설치

EKS Ingress에 AWS ALB를 사용하기 위한 컨트롤러를 Helm으로 설치합니다.

![AWS Load Balancer Controller](https://user-images.githubusercontent.com/77256060/166134638-263f084c-692b-4fb9-a9b7-c942f69665a2.png)

> 공식 문서: [AWS Load Balancer Controller v2.3](https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.3/)

```bash
git clone https://github.com/DACHANCHOI/k8-cicd-argocd.git
cd k8-cicd-argocd/aws-load-balancer-controller

# values-eks.yaml에서 clusterName 수정 후
make upgrade-eks
```

![AWS Load Balancer Controller 설치 완료](https://user-images.githubusercontent.com/77256060/166134655-239aef3f-05b3-4f0e-b76e-f8011f3adef2.png)

---

## 관련 레포지토리

- [k8-cicd-argocd](https://github.com/DACHANCHOI/k8-cicd-argocd) — ArgoCD 설치 및 GitOps 배포 구성
