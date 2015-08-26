#!/bin/sh

/Users/ceco/src/jazzy/bin/jazzy -m Flowthings \
-a "Ceco Gakovic" \
-u https://github.com/appsmonkey \
-g https://github.com/appsmonkey/Flowthings \
--github-file-prefix https://github.com/jpsim/SourceKitten/blob/0.4.4 \
--module-version 0.4.4 \
-r http://cityos.io/Flowthings/ \
-x -workspace,FlowthingsKit.xcworkspace,-scheme,Flowthings \
-c
