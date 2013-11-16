# Define: mesos::service
#
# This module manages mesos serviceation
#
# Parameters: None
#
# Actions: None
#
# Requires: mesos::install
#
# Sample Usage: mesos::service { 'master':
#                 start      => 'yes',
#               }
#
define mesos::service(
  $start = 'no',
  $enable = false,
  $conf_dir = '/etc/mesos',
) {

  if $start == 'yes' {
    service { "mesos-${name}":
      ensure    => 'running',
      hasstatus => true,
      enable    => $enable,
      subscribe => [ File['/etc/default/mesos'],
        File["${conf_dir}/${name}.conf"]
      ],
    }
  }
}
