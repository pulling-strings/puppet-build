# Class: lein
#
# This module manages lein see https://github.com/technomancy/leiningen
# Requires:
#  Java installed
# [Remember: No empty lines between comments and class definition]
class build::lein {

  package{ 'leiningen':
    ensure  => installed,
    require => [Class['jdk'], Class['barbecue'], Class['apt::update']]
  } ->

  file{'/usr/bin/lein':
    mode  => 'a+rwx'
  }

}
