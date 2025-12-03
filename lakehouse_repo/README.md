
# Local Lakehouse

We will set up a lake house with MinIO as the backend storage, Iceberg as the table format, Project Nessie as the catalog for Iceberg, Trino as the query engine, dbt as the abstraction for SQL transformation, and finally, Airflow to glue everything together. For the sample data, we will use five input tables from the AdventureWorks sample dataset: product, product_category, product_subcategory, sale, and territories.
<img width="986" height="624" alt="image" src="https://github.com/user-attachments/assets/802f9857-0112-4296-a13a-d2e2c5fdb697" />

### What’s Included

* Cleaned and fixed Docker Compose files for MinIO, Nessie, Trino, and Airflow.
* Updated Dockerfile for Airflow with dbt installation and proper dependency handling.
* Adjusted environment variables and volumes for consistent paths and stable service startup.
* Improved initialization logic for Airflow and Trino services.
* Cleanup of unused configs and removal of redundant Compose parts.
* **Updated `lakehouse_repo/manage-lakehouse.sh`:**

  * Fixed path resolution for custom `LAKEHOUSE_HOME`.
  * Added safer service start/stop handling.
  * Improved logs output and detection of running containers.
  * Unified command structure for `start`, `stop`, `status`, and `rebuild`.
  * Ensured compatibility with the updated directory layout and Compose structure.