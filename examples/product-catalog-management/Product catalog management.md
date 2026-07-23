# Product catalog management

Add a new product to the catalog, update one of its fields, then list matching products to confirm the change. Demonstrates the core create/update/list lifecycle for Pricefx product master data.

## Prerequisites

- Ballerina Swan Lake 2201.12.x or later
- Push the connector to the local repository:
  ```bash
  cd ballerina
  bal pack && bal push --repository=local
  ```
- Create a `Config.toml` in this directory:
  ```toml
  token = "<your-pricefx-jwt-token>"
  serviceUrl = "https://<your-node>.pricefx.com/pricefx/<your-partition>"
  ```

## Run the example

```bash
bal run
```
