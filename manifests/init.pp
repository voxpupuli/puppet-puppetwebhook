# The Puppet Webhook module will install and configure the Sinatra-based web
# application that serves up a REST API for executing Puppet-related tasks.
#
# @summary Manage the installation and configuration of the puppet_webhook gem
#
# @example
#   include puppet_webhook
#
class puppet_webhook {
  contain 'puppet_webhook::install'
  contain 'puppet_webhook::config'
}
