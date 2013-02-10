class deployment::master (
	$comment,
	$keydir  = '/etc/puppet/keys',
) {
	File {
		owner => 'puppet',
		group => 'puppet',
		mode  => '0600',
	}

	file {
		$keydir:
			ensure => directory,
			mode   => '0700';

		"${keydir}/id_deploy":
			ensure  => present,
			content => $deploy_key,
			replace => false;
	}

	exec { 'ssh-keygen_id_deploy.pub':
		command => "/usr/bin/ssh-keygen -y -f ${keydir}/id_deploy -C ${comment} > ${keydir}/id_deploy.pub",
		user    => 'puppet',
		require => File["${keydir}/id_deploy"],
		creates => "${keydir}/id_deploy.pub",
	}
}
