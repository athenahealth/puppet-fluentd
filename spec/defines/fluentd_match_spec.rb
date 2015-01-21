#!/usr/bin/env rspec
require 'spec_helper'

describe 'fluentd::match' do
	let(:title) {'bar'}

    let (:facts) {{
	    :osfamily       => 'Debian',
    }}

    context "when no servers or out_copy" do
    	let(:params) {{
        :pattern    => 'bar',
        :config     => {
            'type'              => 'file',
            'time_slice_wait'   => '10m',
            'compress'          => 'gzip',
        }
		}}

		it "should create matcher single segment" do
      should contain_fluentd__configfile('match-bar')
        .with_content(/<match bar>\s*compress gzip\s*time_slice_wait 10m\s*type file\s*<\/match>\s*/)
			should_not contain_fluentd__configfile('match-bar')
        .with_content(/server/)
			should_not contain_fluentd__configfile('match-bar')
        .with_content(/store/)
		end
	end

    context "when servers but no out_copy" do
    	let(:params) {{
        :pattern    => 'bar',
        :config     => {
            'servers'    => [
              { 'host' => 'kelis', 'port' => '24224'},
              { 'host' => 'bossy', 'port' => '24224'}],
            'type'              => 'file',
            'time_slice_wait'   => '10m',
            'compress'          => 'gzip',
        }
		}}

		it "should create matcher with server" do
      should contain_fluentd__configfile('match-bar')
        .with_content(/<match bar>\s*compress\s*gzip\s*<server>\s*host\s*kelis\s*port\s*24224\s*<\/server>\s*<server>\s*host\s*bossy\s*port\s*24224\s*<\/server>\s*time_slice_wait\s*10m\s*type file\s*<\/match>\s*/)
			should contain_fluentd__configfile('match-bar')
        .with_content(/server/)
			should_not contain_fluentd__configfile('match-bar')
        .with_content(/store/)
		end
	end

    context "when out_copy" do
    	let(:params) {{
        :pattern    => 'bar',
        :config     => [
            {
                'type'              => 'file',
                'compress'          => 'gzip',
                'servers'           => [{ 'host' => 'kelis', 'port' => '24224'}, { 'host' => 'bossy', 'port' => '24224'}],
            },
            {
                'type'              => 'mongo',
                'database'          => 'dummy',
            }
        ]
		}}

		it "should create matcher with server" do
			should contain_fluentd__configfile('match-bar')
        .with_content(/<match bar>\s*type\scopy\s*<store>\s*compress\sgzip\s*<server>\s*host\skelis\s*port\s24224\s*<\/server>\s*<server>\s*host\sbossy\s*port\s24224\s*<\/server>\s*type\sfile\s*<\/store>\s*<store>\s*database\sdummy\s*type\smongo\s*<\/store>\s*<\/match>\s*/)
    end
	end


end

