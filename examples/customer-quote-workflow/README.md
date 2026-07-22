# Customer quote workflow

Add a new customer, create a quote for them, then submit the quote for approval. Demonstrates how customer and quote master data connect in a typical sales-quoting flow.

## Prerequisites

- Ballerina Swan Lake 2201.x or later
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
