# API
If you ever want to integrate with newsku via API you can.

## OpenAPI

The OpenAPI descriptions are here: https://your.newsku.url/v3/api-docs
Swagger ui is available at https://your.newsku.url/swagger-ui/index.html

## Authentication

All the endpoints under `/api/` require authentication through the `Authorization` header. You can use either:

- **A JWT token**, obtained by logging in (`POST /login`), passed with the `Bearer` prefix: `Authorization: Bearer <token>`
- **An API key**, passed as is, without the `Bearer` prefix: `Authorization: nsk_...`

## API keys

API keys are the easiest way to access your data from scripts, other applications or AI assistants.

To create one, go to Settings > API keys and click on **Create API key**. Give it a name so you remember where it is used,
and optionally an expiry date.

The key is only displayed once, right after it is created, so copy it and store it somewhere safe. Newsku doesn't store
the key itself, only a hash of it, so it can't be shown again. If you lose it, delete it and create a new one.

The API keys list shows when each key was last used. Deleting a key immediately revokes access for anything using it.

Example:

```bash
curl -H "Authorization: nsk_your_api_key" "https://your.newsku.url/api/users"
```

## MCP server

Newsku has a built-in [MCP](https://modelcontextprotocol.io) server, so AI assistants can read your news for you, e.g.
"What are the most important articles from yesterday?" or "Summarize this week's Linux news and mark those articles as
read".

The server uses the Streamable HTTP transport and is available at:

```
https://your.newsku.url/api/mcp
```

It is authenticated with an API key passed in the `Authorization` header, without the `Bearer` prefix.

### Available tools

| Tool                      | Description                                                                                                                                                                                                                          |
|---------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `get_feed_items`          | Gets the articles from your feeds published within a date range, most important first. Dates are ISO-8601, either a date (`2025-11-01`) or a date-time (`2025-11-01T08:00:00Z`). Articles below your minimum importance are excluded. |
| `mark_feed_items_as_read` | Marks articles as read, using the ids returned by `get_feed_items`.                                                                                                                                                                  |

Reading articles through MCP doesn't mark them as seen for the new articles notifications.

### Setting up a client

With [Claude Code](https://docs.claude.com/en/docs/claude-code):

```bash
claude mcp add --transport http newsku https://your.newsku.url/api/mcp --header "Authorization: nsk_your_api_key"
```

Other clients that support remote MCP servers over HTTP usually take a configuration similar to this one:

```json
{
  "mcpServers": {
    "newsku": {
      "type": "http",
      "url": "https://your.newsku.url/api/mcp",
      "headers": {
        "Authorization": "nsk_your_api_key"
      }
    }
  }
}
```
