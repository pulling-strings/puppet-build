# Class: gradle
#
#
class gradle {

  $version = 'gradle-1.0-rc-3'

  package{"unzip": ensure  => present }

  Exec {
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
  }

  archive { $version:
    ensure	=> present,
    url 	=> "http://downloads.gradle.org/distributions/${version}-all.zip",
    checksum	=> false,
    src_target	=> '/tmp',
    target	=> '/usr/share',
    extension	=> 'zip',
    require  => Package['unzip']
  }

  file { '/usr/share/gradle':
    ensure	=> link,
    target	=> "/usr/share/$version",
    owner	=> root, group	=> root,
    require	=> Archive["$version"],
  }

  file { '/etc/profile.d/gradle.sh':
    ensure	=> file,
    mode	=> 644,
    source	=> 'puppet:///modules/gradle/gradle.sh',
    owner	=> root, group	=> root,
  }

}
