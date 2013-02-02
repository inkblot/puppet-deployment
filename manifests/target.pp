class deployment::target (
	$user => 'deploy',
	$uid  => nil,
	$gid  => nil,
) {
	user { $user:
		uid   => $uid,
		gid   => $gid,
		shell => '/bin/bash',
	}

	group { $user:
		gid => $gid,
	}
}
