# Setting up gradle
class build::gradle {

  $version = 'gradle-2.6'

  ensure_resource('package', 'unzip', {'ensure' => 'present' })

  Exec {
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  }

  $url = "https://services.gradle.org/distributions/${version}-bin.zip"

  archive { $version:
    ensure           => present,
    url              => $url,
    digest_string    => '88a116b028e4749c9d77e514904755a9',
    target           => '/usr/share',
    extension        => 'zip',
    require          => Package['unzip'],
    follow_redirects => true
  }

  file { '/usr/share/gradle':
    ensure  => link,
    target  => "/usr/share/${version}",
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
