module Puppet::Parser::Functions
	newfunction(:deployment_key, :type => :rvalue) do |args|
		if args[0] == 'exists'
			File.exist?('/etc/puppet/keys/id_deploy')
		elsif args[0] == 'private'
			IO.read('/etc/puppet/keys/id_deploy')
		elsif args[0] == 'public exists'
			File.exist?('/etc/puppet/keys/id_deploy.pub')
		else
			IO.read('/etc/puppet/keys/id_deploy.pub').split(' ')[['type', 'key', 'comment'].index args[0]]
		end
	end
end
