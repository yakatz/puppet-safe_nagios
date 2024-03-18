# Wrapper around nagios_servicedependency
define safer_nagios::nagios_servicedependency (
  $nagios_title,
  $ensure                        = undef,
  $dependency_period             = undef,
  $dependent_host_name           = undef,
  $dependent_hostgroup_name      = undef,
  $dependent_service_description = undef,
  $execution_failure_criteria    = undef,
  $host_name                     = undef,
  $hostgroup_name                = undef,
  $inherits_parent               = undef,
  $notification_failure_criteria = undef,
  $provider                      = undef,
  $register                      = undef,
  $service_description           = undef,
  $target                        = undef,
  $use                           = undef,

  $area                          = undef, # Folder name
  $group                         = undef, # File name
) {

  $_target = safer_nagios::nagios_base($target, $area, $group)

  if ! defined(Nagios_servicedependency[$nagios_title]) {
    nagios_servicedependency { $nagios_title :
      ensure                        => $ensure,
      dependency_period             => $dependency_period,
      dependent_host_name           => $dependent_host_name,
      dependent_hostgroup_name      => $dependent_hostgroup_name,
      dependent_service_description => $dependent_service_description,
      execution_failure_criteria    => $execution_failure_criteria,
      host_name                     => $host_name,
      hostgroup_name                => $hostgroup_name,
      inherits_parent               => $inherits_parent,
      notification_failure_criteria => $notification_failure_criteria,
      provider                      => $provider,
      register                      => $register,
      service_description           => $service_description,
      target                        => $_target,
      use                           => $use,
    }
  }
}
