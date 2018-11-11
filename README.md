
# puppetwebhook

[![Travis branch](https://img.shields.io/travis/voxpupuli/puppet-puppetwebhook/master.svg?style=flat-square)](https://travis-ci.org/voxpupuli/puppet-puppetwebhook)
[![Puppet Forge](https://img.shields.io/puppetforge/v/puppet/puppetwebhook.svg?style=flat-square)](https://forge.puppetlabs.com/puppet/puppetwebhook)
[![Puppet Forge](https://img.shields.io/puppetforge/dt/puppet/puppetwebhook.svg?style=flat-square)](https://forge.puppet.com/puppet/puppetwebhook)
[![Puppet Forge](https://img.shields.io/puppetforge/e/puppet/puppetwebhook.svg?style=flat-square)](https://forge.puppet.com/puppet/puppetwebhook)
[![Puppet Forge](https://img.shields.io/puppetforge/f/puppet/puppetwebhook.svg?style=flat-square)](https://forge.puppet.com/puppet/puppetwebhook)

Puppet module for installing and managing Vox Pupuli's `puppet_webhook` API Server.

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with puppetwebhook](#setup)
    * [What puppetwebhook affects](#what-puppetwebhook-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with puppetwebhook](#beginning-with-puppetwebhook)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

puppet-puppetwebhook will install the `puppet_webhook` gem, configure the gem, and create a SystemD service file and start said service.


## Setup

### The Module manages the following:
* [puppet_webhook](https://github.com/voxpupuli/puppet_webhook) API server Ruby gem
* puppet_webhook configuration
* puppet_webhook service

## Usage

This module provides one public class `puppetwebhook`.

``` puppet
include puppetwebhook
```

With all default parameter values, this installs, enables, and starts the
`puppet_webhook` service. The package provider, user/group that owns the process
and files, and the configuration options themselves.

Install `puppet_webhook` as a general ruby gem instead of in the Puppet ruby environment
``` puppet
class { 'puppetwebhook':
  pkg_provider => 'gem',
}
```

## Limitations

Currently does not support the following:

* Installation of RPM or DEB packages (planned)
* Enable/Disable Service management (planned)
* Enable/Disable Package management (planned)
* Expects SystemD, no SysVInit or Upstart service is created.

## Development

Please see the [CONTRIBUTING.md](CONTRIBUTING.md) file for instructions regarding development environments and testing.

## Authors

* Vox Pupuli: [voxpupuli@groups.io](mailto:voxpupuli@groups.io)
