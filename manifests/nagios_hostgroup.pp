# Wrapper around nagios_hostgroup
define safer_nagios::nagios_hostgroup (
  $nagios_title,
  $hostgroup_name               = undef,
  $ensure                       = undef,
  $action_url                   = undef,
  $alias                        = undef,
  $hostgroup_members            = undef,
  $members                      = undef,
  $notes                        = undef,
  $notes_url                    = undef,
  $provider                     = undef,
  $realm                        = undef,
  $register                     = undef,
  $target                       = undef,
  $use                          = undef,

  $area                         = undef, # Folder name
  $group                        = undef, # File name
) {

  $_target = safer_nagios::nagios_base($target, $area, $group)

  if ! defined(Nagios_hostgroup[$nagios_title]) {
    nagios_hostgroup { $nagios_title :
      ensure            => $ensure,
      hostgroup_name    => $hostgroup_name,
      action_url        => $action_url,
      alias             => $alias,
      hostgroup_members => $hostgroup_members,
      members           => $members,
      notes             => $notes,
      notes_url         => $notes_url,
      provider          => $provider,
      realm             => $realm,
      register          => $register,
      target            => $_target,
      use               => $use,
    }
  }
}
