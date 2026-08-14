# Configuration

## Environment variables

| Name         | Default | Required | Comments                                                                                                 |
|--------------|---------|----------|----------------------------------------------------------------------------------------------------------|
| SALT         | (none)  | **Yes**  | **Once this is set, do not ever change it.**                                                             | 
| DB_HOST      | (none)  | **Yes**  | Database host                                                                                            |
| DB_USER      | (none)  | **Yes**  |                                                                                                          | 
| DB_PASSWORD  | (none)  | **Yes**  |                                                                                                          | 
| ALLOW_SIGNUP | 0       | No       | 1 = allow signups, 0 = Do not allow signups                                                              |
| ANNOUNCEMENT | (none)  | No       | Show a message on the login screen                                                                       |
| MAX_RAM      | 256m    | No       | Sets the max RAM the software can use, increase this when you have a lot of RSS feeds (ex: 1024m, 2048m) |

### AI

Newsku requires a connection to an Openai API compatible server

| Name           | Default | Required | Comments                                         | 
|----------------|---------|----------|--------------------------------------------------|
| OPENAI_URL     | (none)  | **Yes**  | The url of the open ai compatible instance.      | 
| OPENAI_API_KEY | (none)  | **Yes**  | API Key to talk to the open ai compatible server |
| OPENAI_MODEL   | (none)  | **Yes**  | I tested openai gpt oss 20B with good results    | 

### SMTP Server

Newsku needs a SMTP server for the following features:

- Password resets

Here are the environment variables to set that up

| Name                    | Default               | Required (based on if you want SMTP services enabled) | Comments                                              |
|-------------------------|-----------------------|-------------------------------------------------------|-------------------------------------------------------|
| ROOT_URL                | http://localhost:8080 | No                                                    | The base URL used in the links in email sent to users |
| SMTP_HOST               | (none)                | **Yes**                                               |                                                       |
| SMTP_PORT               | 0                     | **Yes**                                               |                                                       |
| SMTP_USERNAME           | (none)                | No                                                    |                                                       |
| SMTP_PASSWORD           | (none)                | No                                                    |                                                       |
| SMTP_FROM               | (none)                | **Yes**                                               | Who will be the sender of the email                   | 
| SMTP_TRANSPORT_STRATEGY | SMTP                  | **Yes**                                               | Possible values: SMTP, SMTPS, SMTP_TLS                |

### OIDC

Newsku Supports SSO by implementing OIDC. You will need to set up your OIDC client as a Public Client and enable PKCE.
Here are the used callback urls:

```
com.github.lamarios.newku:/oidcRedirect  # for the android application
https://your.newsku-domain.com/redirect.html
```

| Name                   | Default | Required | Comments                                                                                        |
|------------------------|---------|----------|-------------------------------------------------------------------------------------------------|
| OIDC_DISCOVERY_URL     | (none)  | **Yes**  | The discovery URL of your OIDC provider https://id.example.com/.well-known/openid-configuration |
| OIDC_CLIENT_ID         | (none)  | **Yes**  | Your OIDC client id                                                                             |
| OIDC_AUTO_SIGNUP_USERS | false   | No       | Whether to automatically sign up unknown users                                                  |
| OIDC_NAME              | SSO     | no       | Name of your provider to display on the UI                                                      |
