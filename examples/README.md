# Examples

The `ballerinax/pricefx` connector provides practical examples illustrating usage in various scenarios.

| Example | Description |
|---------|-------------|
| [`product-catalog-management`](./product-catalog-management) | Add a new product to the catalog, update one of its fields, then list matching products to confirm the change. |
| [`customer-quote-workflow`](./customer-quote-workflow) | Add a new customer, create a quote for them, then submit the quote for approval. |
| [`price-list-calculation`](./price-list-calculation) | Create a new price list, run its calculation, then fetch the calculated price list. |
| [`attachment-upload-workflow`](./attachment-upload-workflow) | Create an upload slot for a customer record, upload a file to it, then list the customer's files. |

## Prerequisites

1. Build and push the connector to your local Ballerina repository:
   ```bash
   cd ballerina
   bal pack && bal push --repository=local
   ```

2. For each example, create a `Config.toml` in the example directory with your Pricefx credentials:
   ```toml
   token = "<your-pricefx-jwt-token>"
   serviceUrl = "https://<your-node>.pricefx.com/pricefx/<your-partition>"
   ```

## Running an example

```bash
cd examples/<example-name>
bal run
```
