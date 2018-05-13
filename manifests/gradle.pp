# Setting up gradle
class build::gradle {

  $version = 'gradle-4.7'

  ensure_resource('package', 'unzip', {'ensure' => 'present' })

  $url = "https://services.gradle.org/distributions/${version}-bin.zip"

  archive { $version:
    ensure          => present,
    url             => $url,
    digest_string   => '3e5af867778cd0a8e00e62257f426e09',
    target          => '/usr/share',
    extension       => 'zip',
    require         => Package['unzip'],
    allow_redirects => true
  }

  file { '/usr/share/gradle':
    ensure  => link,
    target  => "/usr/share/${version}",
    owner   => root,
    group   => root,
    require => Archive[$version]
  }

  file{'/usr/bin/gradle':
    ensure => link,
    target => "/usr/share/gradle/${version}/bin/gradle"
  }

  file { '/etc/profile.d/gradle.sh':
    ensure => file,
    mode   => '0644',
    source => 'puppet:///modules/build/gradle.sh',
    owner  => root,
    group  => root,
  }

}
