# multi-domain
Multi Domain Site Config for FF Voreifel

This site configuration is a redesign of oure older site configuration for [Freifung Rheinbach](https://freifunk-rheinbach.de).

This git is further inspired by the work of [site-ffmwu.git](https://github.com/freifunk-mwu/site-ffmwu).

This repository holds the site configuration for the following Freifunk Rhein Sieg Community and following domains:

* Soziale Netzwerke (dom05)
* Meckenheim (dom08)
* Rheinbach (dom10)
* Meckenheim Alt (dom13)
* Rheinbach (dom14) used to transfer nodes to new gateways
* Rheinbach Alt (dom14old) for the old gateways
* Testfunk

The following description is copied from *site-ffmwu.git* and untested

## Repository structure
In addition to the _master_ branch we maintain one branch for each major release.

All new commits should go to the _master_ branch first and cherry-picked to other branches.

The gluon version used to build the firmware is referenced as a git submodule in `gluon`.
To ensure that the submodule is initialized correctly, call `git submodule update --init` after a checkout.

To update gluon to the latest `origin/master` use `git submodule update --remote`.

## Version schema
For the versioning of our _stable_ and _testing_ releases we use the Gluon version and add the date of building and release branch.

## Switch between domains from command line

With the following script you can change the domain from a console with ssh. *(This assumes that you have an authorized ssh-key or a root  passwd on the node.)*

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
	IP=10.152.112.1
fi

echo $IP


ssh root@$IP 'uci set gluon.core.domain="'$DOM'" ; gluon-reconfigure; reboot; exit'

```