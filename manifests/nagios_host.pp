# Wrapper around nagios_host
define safer_nagios::nagios_host (
  # Built-in nagios_command fields
  $nagios_title                 = $title,
  $host_name                    = undef,
  $ensure                       = undef,
  $action_url                   = undef,
  $active_checks_enabled        = undef,
  $address                      = undef,
  $host_alias                   = undef,
  $business_impact              = undef,
  $check_command                = undef,
  $check_freshness              = undef,
  $check_interval               = undef,
  $check_period                 = undef,
  $contact_groups               = undef,
  $contacts                     = undef,
  $display_name                 = undef,
  $event_handler                = undef,
  $event_handler_enabled        = undef,
  $failure_prediction_enabled   = undef,
  $first_notification_delay     = undef,
  $flap_detection_enabled       = undef,
  $flap_detection_options       = undef,
  $freshness_threshold          = undef,
  $high_flap_threshold          = undef,
  $hostgroups                   = undef,
  $icon_image                   = undef,
  $icon_image_alt               = undef,
  $initial_state                = undef,
  $low_flap_threshold           = undef,
  $max_check_attempts           = undef,
  $notes                        = undef,
  $notes_url                    = undef,
  $notification_interval        = undef,
  $notification_options         = undef,
  $notification_period          = undef,
  $notifications_enabled        = undef,
  $obsess_over_host             = undef,
  $parents                      = undef,
  $passive_checks_enabled       = undef,
  $poller_tag                   = undef,
  $process_perf_data            = undef,
  $provider                     = undef,
  $realm                        = undef,
  $register                     = undef,
  $retain_nonstatus_information = undef,
  $retain_status_information    = undef,
  $retry_interval               = undef,
  $stalking_options             = undef,
  $statusmap_image              = undef,
  $target                       = undef,
  $use                          = undef,
  $vrml_image                   = undef,

  $area                         = undef, # Folder name
  $group                        = undef, # File name
  $resolve_dns                  = false,
  $lldp_info                    = undef,
) {

  $_target = safer_nagios::nagios_base($target, $area, $group)

  if ( $host_alias and $resolve_dns and !$address ) {
    if ($host_alias.is_a(Array)) {
      if ($host_alias.count > 1) {
        fail('Can\'t do DNS lookup with more than one host_alias')
      }
      $_alias_lookup = $host_alias[0]
    } else {
      $_alias_lookup = $host_alias
    }
    $_address = dnsquery::a("${_alias_lookup}")[0] # lint:ignore:only_variable_string Quotes are used to cast possible array to string
  } else {
    $_address = $address
  }

  if ( $lldp_info ) {
    if (!$parents) {
      $parents0 = []
    } else {
      $parents0 = $parents
    }
    $lldp_upstreams = safer_nagios::lldp_upstreams($lldp_info)
    $_parents = concat($parents0, $lldp_upstreams )
  } else {
    $_parents = $parents
  }

  if ! defined(Nagios_host[$nagios_title]) {
    nagios_host { $nagios_title:
      ensure                       => $ensure,
      host_name                    => $host_name,
      action_url                   => $action_url,
      active_checks_enabled        => $active_checks_enabled,
      address                      => $_address,
      alias                        => $host_alias,
      business_impact              => $business_impact,
      check_command                => $check_command,
      check_freshness              => $check_freshness,
      check_interval               => $check_interval,
      check_period                 => $check_period,
      contact_groups               => $contact_groups,
      contacts                     => $contacts,
      display_name                 => $display_name,
      event_handler                => $event_handler,
      event_handler_enabled        => $event_handler_enabled,
      failure_prediction_enabled   => $failure_prediction_enabled,
      first_notification_delay     => $first_notification_delay,
      flap_detection_enabled       => $flap_detection_enabled,
      flap_detection_options       => $flap_detection_options,
      freshness_threshold          => $freshness_threshold,
      high_flap_threshold          => $high_flap_threshold,
      hostgroups                   => $hostgroups,
      icon_image                   => $icon_image,
      icon_image_alt               => $icon_image_alt,
      initial_state                => $initial_state,
      low_flap_threshold           => $low_flap_threshold,
      max_check_attempts           => $max_check_attempts,
      notes                        => $notes,
      notes_url                    => $notes_url,
      notification_interval        => $notification_interval,
      notification_options         => $notification_options,
      notification_period          => $notification_period,
      notifications_enabled        => $notifications_enabled,
      obsess_over_host             => $obsess_over_host,
      parents                      => $_parents,
      passive_checks_enabled       => $passive_checks_enabled,
      poller_tag                   => $poller_tag,
      process_perf_data            => $process_perf_data,
      provider                     => $provider,
      realm                        => $realm,
      register                     => $register,
      retain_nonstatus_information => $retain_nonstatus_information,
      retain_status_information    => $retain_status_information,
      retry_interval               => $retry_interval,
      stalking_options             => $stalking_options,
      statusmap_image              => $statusmap_image,
      target                       => $_target,
      use                          => $use,
      vrml_image                   => $vrml_image,
    }
  }
}
