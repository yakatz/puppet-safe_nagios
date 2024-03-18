# Wrapper around nagios_command
define safer_nagios::nagios_command (
  # Built-in nagios_command fields
  $nagios_title,
  $command_name = undef,
  $ensure       = undef,
  $command_line = undef,
  $poller_tag   = undef,
  $provider     = undef,
  $target       = undef,
  $use          = undef,

  $area         = undef, # Folder name
  $group        = undef, # File name
) {

  $_target = safer_nagios::nagios_base($target, $area, $group)

  if ! defined(Nagios_command[$nagios_title]) {
    nagios_command { $nagios_title:
      ensure       => $ensure,
      command_name => $command_name,
      command_line => $command_line,
  #    group        => $group,
  #    mode         => $mode,
  #    owner        => $owner,
      poller_tag   => $poller_tag,
      provider     => $provider,
      target       => $_target,
      use          => $use,
    }
  }
}
