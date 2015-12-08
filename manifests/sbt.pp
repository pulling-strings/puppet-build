# setting up sbt
class build::sbt {
  $key_id = '2EE0EA64E40A89B84B2DF73499E82A75642AC823'

  apt::key {'sbt':
    id     => $key_id,
    server => 'hkp://keyserver.ubuntu.com:80'
  } ->

  apt::source { 'sbt':
    location => 'https://dl.bintray.com/sbt/debian',
    repos    => '',
    release  => '/',
    key      => $key_id,
    include  => {
      src => false
    }
  } ->

  package{'sbt':
    ensure => present
  }

}
