# countapi
An in-house replacement for countapi.xyz powered by postgrest

## Usage

```bash
# get number of pagehits for this particular key
curl -XGET https://countapi.maayanlab.cloud/rpc/get?key=somekey

# register a pagehit for this particular key
curl -XPOST https://countapi.maayanlab.cloud/rpc/hit -d '{"key": "myidentifier"}'
```

## Deployment

1. Initialize postgres database (see `db/migrations/*`)
2. Configure & deploy `postgrest` to connect
