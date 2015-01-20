require 'spec_helper'

describe 'fluentd' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "fluentd config files should be written on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it "/etc/td-agent/td-agent.conf should be in place" do
          should contain_file("/etc/td-agent/td-agent.conf").with(
            'ensure'  => 'file',
            'owner'   => 'root',
            'group'   => 'root',
            'notify'  => 'Class[Fluentd::Service]'
            )
        end
        it "/etc/td-agent/config.d is created" do
          should contain_file("/etc/td-agent/config.d").with(
            'ensure'  => 'directory',
            'owner'   => 'td-agent',
            'group'   => 'td-agent',
            'mode'    => '0750'
          )
        end
      end
    end
  end

end
