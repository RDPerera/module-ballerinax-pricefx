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
  username = "<your-pricefx-username>"
  password = "<your-pricefx-password>"
  partition = "<your-partition>"
  serviceUrl = "https://<your-node>.pricefx.com/pricefx/<your-partition>"

  # Optional. Uncomment if you have a Pricefx API key - the connector then authenticates via
  # the faster `POST /token`. Without it, the connector falls back to `GET /login/extended`
  # (HTTP Basic auth), which needs no separate key but is slower per request.
  # pricefxKey = "<your-pricefx-api-key>"
  ```

## Run the example

```bash
bal run
```
