# countapi
An in-house replacement for countapi.xyz powered by postgrest

## Usage

```bash
curl -XGET https://countapi.maayanlab.cloud/rpc/get?key=somekey

curl -XPOST https://countapi.maayanlab.cloud/rpc/hit -d '{"key": "myidentifier"}'
```

## Deployment

1. Initialize postgres database (see `db/migrations/*`)
2. Configure & deploy `postgrest` to connect
