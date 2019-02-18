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

  package { 'puppet_webhook':
    ensure   => $puppetwebhook::pkg_version,
    provider => $puppetwebhook::pkg_provider,
  }
}
