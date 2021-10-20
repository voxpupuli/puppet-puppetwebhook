require 'spec_helper_acceptance'

describe 'puppetwebhook' do
  redis_name = case fact('os.family')
               when 'Debian'
                 'redis-server'
               else
                 'redis'
               end
  it 'installs redis dependency' do
    pp = 'include redis'

    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  it 'applies' do
    pp = 'include puppetwebhook'

    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  describe package('puppet-webhook') do
    it { is_expected.to be_installed }
  end

  describe group('puppet_webhook') do
    it 'is almost implemented' do
      pending('creating a group is currently not implemented in the rpm/deb packages')
      is_expected.to exist
    end
  end

  describe user('puppet_webhook') do
    it 'is almost implemented' do
      pending('creating a user is currently not implemented in the rpm/deb packages')
      is_expected.to exist
      is_expected.to belong_to_primary_group('puppet_webhook')
    end
  end

  describe file('/etc/voxpupuli/webhook.yaml') do
    it { is_expected.to be_file }
    it { is_expected.to be_owned_by('root') }
    it { is_expected.to be_mode(644) }
    its(:content_as_yaml) do
      is_expected.to include(
        'production' => include(
          'protected' => true,
          'user' => 'puppet',
          'pass' => 'puppet',
          'chatops' => false,
          'default_branch' => 'production',
          'ignore_environments' => [],
          'allow_uppercase' => true,
          'loglevel' => 'info'
        )
      )
    end
    it 'is almost implemented' do
      pending('creating a group is currently not implemented in the rpm/deb packages')
      is_expected.to be_grouped_into('puppet_webhook')
    end
  end

  describe service('puppet-webhook') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end

  describe service('puppet-webhook-app') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end

  describe service('puppet-webhook-sidekiq') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end

  describe service(redis_name) do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end
end

# describe 'puppetwebhook with redis 5', if: fact('os.family') == 'RedHat' do
#   it 'installs redis dependency' do
#     pp = <<-EOS
#     class{'redis::globals':
#       scl => 'rh-redis5',
#     }
#     include puppetwebhook
#     class{'redis':
#       manage_repo => true,
#       notify => Service['puppet-webhook'],
#     }
#     EOS

#     pending('Redis 5 support is broken in voxpupuli/redis module')
#     apply_manifest(pp, catch_failures: true)
#     apply_manifest(pp, catch_changes: true)
#   end

#   describe service('puppet-webhook') do
#     it { is_expected.to be_running }
#     it { is_expected.to be_enabled }
#   end

#   describe service('puppet-webhook-app') do
#     it { is_expected.to be_running }
#     it { is_expected.to be_enabled }
#   end

#   describe service('puppet-webhook-sidekiq') do
#     it { is_expected.to be_running }
#     it { is_expected.to be_enabled }
#   end

#   describe service('rh-redis5-redis') do
#     pending('redis fails to start in docker, only on docker') do
#       it { is_expected.to be_running }
#     end
#     it { is_expected.to be_enabled }
#   end
# end
