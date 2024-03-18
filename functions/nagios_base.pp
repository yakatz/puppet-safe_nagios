function safer_nagios::nagios_base(
  $target = undef,
  $area   = undef,
  $group  = undef,
) {
  $base_dir = hiera('safer_nagios::base_dir', '/opt/nagios/puppet')

  if (!$target and !($area and $group)) {
    fail('$area and $group (or $target) must be specified.')
  }
  if ($target and ($area or $group)) {
    fail('$area and $group are exclusive with $target. Specify only one.')
  }

  if $target {
    $_target = $target
  } else {
    $_target = "${base_dir}/conf.d/${area}/${group}.conf"

    if ! defined(File["${base_dir}/conf.d/${area}"]) {
      file { "${base_dir}/conf.d/${area}":
        ensure  => 'directory',
        recurse => true,
      }
    }
  }
  $_target
}
