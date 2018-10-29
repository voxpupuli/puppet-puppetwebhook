require 'spec_helper'

describe 'Puppetwebhook::Appconfig' do
  appconfig = {
    'protected' => true,
    'user' => 'foo',
    'pass' => 'bar',
    'client_cfg' => '/foo/bar/mco.cfg',
    'client_timeout' => '3600',
    'use_mco_ruby' => false,
    'use_mcollective' => false,
    'discovery_timeout' => '600',
    'chatops' => true,
    'chatops_service' => 'slack',
    'chatops_channel' => '#test',
    'chatops_user' => 'slack_user',
    'chatops_url' => 'https://foo.example.com/api',
    'default_branch' => 'production',
    'ignore_environments' => ['test'],
    'prefix_command' => 'foo',
    'r10k_deploy_arguments' => '-pv',
    'allow_uppercase' => false,
    'command_prefix' => 'bar',
    'prefix' => 'test',
    'github_secret' => 'secret',
    'repository_events' => [],
  }

  it { is_expected.to allow_value(appconfig) }
end
