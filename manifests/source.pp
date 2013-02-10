define deployment::source (
	$home  = 'UNDEF',
	$group = 'UNDEF'
) {
	$real_home = $home ? {
		'UNDEF' => "/home/${name}",
		default => $home,
	}

	$real_group = $group ? {
		'UNDEF' => $name,
		default => $group,
	}

	File {
		owner => $name,
		group => $real_group,
	}

	file { "${real_home}/.ssh":
		ensure => directory,
		mode   => 0700,
	}

	if deployment_key('exists') {
		file { "${real_home}/.ssh/id_deploy":
			content => deployment_key('private'),
			mode    => 0600;
		}
	}
}
