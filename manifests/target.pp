class deployment::target (
	$user    = 'deploy',
	$uid     = undef,
	$gid     = undef,
	$home    = '/var/lib/deploy',
	$groups  = undef,
	$sudo_as = [],
) {
	user { $user:
		ensure  => present,
		uid     => $uid,
		gid     => $user,
		shell   => '/bin/bash',
		home    => $home,
		system  => true,
		groups  => $groups,
		require => Group[$user],
	}

	group { $user:
		ensure => present,
		gid    => $gid,
		system => true,
	}

	file {
		"${user} home directory":
			path   => $home,
			ensure => directory,
			owner  => $user,
			group  => $user,
			mode   => 0700;

		"${user} ssh directory":
			path   => "${home}/.ssh",
			ensure => directory,
			owner  => $user,
			group  => $user,
			mode   => 0700;
	}

	deployment::key { $user: }

	sudo::conf { $user:
		content => template('deployment/sudo.erb'),
	}
}
