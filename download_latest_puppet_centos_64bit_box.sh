
latest=`lynx -listonly   -dump https://atlas.hashicorp.com/puppetlabs| tr ' ' '\n'   | grep /centos  | grep -v enterprise | grep 64| grep -v  nocm |sort -n   | tail -1`

if [ "$latest" != "" ]
then
	
	vagrant box add base $latest
fi

mkdir -p ~/vagrant/puppet/{manifests,modules}
cd ~/vagrant
vagrant init

