# Price list calculation

Create a new price list, run its calculation, then fetch the calculated price list. Demonstrates the typical price-list authoring and recalculation flow.

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
