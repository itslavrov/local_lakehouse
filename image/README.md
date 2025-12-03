# Local Lakehouse - Ubuntu 22.04 Image (Packer + VK Cloud)

This directory contains a **Packer configuration (`image.pkr.hcl`) for building a custom Ubuntu 22.04 image in VK Cloud**.
The image includes system tools, Docker, networking utilities, and preloaded project directories (`lakehouse_repo` and `scripts`).

The resulting image can be used as a base VM for running the Local Lakehouse environment or any automation on top of Ubuntu in VK Cloud.

---

## Contents

* **`image.pkr.hcl`** - Packer configuration for VK Cloud (OpenStack provider).
* **`.env`** - Environment variables containing:

  * `PKR_VAR_network_id`
  * `PKR_VAR_source_image`
  * `PKR_VAR_availability_zone`
* **`playbook.yml`** - Ansible provisioning (installs Docker, tools, updates the system).
* **`ansible.cfg`** - Local Ansible configuration.
* Preloaded project folders are copied automatically:

  * `/opt/lakehouse_repo`
  * `/opt/scripts`

---

## Requirements

* Packer ≥ 1.9
* OpenStack CLI configured for VK Cloud (`OS_AUTH_URL`, `OS_USERNAME`, etc.)
* Valid values in `.env` (network ID, base Ubuntu image ID)

---

## How to Use

### 1. Fill in `.env`

Example:

```
PKR_VAR_network_id=<network_id>
PKR_VAR_source_image=<ubuntu_22_image_id>
PKR_VAR_availability_zone=MS1
```

### 2. Export variables

```
cd image
export $(grep -v '^#' .env | xargs)
```

### 3. Initialize Packer

```
packer init .
```

### 4. Build the image

```
packer build .
```

Packer will:

* Create a temporary VM in VK Cloud
* Copy `lakehouse_repo` and `scripts` to `/opt`
* Run the Ansible playbook
* Produce a new reusable image in your VK Cloud project

---

## Result

You will get an image named:

```
local-lakehouse-ubuntu-22.04
```

You can now create VM instances from this image directly in VK Cloud.