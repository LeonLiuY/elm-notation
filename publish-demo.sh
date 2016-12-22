#!/bin/bash

set -e


dir=`mktemp -d`

git clone `pwd` $dir

(cd $dir && git checkout gh-pages && git remote set-url origin git@github.com:liuyang1204/elm-notation.git && git pull)

elm-make examples/DrawPreview.elm --output=$dir/elm.js

cp -r fonts lib $dir
cp examples/draw.html $dir/index.html

# change url path
sed -i 's/\/elm.js/elm.js/g' $dir/index.html
sed -i 's/\/lib/lib/g' $dir/index.html
sed -i 's/\/fonts/fonts/g' $dir/index.html

(cd $dir && git add . && git commit -m 'update demo' && git push origin gh-pages)
