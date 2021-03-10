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

  if $puppetwebhook::manage_repo {
    case $facts['os']['family'] {
      'RedHat': {
        yumrepo { 'voxpupuli':
          ensure        => 'present',
          baseurl       => 'https://dl.bintray.com/voxpupuli/rpm/el/$releasever/$basearch',
          gpgcheck      => 0,
          repo_gpgcheck => 1,
          gpgkey        => 'https://bintray.com/user/downloadSubjectPublicKey?username=voxpupuli',
          descr         => 'Vox Pupuli repository for puppet-webhook',
          before        => Package['puppet-webhook'],
        }
      }
      'Debian': {
        include apt
        apt::key { 'voxpupuli':
          ensure => 'present',
          source => 'https://bintray.com/user/downloadSubjectPublicKey?username=voxpupuli',
          id     => '3DF0F236D8585A6A3D931AF793994CEF2A6DEAC4',
        }
        -> apt::source { 'voxpupuli':
          ensure   => 'present',
          comment  => 'Vox Pupuli repository for puppet-webhook',
          location => 'https://dl.bintray.com/voxpupuli/deb',
          repos    => 'main',
          before   => Package['puppet-webhook'],
          # Exec[apt_update]
        }
      }
      default: { fail("${facts['os']['family']} is currently not supported") }
    }
  }
  package { 'puppet-webhook':
    ensure   => 'installed',
  }
}
