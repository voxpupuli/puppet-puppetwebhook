# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include puppet_webhook::install
class puppet_webhook::install {
  package { 'puppet_webhook':
    ensure   => 'installed',
    provider => 'puppet_gem'
  }
}
