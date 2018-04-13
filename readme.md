
A simple Kong plugin to add unencrypted, base64-decoded claims from a JWT payload as request headers to the upstream service.

## How it works

When enabled, this plugin will add new headers to requests based on the claims in the JWT provided in the request. The generated headers follow the naming convention of `X-<claim-name>`.
It supports both standard (eg. iss, exp) and custom claims, with explicit support for OIDC-conformant namespaced claims (eg. Auth0 custom claims, see 
see https://auth0.com/docs/api-auth/tutorials/adoption/scope-custom-claims)
 
For example, if the JWT payload object is

```json
{
  "sub"   : "1234567890",
  "name"  : "John Doe",
  "https://example.com/role": "user"
}
```

and we want to extract `name` and `https://example.com/role` claims, then the following headers would be added

```
X-name : "John Doe"
X-role : "user"
```

## Configuration

Similar to the built-in JWT Kong plugin, you can associate the jwt-claims-headers plugin with an api with the following request

```bash
curl -X POST http://localhost:8001/apis/29414666-6b91-430a-9ff0-50d691b03a45/plugins \
  --data "name=jwt-claims-headers" \
  --data "config.uri_param_names=jwt,access_token" \
  --data "config.continue_on_error=true" \
  --data "config.claims=.*" \
  --data "config.namespaced_claims.namespace=https://example.com/" \
  --data "config.namespaced_claims.claims=.*"
```

form parameter|required|description
---|---|---
`name`|*required*|The name of the plugin to use, in this case: `jwt-claims-headers`
`uri_param_names`|*optional*|A list of querystring parameters that Kong will inspect to retrieve JWTs. Defaults to `jwt,access_token`.
`continue_on_error`|*required*|Whether to send the request to the upstream service if a failure occurs (no JWT token present, error decoding, etc). Defaults to `true`.
`claims`|*required*|A list of non-namespaced claims that Kong will expose in request headers. Lua pattern expressions are valid, e.g., `kong-.*` will include `kong-id`,`kong-email`, etc. Defaults to .* (include all claims). 
`namespaced_claims.namespace`|*required*|The namespace that should be used to match custom namespaced claims. Defaults to `https://example.com/`.
`namespaced_claims.claims`|*required*|A list of namespaced claims that Kong will expose in request headers. Lua pattern expressions are valid, e.g., `kong-.*` will include `{namespace}kong-id`,`{namespace}kong-email`, etc. Defaults to .* (include all claims).
**Note:** Namespaced claims will be added to request headers WITHOUT the namespace, as shown in the previous example.

## Credits 

This fork adds namepaced claims extraction ability to the awesome https://github.com/wshirey/kong-plugin-jwt-claims-headers. 
All credits to [wshirey](https://github.com/wshirey) for the great work with the original plugin.
