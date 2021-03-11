
# puppetwebhook

[![Puppet Forge](https://img.shields.io/puppetforge/v/puppet/puppetwebhook.svg?style=flat-square)](https://forge.puppetlabs.com/puppet/puppetwebhook)
[![Puppet Forge](https://img.shields.io/puppetforge/dt/puppet/puppetwebhook.svg?style=flat-square)](https://forge.puppet.com/puppet/puppetwebhook)
[![Puppet Forge](https://img.shields.io/puppetforge/e/puppet/puppetwebhook.svg?style=flat-square)](https://forge.puppet.com/puppet/puppetwebhook)
[![Puppet Forge](https://img.shields.io/puppetforge/f/puppet/puppetwebhook.svg?style=flat-square)](https://forge.puppet.com/puppet/puppetwebhook)

Puppet module for installing and managing Vox Pupuli's [puppet_webhook](https://github.com/voxpupuli/puppet_webhook#puppet-webhook-server) API Server.

**Version 2 and newer of this module manage the new puppet_webhook project, which is a Ruby application, packaged as rpms/debs. Version 1 only supports the deprecated puppet_webhook gem**

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

puppet-puppetwebhook will install the `puppet_webhook` Ruby project, configure it and start said service.

## Setup

### The Module manages the following:

* [puppet_webhook](https://github.com/voxpupuli/puppet_webhook)
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

## Limitations

The rpm/deb packages expect that you provide a running redis instance.

You can install redis from different sources. One solution is our own puppet
module [voxpupuli/redis](https://forge.puppet.com/puppet/redis). After
deploying this to your environment, simply do a `include redis` to deploy
redis listening only on localhost. One exception is CentOS, where the shipped
Redis version is too old. But you can enable the SCL repository:

```puppet
class{ 'redis::globals':
  scl => 'rh-redis5',
}
include puppetwebhook
class{ 'redis':
  manage_repo => true,
  notify => Service['puppet-webhook'],
}
```

On Debian-like systems you need to install the
[puppetlabs/apt](https://forge.puppet.com/puppetlabs/apt) module.

On RedHat-like systems you need to enable epel. To do so you can use our
[voxpupuli/epel](https://forge.puppet.com/puppet/epel) module, or something like

```sh
puppet resource package epel-release ensure=present
```

in the CLI or this in your profile:

```puppet
package { 'epel-release':
  ensure => 'installed',
}
```

## Development

Please see the [CONTRIBUTING.md](.github/CONTRIBUTING.md) file for instructions regarding development environments and testing.

## Authors

* Vox Pupuli: [voxpupuli@groups.io](mailto:voxpupuli@groups.io)
