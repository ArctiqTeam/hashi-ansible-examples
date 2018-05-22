# This is a demo on dynamic secrets in the cloud

## First Generate an access token for use in Vault ... you can skip this if you already have a token

Here is an example with GitHub Auth:

```
curl -k --request POST --data '{"token": "PERSONAL_ACCESS_TOKEN"}' http://vault-vault.apps.ocp.lab.arctiq.ca/v1/auth/github/login
{"request_id":"cec4e95b-ef90-f29d-2399-036c7dddgdfb","lease_id":"","renewable":false,"lease_duration":0,"data":null,"wrap_info":null,"warnings":null,"auth":{"client_token":"33632a1c-e7ef-f1da-fae8-d9d4jtis7fec","accessor":"7ca2281e-cd88-364f-e9fb-f48a0b0fb5d4","policies":["cloud-provisioners","default"],"metadata":{"org":"ArctiqTeam","username":"arctiqtim"},"lease_duration":2764800,"renewable":true,"entity_id":"da5a501e-d61a-6144-4903-68fcd7193d6f"}}
```

Use the `client_token` and set the environment var `$VAULT_TOKEN` with that token

## Now the Terraform config is ready

