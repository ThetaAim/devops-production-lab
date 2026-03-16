# AWS Production-Like DevOps Platform

## Overview
This repository contains a production-like DevOps laboratory built from scratch to simulate real-world cloud operations.

The focus of this project is **operational reliability**, not feature development.
It is designed to model how modern DevOps teams provision infrastructure, deploy workloads, handle failures, and recover systems under realistic conditions.

The platform emphasizes:
- Infrastructure as Code
- Failure simulation and recovery
- Secure and controlled access
- Observability-driven operations
- Clear incident documentation

## Philosophy
This is **not** a demo project.
This is **not** a step-by-step tutorial.
This is **not** a copy of an existing reference architecture.

Instead, this repository represents a controlled environment where systems are intentionally stressed, misconfigured, and broken in order to:
- observe real failure modes
- practice systematic debugging
- apply corrective actions
- document operational decisions and lessons learned

## What This Project Demonstrates
- End-to-end infrastructure provisioning on AWS using Terraform
- Kubernetes-based application runtime (EKS)
- CI/CD workflows with Jenkins
- Network isolation and access control (RBAC, NetworkPolicies)
- Monitoring, alerting, and autoscaling strategies
- Incident-driven thinking and post-mortem style documentation

## Audience
This project is intended for:
- DevOps Engineers
- Platform Engineers
- SREs
- Hiring managers reviewing hands-on operational experience

The goal is not to show *that* things work,
but to demonstrate **how failures are identified, analyzed, and resolved** in a production-like environment.
