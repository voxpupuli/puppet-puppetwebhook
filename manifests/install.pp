# Installs the puppetwebhook gem and dependencies
# into the system ruby or puppet-agent ruby environment.
#
# @summary Installs the puppetwebhook gem
#
# @api private
#
# @author Vox Pupuli <voxpupuli@groups.io>
#
class puppetwebhook::install {
  assert_private()

  if $facts['os']['family'] == 'RedHat' {
    include yum
  }

  case $facts['os']['family'] {
    'RedHat': {
      $extension = 'rpm'
      case $facts['os']['release']['major'] {
        '7': {
          $version = 'el7'
        }
        '8': {
          $version = 'el8'
        }
        default: { fail("${facts['os']['release']['major']} is currently not supported") }
      }
      $pkg = "puppet-webhook-${puppetwebhook::version}-1.${version}.x86_64.rpm"
      $prv = 'yum'

      file { $pkg:
        ensure => file,
        source => "https://github.com/voxpupuli/puppet_webhook/releases/download/v${puppetwebhook::version}/${pkg}",
        path   => "/tmp/${pkg}",
        before => Package['puppet-webhook'],
      }

      yum::group { 'Development Tools':
        ensure => present,
        before => Package['puppet-webhook'],
      }
    }
    'Debian': {
      $extension = 'deb'
      case $facts['os']['release']['major'] {
        '10': {
          $version = 'buster'
        }
        '9': {
          $version = 'stretch'
        }
        '16.04': {
          warning("Ubuntu ${facts['os']['release']['major']} is End of Life. Use at your own risk.")
          $version = 'xenial'
        }
        '18.04','18.10','19.04','19.10': {
          $version = 'bionic'
        }
        '20.04','20.10','21.04','21.10': {
          $version = 'focal'
        }
        default: { fail("${facts['os']['release']['major']} is not supported") }
      }
      $pkg = "puppet-webhook_${puppetwebhook::version}-1${version}_amd64.deb"
      $prv = 'apt'

      file { $pkg:
        ensure => file,
        source => "https://github.com/voxpupuli/puppet_webhook/releases/download/v${puppetwebhook::version}/${pkg}",
        path   => "/tmp/${pkg}",
        before => Package['puppet-webhook'],
      }

      package { 'build-essential': ensure => installed, }
    }
    default: { fail("${facts['os']['family']} is not supported") }
  }
  package { 'puppet-webhook':
    ensure   => 'installed',
    provider => $prv,
    source   => "/tmp/${pkg}",
  }
}
