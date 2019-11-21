#!/bin/bash

set -e
set -x

sudo apt-get update
sudo apt-get upgrade -y

# Need gnupg for fish
sudo apt-get install -y gnupg