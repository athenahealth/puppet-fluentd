#!/usr/bin/env rspec
require 'spec_helper'

describe 'fluentd::forest_match' do
	let(:title) {'bar'}

    let (:facts) {{
	    :osfamily       => 'Debian',
    }}

    context "when no servers or out_copy" do
    	let(:params) {{
        :pattern    => 'baz',
        :config     => {
            'type'              => 'forest',
            'subtype'           => 'file',
            'template'          => {
              'time_slice_wait' => '10m',
              'compress'        => 'gzip',
            },
        }
		}}

		it "should create matcher single segment" do
      should contain_fluentd__configfile('match-bar')
        .with_content(/<match baz>\s*subtype\sfile\s*<template>\s*compress\sgzip\s*time_slice_wait\s10m\s*<\/template>\s*type\sforest\s*<\/match>\s*/)
			should_not contain_fluentd__configfile('match-bar')
        .with_content(/server/)
			should_not contain_fluentd__configfile('match-bar')
        .with_content(/store/)
		end
	end

    context "when servers but no out_copy" do
    	let(:params) {{
        :pattern    => 'baz',
        :config     => {
            'type'    => 'forest',
            'subtype' => 'file',
            'template'          => {
              'servers'         => [{ 'host' => 'kelis', 'port' => '24224'},{ 'host' => 'bossy', 'port' => '24224'}],
              'time_slice_wait' => '10m',
              'compress'        => 'gzip',
            }
        }
		}}

		it "should create matcher with server" do
      should contain_fluentd__configfile('match-bar')
        .with_content(/<match baz>\s*subtype\sfile\s*<template>\s*compress\sgzip\s*<server>\s*host\skelis\s*port\s24224\s*<\/server>\s*<server>\s*host\sbossy\s*port\s24224\s*<\/server>\s*time_slice_wait\s10m\s*<\/template>\s*type\sforest\s*<\/match>\s*/)
			should contain_fluentd__configfile('match-bar')
        .with_content(/server/)
		end
	end


end

