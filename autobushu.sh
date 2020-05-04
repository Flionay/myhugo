#!/bin/bash
cd public
git add .
msg="rebuilding site `date`"
git commit -m "$msg"
git push --force gitee master
cd ..
git add .
msg="Origindata of  `date`"
git commit -m "$msg"
git push --force gitee master