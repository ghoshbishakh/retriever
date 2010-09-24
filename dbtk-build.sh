#!/bin/bash

# cleanup, then create current-release folder
sudo rm current-release -rf
mkdir current-release
cd current-release

# create src folder and checkout from SVN
mkdir src
cd src
svn checkout https://weecology.svn.beanstalkapp.com/dbtk/trunk/
mv trunk dbtk
sudo rm dbtk/dbtk-build.sh

# make apidocs
cd ..
sudo pydoctor --add-package=src/dbtk --make-html
cd src/dbtk
sudo cp apidocs/*.* ../../apidocs/
sudo rm apidocs -rf

# build deb package
sudo python setup.py --command-packages=stdeb.command bdist_deb
sudo rm dbtk.egg-info build dist -rf
cd deb_dist
cp *.deb ../
cd ..
sudo rm deb_dist -rf
mkdir linux
mv *.deb linux/
mv linux ../../