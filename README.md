# safer_nagios

Manage Nagios with Puppet safely

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with safer_nagios](#setup)
    * [What safer_nagios affects](#what-safer_nagios-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with safer_nagios](#beginning-with-safer_nagios)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

The biggest problem with managing Nagios/Naemon/etc. with Puppet is if you break
Puppet, for example, by losing your PuppetDB, you will also lose your monitoring.
This module provides a layer of indirection which insulates the actual monitoring
configuration from Puppet. Puppet will build a configuration next to the actual
monitoring system configuration which can be copied in place by the admin.

## Setup

### What safer_nagios affects

This module should never effect running configuration.

## Usage

In the manifest for a monitored host:
```puppet
@@safer_nagios::nagios_host { $facts['networking']['fqdn']:
  host_name   => $facts['networking']['hostname'],
  alias       => $facts['networking']['fqdn'],

  area        => hiera('nagios::host::area', 'hosts'),
  group       => hiera('nagios::host::group', 'base'),
  resolve_dns => true,
  lldp_info   => $facts['lldp'],
}
```

In the manifest for a monitoring server:
```puppet
# The Nagios Config Repo is a directory outside of Nagios where Puppet manages the configuration.
# This configuration should then be copied to the production Nagios config.
# This prevents puppet from accidentally wiping out the entire configuration.
include safer_nagios::config_repo
```

TODO: Include usage examples for common use cases in the **Usage** section. Show your
users how to use your module to solve problems, and be sure to include code
examples. Include three to five examples of the most important or common tasks a
user can accomplish with your module. Show users how to accomplish more complex
tasks that involve different types, classes, and functions working in tandem.

## Development

TODO: In the Development section, tell other users the ground rules for contributing
to your project and how they should submit their work.
