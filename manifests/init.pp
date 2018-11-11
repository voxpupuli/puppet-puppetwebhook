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
# @param pkg_provider Which provider to install puppetwebhook into
# @param server_cfg Hash of Server configuration options
# @option server_cfg [Enum['simple', 'daemon']] :server_type Run the API server
#   as a daemon or not
# @option server_cfg [Stdlib::IP::Address] :host IP address to the API server 
#   will listen on.
# @option server_cfg [Stdlib::Absolutepath] :logfile Path to log file.
# @option server_cfg [Enum['WARN', 'INFO', 'DEBUG', 'ERROR']] :loglevel Log level
#   of the server.
# @option server_cfg [Stdlib::Absolutepath] :pidfile Path to the PID file.
# @option server_cfg [Stdlib::Port] :port Port the API server will listen on.
# @option server_cfg [Boolean] :enable_ssl Enable SSL or not.
# @option server_cfg [Boolean] :ssl_verify Verify SSL certificate or not. Optional.
# @option server_cfg [Stdlib::Absolutepath] :ssl_cert Path to the SSL cert. Optional.
# @option server_cfg [Stdlib::Absolutepath] :ssl_key Path to the SSL Private key. Optional.
# @param app_cfg Hash of application configuration options
# @option app_cfg [Boolean] :protected Run API server in protected mode.
# @option app_cfg [String[1]] :user API server auth user.
# @option app_cfg [String[1]] :pass API server auth password.
# @option app_cfg [Stdlib::Absolutepath] :client_cfg MCollective client config.
#   Optional.
# @option app_cfg [String[1]] :client_timeout MCollective client timeout.
#   Optional.
# @option app_cfg [Boolean] :use_mco_ruby Use MCollective ruby client.
#   Optional.
# @option app_cfg [Boolean] :use_mcollective Whether to use MCollective or not.
# @option app_cfg [String[1]] :discovery_timeout MCollective discovery timeout.
#   Optional.
# @option app_cfg [Boolean] :chatops Integrate a ChatOps tool or not. Default: false.
# @option app_cfg [Enum['slack', 'rocketchat']] :chatops_service Which chatops
#   to use. Optional.
# @option app_cfg [Pattern[/\A#.*/]] :chatops_channel Channel to post to.
#   Optional.
# @option app_cfg [String[1]] :chatops_user User to post as. Optional.
# @option app_cfg [Stdlib::HTTLUrl] :chatops_url URL to post chatops messages
#   to. Optional.
# @option app_cfg [String[1]] :default_branch Default R10K branch to use. Default: production
# @option app_cfg [Array[String[1]]] :ignore_environments R10K Environment to ignore. Optional.
# @option app_cfg [String[1]] :prefix_command Command that will generate an R10K prefix. Optional.
# @option app_cfg [String[1]] :r10k_deploy_arguments Arguments to pass to R10K.
# @option app_cfg [Boolean] :allow_uppercase Allow uppercase characters. Optional.
# @option app_cfg [String[1]] :command_prefix Command to execute before R10K.
# @option app_cfg [String[1]] :prefix R10K prefix. Optional.
# @option app_cfg [String[1]] :github_secret Used to verify the signature on a repo. Currently
#   only supported for Github repos. Optional.
# @option app_cfg [Array] :repository_events Array of webhook events to ignore. Optional.
# @param binfile Path to the puppet_webhook binary
# @param webhook_user User to run puppet_webhook as
# @param webhook_group Group to run puppet_webhook as
#
class puppetwebhook(
  Enum['gem', 'puppet_gem'] $pkg_provider,
  Puppetwebhook::Serverconfig $server_cfg,
  Puppetwebhook::Appconfig $app_cfg,
  Stdlib::Absolutepath $binfile,
  String $webhook_user,
  String $webhook_group,
) {
  contain 'puppetwebhook::install'
  contain 'puppetwebhook::config'
  contain 'puppetwebhook::service'
}
