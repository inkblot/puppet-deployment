define deployment::key (
	$ensure  = present,
) {
	if deployment_key('public exists') {
		$comment = deployment_key('comment')
		ssh_authorized_key { "${name}_${comment}":
			ensure  => $ensure,
			user    => $name,
			type    => deployment_key('type'),
			key     => deployment_key('key'),
			name    => "${name}_${comment}",
			require => File["${name} ssh directory"],
		}
	}
}
