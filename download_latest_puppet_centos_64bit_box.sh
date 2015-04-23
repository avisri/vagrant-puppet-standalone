#!/bin/bash 

pkgmgr=$(which yum || which apt-get || which brew ) 

[ "${pkgmgr%%brew}" == "$pkgmgr" ]  && pkgmgr="sudo $pkgmgr"

#install deps
$pkgmgr install lynx vagrant puppet ||  $pkgmgr cask install vagrant puppet 

latest=`lynx -listonly   -dump https://atlas.hashicorp.com/puppetlabs| tr ' ' '\n'   | grep /centos  | grep -v enterprise | grep 64| grep -v  nocm |sort -n   | tail -1`

vagrant box list | grep -q  `echo $latest | tr '/' '\n'| tail -1`

if [ $? -ne 0 ] && [ "$latest" != "" ]
then
	
	vagrant box add $latest
fi

mkdir -p ~/vagrant/puppet/{manifests,modules}
puppet module install puppetlabs/firewall --modulepath ~/vagrant/puppet/modules

cd ~/vagrant
vagrant up
vagrant ssh 

