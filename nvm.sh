#!/bin/sh

echo "Setting up NVM..."

# Install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash

nvm install node

