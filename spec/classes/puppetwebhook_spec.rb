require 'spec_helper'

describe 'puppetwebhook' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it { is_expected.to contain_class('puppetwebhook::install') }
      it { is_expected.to contain_package('puppet_webhook').with_provider('puppet_gem') }
    end
  end
end
