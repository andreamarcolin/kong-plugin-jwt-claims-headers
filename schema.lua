return {
  no_consumer = true,
  fields = {
    uri_param_names = {type = "array", default = {"jwt", "access_token"}},
    continue_on_error = {type = "boolean", default = true},
    claims = {type = "array", default = {".*"}},
    namespaced_claims = {
      type = "table",
      schema = {
        fields = {
          namespace = {type = "string", default = "https://example.com/"},
          claims = {type = "array", default = {".*"}}
        }
      }
    }
  }
}
