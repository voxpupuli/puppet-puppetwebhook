require 'spec_helper'

describe 'puppetwebhook::service' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:pre_condition) { 'include puppetwebhook' }

      it { is_expected.to compile }
      it { is_expected.to contain_class('puppetwebhook') }
      it { is_expected.to contain_class('puppetwebhook::service') }
      it { is_expected.to contain_systemd__unit_file('puppet_webhook.service').with_ensure('present') }
      it {
        is_expected.to contain_service('puppet_webhook').with(
          ensure: 'running',
          enable: true,
          hasstatus: true,
          hasrestart: true
        ).that_subscribes_to(['Package[puppet_webhook]', 'Systemd::Unit_file[puppet_webhook.service]'])
      }
    end
  end
end
