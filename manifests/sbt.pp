# setting up sbt
class build::sbt {

  $url  = 'http://dl.bintray.com/sbt/debian'
  $version = '0.13.7'

  $deb  = "sbt-${version}.deb"

  exec{'download vagrant deb':
    command => "wget --max-redirect=1 -P /tmp ${url}/${deb}",
    user    => 'root',
    path    => ['/usr/bin','/bin'],
    unless  => 'test -f /usr/bin/sbt'
  } ->

  package{'sbt':
    source   => "/tmp/${deb}",
    provider => dpkg
  }


}
