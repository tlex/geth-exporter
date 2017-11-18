# geth-exporter
go-Ethereum exporter for Prometheus

## General
A go-Ethereum exporter, written in Python3, for Prometheus.
### URLs
*   [https://gitlab.ix.ai/altcoins/geth-exporter.git](https://gitlab.ix.ai/altcoins/geth-exporter.git)
*   [https://gitlab.com/tlex/geth-exporter.git](https://gitlab.com/tlex/geth-exporter.git)
*   [https://github.com/tlex/geth-exporter.git](https://github.com/tlex/geth-exporter.git)

## Installation
### Manual Installation
*   Copy the file `geth-exporter` somewhere in your path (for example under `/usr/local/bin`)
*   If the defaults listed below in the configuration file need changing, create `/etc/geth-exporter/geth-exporter.yaml`
Alternatively you can build a Debian/Ubuntu package by using the build.sh script.

## Configuration
### `node_exporter` Configuration
`geth-exporter` can work in one of two ways:
*   export the metrics over a HTTP port (default `9305`)
*   write the metrics to a local folder for the `node_exporter` to collect them using the `textfile` collector. You need
to start node_exporter with the option `-collectors.enabled textfile` and you need to specify the folder where the
metrics are located with `-collector.textfile.directory /your/path`. The default path is `/var/lib/node_exporter`

### `geth` Configuration
`geth-exporter` uses the HTTP-RPC server in geth. To enable it, you need to start geth with the following options:
*   `--rpc`
*   `--rpcapi=db,eth,net,web3,personal`

> *WARNING* Never allow access from the Internet to the `geth` HTTP-RPC server.

### Environment Variables
The following environment variables are used by `geth-exporter`:
*   `LOGLEVEL` one of `DEBUG`, `INFO`, `WARNING`, `ERROR`

### Configuration file
The configuration file is located in `/etc/geth-exporter/geth-exporter.yaml`. The following values are accepted:
```
geth_exporter:
  geth_host: 'localhost' # server with the geth HTTP-RPC server
  geth_port: 8545 # the port of the geth HTTP-RPC
  enable_accounts: 'on' # one of 'on', 'off' - enable the metrics for accounts
  additional_accounts: [] # List of additional accounts to export metrics (besides the ones configured in geth)
  export: 'text' # one of 'text', 'http'
  prom_folder: '/var/lib/node_exporter' # node_exporter textfile folder, only needed if export is set to 'text'
  interval: 60 # polling interval in seconds, only needed if export is set to 'text'
  listen_port: 9305 # only needed if export is set to 'http'
```

You can specify additional accounts, that are not located in your geth wallet:
```
geth_exporter:
  prom_folder: '/var/lib/node_exporter'
  interval: 60
  geth_host: 'localhost'
  geth_port: 8545
  additional_accounts:
    - 0xaaaa...
    - 0xbbbb...
    - 0xcccc...
```

## Example Metric
```
# HELP geth_block_number The number of the most recent block
# TYPE geth_block_number gauge
geth_block_number 4227955.0
# HELP geth_syncing Boolean syncing status
# TYPE geth_syncing gauge
geth_syncing 0.0
# HELP geth_hash_rate The current number of hashes per second the node is mining with
# TYPE geth_hash_rate gauge
geth_hash_rate 0.0
# HELP geth_gas_price_wei The current gas price in Wei
# TYPE geth_gas_price_wei gauge
geth_gas_price_wei 28987298387.0
# HELP account_balance Account Balance
# TYPE account_balance gauge
account_balance{account="0xaaaa...",currency="ETH",type="geth"} 1.225055210216375
# HELP geth_mining Boolean mining status
# TYPE geth_mining gauge
geth_mining 0.0
```

## Donations
If you want to support this work, donations in ETH are welcomed.
*   `0x90833394db1b53f08b9d97dab8beff69fcf3ba49`
