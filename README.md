# Lakehouse DevKit

This project provides a fully automated **local Lakehouse setup** built on **MinIO, Nessie, Trino, and Airflow**.
The environment is designed for quick provisioning, reproducible development, and consistent deployment across local machines and VK Cloud.

### Repository Structure

* **scripts/** - automation for installing dependencies, generating environment files, and managing the full Lakehouse lifecycle.
* **lakehouse_repo/** - the actual Lakehouse stack (Docker Compose, configs, DBT, Airflow, DAGs).
* **image/** - Packer + Ansible configuration for building a custom Ubuntu 22.04 image in VK Cloud with all required tools preinstalled.

### Summary

With these components, you can deploy a complete Lakehouse environment in minutes - locally or in VK Cloud - using a standardized, fully automated workflow.