## pbfcoin Go

Official golang implementation of the pbfcoin protocol

          | Linux   | OSX | ARM | Windows | Tests
----------|---------|-----|-----|---------|------
## pbfcoin Go

Official golang implementation of the pbfcoin protocol

          | Linux   | OSX | ARM | Windows | Tests
----------|---------|-----|-----|---------|------
develop   | (http://www.paybf.com/)
master    | (http://www.paybf.com/)
## Automated development builds

The following builds are build automatically by our build servers after each push to the [develop](http://www.paybf.com/) branch.

## Building the source

For prerequisites and detailed build instructions please read the
[Installation Instructions](https://github.com/pbfcoin/go-pbfcoin/wiki/Building-pbfcoin)
on the wiki.

Building gpbf requires two external dependencies, Go and GMP.
You can install them using your favourite package manager.
Once the dependencies are installed, run

    make gpbf

## Executables

Go pbfcoin comes with several wrappers/executables found in 
[the `cmd` directory](https://github.com/pbfcoin/go-pbfcoin/tree/develop/cmd):

 Command  |         |
----------|---------|
`gpbf` | pbfcoin CLI (pbfcoin command line interface client) |
`bootnode` | runs a bootstrap node for the Discovery Protocol |
`pbftest` | test tool which runs with the [tests](https://github.com/pbfcoin/tests) suite: `/path/to/test.json > pbftest --test BlockTests --stdin`.
`evm` | is a generic pbfcoin Virtual Machine: `evm -code 60ff60ff -gas 10000 -price 0 -dump`. See `-h` for a detailed description. |
`disasm` | disassembles EVM code: `echo "6001" | disasm` |
`rlpdump` | prints RLP structures |
Defining the private genesis state
First, you'll need to create the genesis state of your networks, which all nodes need to be aware of and agree upon. This consists of a small JSON file (e.g. call it genesis.json):

{
  "config": {
    "chainId": <arbitrary positive integer>,
    "homesteadBlock": 0,
    "eip150Block": 0,
    "eip155Block": 0,
    "eip158Block": 0,
    "byzantiumBlock": 0,
    "constantinopleBlock": 0,
    "petersburgBlock": 0
  },
  "alloc": {},
  "coinbase": "0x0000000000000000000000000000000000000000",
  "difficulty": "0x20000",
  "extraData": "",
  "gasLimit": "0x2fefd8",
  "nonce": "0x0000000000000042",
  "mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "timestamp": "0x00"
}
The above fields should be fine for most purposes, although we'd recommend changing the nonce to some random value so you prevent unknown remote nodes from being able to connect to you. If you'd like to pre-fund some accounts for easier testing, create the accounts and populate the alloc field with their addresses.

"alloc": {
  "0x0000000000000000000000000000000000000001": {
    "balance": "111111111"
  },
  "0x0000000000000000000000000000000000000002": {
    "balance": "222222222"
  }
}
With the genesis state defined in the above JSON file, you'll need to initialize every geth node with it prior to starting it up to ensure all blockchain parameters are correctly set:

$ geth init path/to/genesis.json
Creating the rendezvous point
With all nodes that you want to run initialized to the desired genesis state, you'll need to start a bootstrap node that others can use to find each other in your network and/or over the internet. The clean way is to configure and run a dedicated bootnode:

$ bootnode --genkey=boot.key
$ bootnode --nodekey=boot.key
With the bootnode online, it will display an enode URL that other nodes can use to connect to it and exchange peer information. Make sure to replace the displayed IP address information (most probably [::]) with your externally accessible IP to get the actual enode URL.

Note: You could also use a full-fledged geth node as a bootnode, but it's the less recommended way.

## Command line options

`gpbf` can be configured via command line options, environment variables and config files.

To get the options available:

    gpbf help

For further details on options, see the [wiki](https://github.com/bfchain/go-pbfcoin/wiki)

## Contribution

Contribution to PBFCoin is welcomed. Please commit on the develop branch instead of master when sending pull requests.
