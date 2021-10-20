# The Puppet Webhook module will install and configure the Sinatra-based web
# application that serves up a REST API for executing Puppet-related tasks.
#
# @summary Manage the installation and configuration of the puppet_webhook gem
#
# @author Vox Pupuli <voxpupuli@groups.io>
#
# @example
#   include puppetwebhook
#
# @example Specify parameters
#   class { 'puppetwebhook':
#     pkg_provider => 'gem',
#     server_cfg   => {
#       server_type => 'daemon',
#       host        => '0.0.0.0',
#       logfile     => '/etc/puppet_webhook/webhook.log',
#     },
#   }
#
# @example Specify Parameters using hiera
#   puppetwebhook::pkg_provider: 'puppet_gem'
#   puppetwebhook::server_cfg:
#     server_type: 'simple'
#     host: '192.168.100.5'
#     loglevel: 'WARN'
#
# @param app_cfg
#   Hash of application configuration options
# @option app_cfg [Boolean] :protected
#   Run API server in protected mode.
# @option app_cfg [String[1]] :user
#   API server auth user.
# @option app_cfg [String[1]] :pass
#   API server auth password.
# @option app_cfg [Stdlib::Absolutepath] :client_cfg
#   MCollective client config. Optional.
# @option app_cfg [String[1]] :client_timeout
#   MCollective client timeout. Optional.
# @option app_cfg [Boolean] :use_mco_ruby
#   Use MCollective ruby client. Optional.
# @option app_cfg [Boolean] :use_mcollective
#   Whether to use MCollective or not.
# @option app_cfg [String[1]] :discovery_timeout
#   MCollective discovery timeout. Optional.
# @option app_cfg [Boolean] :chatops
#   Integrate a ChatOps tool or not. Default: false.
# @option app_cfg [Enum['slack', 'rocketchat']] :chatops_service
#   Which chatops to use. Optional.
# @option app_cfg [Pattern[/\A#.*/]] :chatops_channel
#   Channel to post to. Optional.
# @option app_cfg [String[1]] :chatops_user
#   User to post as. Optional.
# @option app_cfg [Stdlib::HTTLUrl] :chatops_url
#   URL to post chatops messages to. Optional.
# @option app_cfg [String[1]] :default_branch
#   Default R10K branch to use. Default: production
# @option app_cfg [Array[String[1]]] :ignore_environments
#   R10K Environment to ignore. Optional.
# @option app_cfg [String[1]] :prefix_command
#   Command that will generate an R10K prefix. Optional.
# @option app_cfg [String[1]] :r10k_deploy_arguments
#   Arguments to pass to R10K.
# @option app_cfg [Boolean] :allow_uppercase
#   Allow uppercase characters. Optional.
# @option app_cfg [String[1]] :command_prefix
#   Command to execute before R10K. For example `umask 0022;`. Optional.
# @option app_cfg [String[1]] :prefix
#   R10K prefix. Optional.
# @option app_cfg [String[1]] :github_secret
#   Used to verify the signature on a repo. Currently only
#   supported for Github repos. Optional.
# @option app_cfg [Array] :repository_events
#   Array of webhook events to ignore. Optional.
# @param manage_package
#   Enable/Disable the management of the package
# @param manage_repo
#   weather we should manage the repository for puppet_webhook or not
# @param version
#   version of puppet_webhook to install
#
class puppetwebhook (
  Hash $app_cfg = { 'production' => { 'protected' => true, 'user' => 'puppet', 'pass' => 'puppet', 'chatops' => false, 'default_branch' => 'production', 'ignore_environments' => [], 'allow_uppercase' => true, 'loglevel' => 'info' } },
  Boolean $manage_package = true,
  Boolean $manage_repo = true,
  String $version = '2.1.3',
) {
  if $manage_package {
    contain puppetwebhook::install
    Class['puppetwebhook::install']
    -> Class['puppetwebhook::config']
  }
  contain puppetwebhook::config
  contain puppetwebhook::service

  Class['puppetwebhook::config']
  ~> Class['puppetwebhook::service']
}
