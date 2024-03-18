# Wrapper around nagios_timeperiod
define safer_nagios::nagios_timeperiod (
  $nagios_title,
  $timeperiod_name              = undef,
  $ensure                       = undef,
  $alias                        = undef,
  $exclude                      = undef,
  $sunday                       = undef,
  $monday                       = undef,
  $tuesday                      = undef,
  $wednesday                    = undef,
  $thursday                     = undef,
  $friday                       = undef,
  $saturday                     = undef,
  $provider                     = undef,
  $register                     = undef,
  $target                       = undef,
  $use                          = undef,

  $area                         = undef, # Folder name
  $group                        = undef, # File name
) {

  $_target = safer_nagios::nagios_base($target, $area, $group)

  if ! defined(Nagios_timeperiod[$nagios_title]) {
    nagios_timeperiod { $nagios_title :
      ensure          => $ensure,
      timeperiod_name => $timeperiod_name,
      alias           => $alias,
      exclude         => $exclude,
      friday          => $friday,
      monday          => $monday,
      provider        => $provider,
      register        => $register,
      saturday        => $saturday,
      sunday          => $sunday,
      target          => $_target,
      thursday        => $thursday,
      tuesday         => $tuesday,
      use             => $use,
      wednesday       => $wednesday,
    }
  }
}
