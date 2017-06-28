#!/bin/sh

NODE="$(which node)"
echo "NODE"
echo $NODE

$NODE ./iOS-style-parser/index.js $1 $2
