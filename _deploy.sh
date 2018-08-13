#!/bin/sh

git clone -b gh-pages https://$GITHUB_TOKEN@github.com/GV-CEPESP/workshopR.git output

cd output

git rm -rf .

cp -r ../public/ ./

git add -A

git commit -m "Updade workshopR"

git push -q origin gh-pages