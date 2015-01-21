#!/usr/bin/env rspec
require 'spec_helper'

describe 'fluentd::source' do
	let(:title) {'bar'}

    let (:facts) {{
	    :osfamily => 'Debian',
    }}

    context "when type => forward" do
    	let(:params) {{
        :config  => {
            'type' => 'forward',
        }
		  }}

		it "should create source single segment" do
      should contain_fluentd__configfile('source-bar')
        .with_content(/<source>\s*type\s*forward\s*<\/source>\s*/m)
		end
	end
end
