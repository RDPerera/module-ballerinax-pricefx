# Attachment upload workflow

Create an upload slot for a customer record, upload a file to it, then list the customer's files. Demonstrates the multi-step slot-then-upload pattern Pricefx uses for file attachments.

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
