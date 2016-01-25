#!/bin/bash

set -e

git checkout master
elm-make examples/DrawPreview.elm --output=/tmp/elm.js
git checkout gh-pages
mv /tmp/elm.js .
git add elm.js
git commit -m 'update demo'
git push origin gh-pages
git checkout master
