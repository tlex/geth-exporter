# geth_exporter
go-Ethereum exporter for Prometheus

## General
A go-Ethereum exporter, written in Python3, for Prometheus.

## Configuration
### `node_exporter` Configuration
`geth_exporter` doesn't open a port, rather it uses the `textfile` collector in `node_exporter`. You need to start
node_exporter with the option `-collectors.enabled textfile` and you need to specify the folder where the metrics are
located with `-collector.textfile.directory /your/path`

### `geth` Configuration
`geth_exporter` uses the HTTP-RPC server in geth. To enable it, you need to start geth with the following options:
*   `--rpc`
*   `--rpcapi=db,eth,net,web3,personal`

> *WARNING* Never allow access from the Internet to the `geth` HTTP-RPC server.

### Environment Variables
The following environment variables are used by `geth_exporter`:
*   `LOGLEVEL` one of `DEBUG`, `INFO`, `WARNING`, `ERROR`

### Configuration file
The configuration file is located in `/etc/geth-exporter/geth-exporter.yaml`. The following values are accepted:
```
geth_exporter:
  prom_folder: '/var/lib/node_exporter' # node_exporter textfile folder
  interval: 60 # polling interval in seconds
  geth_host: 'localhost' # server with the geth HTTP-RPC server
  geth_port: '8545' # the port of the geth HTTP-RPC
  additional_accounts: []
```

You can specify additional accounts, that are not located in your geth wallet:
```
geth_exporter:
  prom_folder: '/var/lib/node_exporter'
  interval: 60
  geth_host: 'localhost'
  geth_port: '8545'
  additional_accounts:
    - 0xaaaa...
    - 0xbbbb...
    - 0xcccc...
```
