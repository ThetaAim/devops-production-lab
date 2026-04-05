# 🚀 DevOps CI/CD Pipeline with Jenkins, Docker & AWS

---

![Docker](https://img.shields.io/badge/Docker-Containerized-blue?logo=docker)
![Jenkins](https://img.shields.io/badge/Jenkins-CI%2FCD-red?logo=jenkins)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange?logo=amazon-aws)
![Status](https://img.shields.io/badge/Build-Passing-brightgreen)

## Overview
This project demonstrates a production-style CI/CD pipeline that builds, tests, deploys, and validates a containerized application using Jenkins, Docker, and AWS.

Infrastructure is fully provisioned using Terraform.

---

## Architecture

```
Developer → GitHub → Jenkins → Docker → Amazon ECR → EC2 → ALB → Users
```

---

## Infrastructure (Terraform)

Infrastructure is defined and provisioned using Terraform:

- VPC with public and private subnets  
- NAT Gateway for private instances  
- EC2 instances running Docker  
- Application Load Balancer (ALB)  
- Target Group with health checks  
- IAM roles for EC2 (SSM + ECR access)  
- Security Groups for controlled traffic  

Deployment instances are tagged:

```
Role = app
```

These tags are used by AWS SSM to target instances dynamically.

---

## Pipeline Flow

### 1. Checkout
Pulls the latest code from GitHub.

### 2. Change Detection
The pipeline runs only when changes occur in `services/app`.

### 3. Build
Builds a Docker image tagged with the commit hash.

### 4. Test
Runs a container in an isolated Docker network:

```bash
docker run -d --name test-app --network app-net app-image
```

Validates service readiness:

```bash
curl -sf http://test-app
```

### 5. Push
Pushes the image to Amazon ECR:
- Commit-based tag  
- `latest` tag  

### 6. Deploy
- Uses AWS SSM with tag-based targeting  
- Stops the current container  
- Pulls the new image  
- Starts the updated container  
- Saves the previous image for rollback  

### 7. Health Check
Verified through the ALB:

```
GET /health
```

Uses retry logic to handle application startup time.

### 8. Rollback
If the health check fails:
- Renames the current container (for traceability)  
- Stops the failed container  
- Restores the previous image  
- Restarts the application  

---

## Networking

- Docker bridge network: `app-net`  
- Internal DNS-based communication between containers  

No reliance on localhost or static IPs.

---

## Limitations

- Deployment uses SSM without orchestration  
- Rollback is local per instance  
- No zero-downtime deployment  
- ALB may route traffic to instances during restart  

---

## Future Improvements

- Rolling or blue/green deployment  
- Migration to ECS or Kubernetes  
- Centralized rollback management  
- Monitoring and alerting  
- Zero-downtime deployment strategy  

---

## Key Concepts Demonstrated

- CI/CD pipeline design  
- Docker build, run, and networking  
- Jenkins pipeline automation  
- AWS integration (ECR, EC2, ALB, SSM)  
- Terraform-based infrastructure provisioning  
- Health-based deployment validation  
- Basic rollback mechanism  

---

## Notes

- Containers are ephemeral  
- Each deployment replaces the previous version  
- Health checks validate real system behavior  
