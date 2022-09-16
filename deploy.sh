#!/usr/bin/env sh

set -e

npm run build

cd dist

git init

git add .

git commit -m "New Deploy"

git push -f https://github.com/LucioGhedo/vue-boolflix.git master:gh-pages

cd ..