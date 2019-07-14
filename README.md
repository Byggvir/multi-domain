# multi-domain
Multi Domain Site Config for FF Voreifel

This site configuration is based on teh work of **site-ffmwu.git**


This repository holds the site configuration for the following Freifunk MWU (Mainz, Wiesbaden & Umgebung) communities:

* [Freifunk Rheinbach](http://www.freifunk-rheinbach.de)
* [Freifunk Meckenheim](http://wiesbaden.freifunk.net)
* [Freifunk Voreifel](https://www.freifunk-bingen.de)

Teh following description is copied from  **site-ffmwu.git** and untested


## Repository structure
In addition to the _master_ branch we maintain one branch for each major release.

All new commits should go to the _master_ branch first and cherry-picked to other branches.

The gluon version used to build the firmware is referenced as a git submodule in `gluon`.
To ensure that the submodule is initialized correctly, call `git submodule update --init` after a checkout.

To update gluon to the latest `origin/master` use `git submodule update --remote`.

## Version schema
For the versioning of our _stable_ and _testing_ releases we use the Gluon version and add the date of building and release branch.

## Switch between domains from command line

With teh following script you can change the domain from a console with ssh. *(This assumes that you have an authorized ssh-key on the node.)*

```
#!/bin/bash

echo Switch router to new domain
echo "Usage: $0 <newdom>\n"
echo "Default: dom14old\n"
echo "Use with care!"

if [ -n "$1" ] 
then
   DOM=$1
else
   DOM='dom14old'
fi

if [ -n "$2" ] 
then
   IP=$2
else
   IP=10.152.112.1 # replace with your local node IP
fi

echo $IP

ssh root@$IP 'uci set gluon.core.domain="'$DOM'" ; gluon-reconfigure; reboot; exit'

```