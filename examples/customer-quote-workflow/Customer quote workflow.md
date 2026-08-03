# Customer quote workflow

Add a new customer, create a quote for them, then submit the quote for approval. Demonstrates how customer and quote master data connect in a typical sales-quoting flow.

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
