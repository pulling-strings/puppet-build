# Class: lein
#
# This module manages lein see https://github.com/technomancy/leiningen
# Requires:
#  Java installed
# [Remember: No empty lines between comments and class definition]
class build::lein {

  $url = 'https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein'

  exec{'wget lein':
    command => "wget ${url} -O /usr/local/bin/lein",
    user    => 'root',
    path    => ['/usr/bin','/bin',]
  }

  file{'/usr/local/bin/lein':
    mode  => 'a+rwx'
  }

}
