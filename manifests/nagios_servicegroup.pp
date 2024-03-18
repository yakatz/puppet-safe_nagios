# Wrapper around nagios_servicegroup
define safer_nagios::nagios_servicegroup (
  $nagios_title,
  $servicegroup_name            = undef,
  $ensure                       = undef,
  $action_url                   = undef,
  $alias                        = undef,
  $members                      = undef,
  $notes                        = undef,
  $notes_url                    = undef,
  $provider                     = undef,
  $register                     = undef,
  $servicegroup_members         = undef,
  $target                       = undef,
  $use                          = undef,

  $area                         = undef, # Folder name
  $group                        = undef, # File name
) {

  $_target = safer_nagios::nagios_base($target, $area, $group)

  if ! defined(Nagios_servicegroup[$nagios_title]) {
    nagios_servicegroup { $nagios_title :
      ensure               => $ensure,
      servicegroup_name    => $servicegroup_name,
      action_url           => $action_url,
      alias                => $alias,
      members              => $members,
      notes                => $notes,
      notes_url            => $notes_url,
      provider             => $provider,
      register             => $register,
      servicegroup_members => $servicegroup_members,
      target               => $_target,
      use                  => $use,
    }
  }
}
