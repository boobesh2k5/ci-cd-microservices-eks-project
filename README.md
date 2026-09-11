<div align="center">

# 🚀 CI/CD Pipeline Automation for Microservices Application using Jenkins and AWS EKS

### Jenkins • Docker • AWS ECR • AWS EKS • Kubernetes • Argo CD • Trivy • SonarQube

A hands-on AWS DevOps project implementing containerization, CI/CD automation, container security scanning, Kubernetes deployment, and GitOps using Argo CD.

</div>

---

## 🚀 Project Output

The Cafe Web application is containerized with Docker, scanned with Trivy, pushed to Amazon ECR, deployed on Amazon EKS, and exposed through an AWS Load Balancer.

![Webpage Deployment Output](./Webpage%20Deployment%20Output.png)

## ✅ Architecture

                 GitHub
                    │
              Webhook Trigger
                    ▼
                Jenkins
          ┌─────────┴─────────┐
          │                   │
     SonarQube             Trivy
          │                   │
          └─────────┬─────────┘
                    ▼
                Docker
                    │
                    ▼
               Amazon ECR
                    │
                    ▼
               Amazon EKS
                    │
             ┌──────┴──────┐
             │             │
          Pod 1          Pod 2
             │             │
             └──────┬──────┘
                    ▼
             AWS Load Balancer
                    │
                    ▼
             Cafe Web Application
       
### GitOps

GitHub → Argo CD → Amazon EKS



## 🛠️ Tech Stack

| Technology | Purpose |
| :--- | :--- |
| **AWS EC2** | DevOps infrastructure |
| **Jenkins** | CI/CD automation |
| **GitHub** | Source control |
| **Docker** | Containerization |
| **Amazon ECR** | Container registry |
| **Amazon EKS** | Kubernetes platform |
| **Kubernetes** | Application orchestration |
| **Argo CD** | GitOps deployment |
| **SonarQube** | Code quality |
| **Trivy** | Container security |
| **Nginx** | Web server |

---

## 🔄 Jenkins Pipeline
Images are versioned using the Jenkins build number (e.g., `ci-cdpipelineautomation:2`).

### Pipeline Stages

![Pipeline Stages](./Pipeline%20Stages.png)

### Pipeline Steps

![Pipeline Steps](./Pipeline%20Steps.png)

### Jenkins Job

![Pipeline Job UI](./Pipeline%20job%20UI.png)

---

## 🐳 Docker

The Cafe application is served using Nginx.

```dockerfile

FROM nginx:alpine

COPY cafe-webpage-source-code/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

```

## 🛡️ Security

SonarQube: Used for source-code quality and security analysis.

Trivy: Scans Docker images for HIGH and CRITICAL vulnerabilities.

Docker Build → Trivy Scan → Amazon ECR

---
☸️ Amazon EKS

Cluster: project1

Region: eu-north-1

Kubernetes Version: 1.34

Worker Nodes: 2

Namespace: cafe

Application Deployment
cafe-web
├── Replica 1
└── Replica 2
EKS Cluster

---
🌐 AWS Load Balancer

The Kubernetes LoadBalancer Service exposes the application externally.

Internet → AWS Load Balancer → Kubernetes Service → Cafe Web Pods
Load Balancer

---
🚀 Argo CD

Argo CD manages the Kubernetes deployment using GitOps (GitHub → Argo CD → Amazon EKS).

Application: cafe-web

Repository: GitHub

Path: k8s

Namespace: cafe

Sync: Automated

Self-Heal: Enabled

Prune: Enabled

Validated Status:

Synced

Healthy

---
✅ Validation

-> Jenkins pipeline successful

-> Docker image built

-> Trivy scan completed

-> Image pushed to ECR

-> EKS access verified

->2 application pods running

-> Load Balancer created

-> Argo CD Synced & Healthy

-> Cafe application deployed


---
👨‍💻 Author

M Boobeshwaran,
An Cloud & DevOps Engineer Aspirant

AWS • Jenkins • Docker • Kubernetes • EKS • ECR • Argo CD • SonarQube • Trivy • GitHub
