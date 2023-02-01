#!/bin/sh
#
# Starts a local fast-synced geth node.

DEFAULT_NETWORK=mainnet

if [ "$NETWORK" = "" ]; then
	NETWORK=$DEFAULT_NETWORK
fi

if [ "$PRUNE_GETH" != "" ]; then
    exec geth snapshot prune-state --datadir.ancient=/root/ancient-data
elif [ "$START_GETH" != "" ]; then
	if [ "$NETWORK" != "$DEFAULT_NETWORK" ]; then
		exec geth --goerli --syncmode snap --http --http.addr "0.0.0.0" --http.vhosts=* --http.api "eth,net" --ipcdisable --authrpc.addr "0.0.0.0" --authrpc.port "8551" --authrpc.vhosts "*" --authrpc.jwtsecret "/root/jwttoken/jwtsecret.hex" --verbosity 4 --bootnodes="enode://011f758e6552d105183b1761c5e2dea0111bc20fd5f6422bc7f91e0fabbec9a6595caf6239b37feb773dddd3f87240d99d859431891e4a642cf2a0a9e6cbb98a@51.141.78.53:30303,enode://a61215641fb8714a373c80edbfa0ea8878243193f57c96eeb44d0bc019ef295abd4e044fd619bfc4c59731a73fb79afe84e9ab6da0c743ceb479cbb6d263fa91@3.11.147.67:30303,enode://d4f764a48ec2a8ecf883735776fdefe0a3949eb0ca476bd7bc8d0954a9defe8fea15ae5da7d40b5d2d59ce9524a99daedadf6da6283fca492cc80b53689fb3b3@46.4.99.122:32109"
	else
		exec geth --syncmode snap --http --http.addr "0.0.0.0" --http.vhosts=* --http.api "eth,net" --ipcdisable --datadir.ancient=/root/ancient-data --authrpc.addr "0.0.0.0" --authrpc.port "8551" --authrpc.vhosts "*" --authrpc.jwtsecret "/root/jwttoken/jwtsecret.hex"
	fi
fi