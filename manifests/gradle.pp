# Setting up gradle
class build::gradle {

  $version = 'gradle-2.2.1'

  ensure_resource('package', 'unzip', {'ensure' => 'present' })

  Exec {
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  }

  $url = "https://services.gradle.org/distributions/${version}-bin.zip"

  archive { $version:
    ensure          => present,
    url             => $url,
    digest_string   => 'd38677bceaecb2eb225d76a3e8afbdcf',
    target          => '/usr/share',
    extension       => 'zip',
    require         => Package['unzip'],
    allow_redirects => true
  }

  file { '/usr/share/gradle':
    ensure  => link,
    target  => "/usr/share/${version}/${version}",
    owner   => root,
    group   => root,
    require => Archive[$version]
  }

  file { '/etc/profile.d/gradle.sh':
    ensure => file,
    mode   => '0644',
    source => 'puppet:///modules/build/gradle.sh',
    owner  => root,
    group  => root,
  }

}
