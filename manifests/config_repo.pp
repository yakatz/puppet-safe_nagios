# Collect nagios resources in non-default location
class safer_nagios::config_repo {
  tag 'nagios_collect'

  $base_dir = hiera('safer_nagios::base_dir', '/opt/nagios/puppet')

  file { ["${base_dir}/", "${base_dir}/conf.d", ] :
    ensure  => 'directory',
    recurse => true,
  }

  # Nagios Commands
  safer_nagios::Nagios_command <<|  |>>

  # Nagios Contacts
  safer_nagios::Nagios_contact <<|  |>>

  # Nagios Contact Groups
  safer_nagios::Nagios_contactgroup <<|  |>>

  # Nagios Hosts
  safer_nagios::Nagios_host <<|  |>>

  # Nagios Host Dependencies
  safer_nagios::Nagios_hostdependency <<|  |>>

  # Nagios Host Escalations
  safer_nagios::Nagios_hostescalation <<|  |>>

  # Nagios Host Groups
  safer_nagios::Nagios_hostgroup <<|  |>>

  # Nagios Services
  safer_nagios::Nagios_service <<|  |>>

  # Nagios Service Dependencies
  safer_nagios::Nagios_servicedependency <<|  |>>

  # Nagios Service Escalations
  safer_nagios::Nagios_serviceescalation <<|  |>>

  # Nagios Service Groups
  safer_nagios::Nagios_servicegroup <<|  |>>

  # Nagios Time Periods
  safer_nagios::Nagios_timeperiod <<|  |>>


  $puppetcronrun_tagged = @(EOT/L)
    cronjob -E -c "/opt/puppetlabs/bin/puppet agent \
    --onetime --verbose --no-daemonize \
    --no-usecacheonfailure --no-splay --show_diff --tags nagios_collect"
    |-EOT

  cron { 'Put puppet run for nagios after other runs complete':
    command     => $puppetcronrun_tagged,
    environment => [
      'PATH=/root/perl5/bin:/opt/puppetlabs/puppet/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      'PERL5LIB=/root/perl5/lib/perl5:',
    ],
    user        => root,
    minute      => 0,
    hour        => 10,
  }


}
