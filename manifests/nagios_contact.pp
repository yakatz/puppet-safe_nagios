# Wrapper around nagios_contact
define safer_nagios::nagios_contact (
  $nagios_title,
  $contact_name                  = undef,
  $ensure                        = undef,
  $address1                      = undef,
  $address2                      = undef,
  $address3                      = undef,
  $address4                      = undef,
  $address5                      = undef,
  $address6                      = undef,
  $alias                         = undef,
  $can_submit_commands           = undef,
  $contactgroups                 = undef,
  $email                         = undef,
  $host_notification_commands    = undef,
  $host_notification_options     = undef,
  $host_notification_period      = undef,
  $host_notifications_enabled    = undef,
  $pager                         = undef,
  $provider                      = undef,
  $register                      = undef,
  $retain_nonstatus_information  = undef,
  $retain_status_information     = undef,
  $service_notification_commands = undef,
  $service_notification_options  = undef,
  $service_notification_period   = undef,
  $service_notifications_enabled = undef,
  $target                        = undef,
  $use                           = undef,

  $area                          = undef, # Folder name
  $group                         = undef, # File name
) {

  $_target = safer_nagios::nagios_base($target, $area, $group)

  if ! defined(Nagios_contact[$nagios_title]) {
    nagios_contact { $nagios_title :
      ensure                        => $ensure,
      contact_name                  => $contact_name,
      address1                      => $address1,
      address2                      => $address2,
      address3                      => $address3,
      address4                      => $address4,
      address5                      => $address5,
      address6                      => $address6,
      alias                         => $alias,
      can_submit_commands           => $can_submit_commands,
      contactgroups                 => $contactgroups,
      email                         => $email,
      host_notification_commands    => $host_notification_commands,
      host_notification_options     => $host_notification_options,
      host_notification_period      => $host_notification_period,
      host_notifications_enabled    => $host_notifications_enabled,
      pager                         => $pager,
      provider                      => $provider,
      register                      => $register,
      retain_nonstatus_information  => $retain_nonstatus_information,
      retain_status_information     => $retain_status_information,
      service_notification_commands => $service_notification_commands,
      service_notification_options  => $service_notification_options,
      service_notification_period   => $service_notification_period,
      service_notifications_enabled => $service_notifications_enabled,
      target                        => $_target,
      use                           => $use,
    }
  }
}
