#!/bin/sh

git clone -b gh-pages https://$GITHUB_TOKEN@github.com/GV-CEPESP/workshopR.git output

git config --global user.email "rafael.coelho.x@gmail.com"
git config --global user.name "RCCSilva"

cd output

git rm -rf .

cp -r ../public/* .

git add -A

git commit -m "Updade workshopR"

git push -q origin gh-pages