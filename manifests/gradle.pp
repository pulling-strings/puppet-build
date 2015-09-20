# Setting up gradle
class build::gradle {

  $version = 'gradle-2.3.0'

  ensure_resource('package', 'unzip', {'ensure' => 'present' })

  Exec {
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  }

  $url = "https://services.gradle.org/distributions/${version}-bin.zip"

  archive { $version:
    ensure          => present,
    url             => $url,
    digest_string   => '8adc26fe7ee5325b9cff735a12a79044',
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
