class caddy::install {

	group {$caddy::caddy_group:
    ensure => present,
    system => true,
  }

  user {$caddy::caddy_user:
    ensure     => present,
    shell      => '/usr/sbin/nologin',
    gid        => $caddy::caddy_group,
    system     => true,
    home       => $caddy::caddy_home,
    managehome => true,
  }

  file {$caddy::caddy_ssl_dir:
    ensure  => directory,
    owner   => $caddy::caddy_user,
    group   => $caddy::caddy_group,
    mode    => '0755',
    require => User[$caddy::caddy_user],
  }

  file { '/etc/caddy/config':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
  } ->
  file { '/etc/caddy/Caddyfile':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "puppet:///modules/caddy/Caddyfile",
  }


	include archive

  # Hard coded Latest and amd64
  archive { "/tmp/caddy-${version}":
		ensure       => present,
		source       => "https://caddyserver.com/download/linux/amd64?license=personal&telemetry=off",
		extract      => true,
		extract_path => "/usr/local/bin",
		creates      => "/usr/local/bin/caddy",
		cleanup 		 => true,
	}

	file { "/usr/local/bin/caddy":
		owner   => 'root',
		group   => 'root',
		mode    => '0755',
		require => Archive["/tmp/caddy-${version}"],
	}

}
