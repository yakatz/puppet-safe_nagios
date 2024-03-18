# Wrapper around nagios_contactgroup
define safer_nagios::nagios_contactgroup (
  $nagios_title,
  $contactgroup_name            = undef,
  $ensure                       = undef,
  $alias                        = undef,
  $contactgroup_members         = undef,
  $members                      = undef,
  $provider                     = undef,
  $register                     = undef,
  $target                       = undef,
  $use                          = undef,

  $area                         = undef, # Folder name
  $group                        = undef, # File name
) {

  $_target = safer_nagios::nagios_base($target, $area, $group)

  if ! defined(Nagios_contactgroup[$nagios_title]) {
    nagios_contactgroup { $nagios_title :
      ensure               => $ensure,
      contactgroup_name    => $contactgroup_name,
      alias                => $alias,
      contactgroup_members => $contactgroup_members,
      members              => $members,
      provider             => $provider,
      register             => $register,
      target               => $_target,
      use                  => $use,
    }
  }
}
