# JQ

You can install `jq` with:

```shell
wapm install jq
```

## Running

You can run the jq CLI

```shell
$ echo '{"foo": 0 }' | wapm run jq .
{
  "foo": 0
}
```


## Building from Source

You can build JQ from source very easily with [wasienv](https://github.com/wasienv/wasienv).

Steps:
1. Run `bash build.sh`
