# Wrapper around nagios_hostdependency
define safer_nagios::nagios_hostdependency (
  $nagios_title,
  $ensure                        = undef,
  $dependency_period             = undef,
  $dependent_host_name           = undef,
  $dependent_hostgroup_name      = undef,
  $execution_failure_criteria    = undef,
  $host_name                     = undef,
  $hostgroup_name                = undef,
  $inherits_parent               = undef,
  $notification_failure_criteria = undef,
  $provider                      = undef,
  $register                      = undef,
  $target                        = undef,
  $use                           = undef,

  $area                          = undef, # Folder name
  $group                         = undef, # File name
) {

  $_target = safer_nagios::nagios_base($target, $area, $group)

  if ! defined(Nagios_hostdependency[$nagios_title]) {
    nagios_hostdependency { $nagios_title :
      ensure                        => $ensure,
      dependency_period             => $dependency_period,
      dependent_host_name           => $dependent_host_name,
      dependent_hostgroup_name      => $dependent_hostgroup_name,
      execution_failure_criteria    => $execution_failure_criteria,
      host_name                     => $host_name,
      hostgroup_name                => $hostgroup_name,
      inherits_parent               => $inherits_parent,
      notification_failure_criteria => $notification_failure_criteria,
      provider                      => $provider,
      register                      => $register,
      target                        => $_target,
      use                           => $use,
    }
  }
}
