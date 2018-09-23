# Installs the puppet_webhook gem and dependencies
# into the system ruby or puppet-agent ruby environment.
#
# @summary Installs the puppet_webhook gem 
#
# @api private
#
# @author Vox Pupuli <voxpupuli@groups.io>
#
class puppet_webhook::install {
  assert_private()

  package { 'puppet_webhook':
    ensure   => 'installed',
    provider => $puppet_webhook::pkg_provider,
  }
}
