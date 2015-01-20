require 'spec_helper'

describe 'fluentd' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "fluentd class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('fluentd::params') }
        it { is_expected.to contain_class('fluentd::package').that_comes_before('fluentd::config') }
        it { is_expected.to contain_class('fluentd::config') }
        it { is_expected.to contain_class('fluentd::service').that_subscribes_to('fluentd::config') }

        it { is_expected.to contain_service('td-agent') }
        it { is_expected.to contain_package('td-agent').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'fluentd class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('fluentd') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
