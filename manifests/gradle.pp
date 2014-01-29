# Class: gradle
#
#
class build::gradle {

  $version = 'gradle-1.10'

  package{'unzip': ensure  => present }

  Exec {
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  }

  $url = "http://downloads.gradle.org/distributions/${version}-bin.zip"

  archive { $version:
    ensure        => present,
    url           => $url,
    digest_string => '5594e5bc7f088683c1e90f99aa49f5fc',
    src_target    => '/opt',
    target        => '/usr/share',
    extension     => 'zip',
    require       => Package['unzip'],
  }

  file { '/usr/share/gradle':
    ensure  => link,
    target  => "/usr/share/${version}",
    owner   => root,
    group   => root,
    require => Archive[$version]
  }

  file { '/etc/profile.d/gradle.sh':
    ensure=> file,
    mode  => '0644',
    source=> 'puppet:///modules/build/gradle.sh',
    owner => root,
    group => root,
  }

}
