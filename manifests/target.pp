class deployment::target (
	$user = 'deploy',
	$uid  = undef,
	$gid  = undef,
) {
	user { $user:
		ensure  => present,
		uid     => $uid,
		gid     => $user,
		shell   => '/bin/bash',
		system  => true,
		require => Group[$user],
	}

	group { $user:
		ensure => present,
		gid    => $gid,
		system => true,
	}
}
