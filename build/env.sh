#!/bin/sh

set -e

if [ ! -f "build/env.sh" ]; then
    echo "$0 must be run from the root of the repository."
    exit 2
fi

# Create fake Go workspace if it doesn't exist yet.
workspace="$PWD/build/_workspace"
root="$PWD"
pbfdir="$workspace/src/github.com/pbfcoin"
if [ ! -L "$pbfdir/go-pbfcoin" ]; then
    mkdir -p "$pbfdir"
    cd "$pbfdir"
    ln -s ../../../../../. go-pbfcoin
    cd "$root"
fi

# Set up the environment to use the workspace.
# Also add Godeps workspace so we build using canned dependencies.
GOPATH="$pbfdir/go-pbfcoin/Godeps/_workspace:$workspace"
GOBIN="$PWD/build/bin"
export GOPATH GOBIN

# Run the command inside the workspace.
cd "$pbfdir/go-pbfcoin"
PWD="$pbfdir/go-pbfcoin"

# Launch the arguments with the configured environment.
exec "$@"
