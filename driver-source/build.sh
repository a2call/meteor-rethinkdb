#!/bin/bash

DIR="$(dirname $0)"

# Compile a minimal file that is enough to build queries into an AST on the
# client. Idea credit to Evan You:
# https://github.com/yyx990803/roetem/tree/master/client/db

pushd $DIR
npm install
popd

# kill the ability to 'run()' queries, but in return get rid of a giant
# dependency on node and sockets and bluebird
sed -i '' "/'\.\/net'/d" "$DIR/node_modules/rethinkdb/ast.js"
sed -i '' "/'bluebird'/d" "$DIR/node_modules/rethinkdb/ast.js"

"$DIR/node_modules/browserify/bin/cmd.js" "$DIR/rethink-query-builder.js" -o "$DIR/../_build/rethink-query-builder.js" -s ___Rethink_r___


