#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with fluentd](#setup)
    * [What fluentd affects](#what-fluentd-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with fluentd](#beginning-with-fluentd)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Manage Fluentd installation and configuration with Puppet on RHEL, CentOS, Debian and Ubuntu.

## Module Description

If applicable, this section should have a brief description of the technology the module integrates with and what that integration enables. This section should answer the questions: "What does this module *do*?" and "Why would I use it?"

If your module has a range of functionality (installation, configuration, management, etc.) this is the time to mention it.

## Setup

### What fluentd affects

* Defaults are for td-agent distribution for Fluentd. 

### Required Modules

- stdlib: "https://github.com/puppetlabs/puppetlabs-stdlib.git"

### Beginning with fluentd

The very basic steps needed for a user to get the module up and running. 

If your most recent release breaks compatibility or requires particular steps for upgrading, you may wish to include an additional section here: Upgrading (For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

How to configure a Agent to send data to a centralised Fluentd-Server

### Create an Agent

The agent watches over your logfiles and sends its content to the collector.

```
include ::fluentd

fluentd::source { 'apache':
  config => {
    'format'   => 'apache2',
    'path'     => '/var/log/apache2/access.log',
    'pos_file' => '/var/tmp/fluentd.pos',
    'tag'      => 'apache.access_log',
    'type'     => 'tail',
  },
}

fluentd::source { 'syslog':
  config => {
    'format'   => 'syslog',
    'path'     => '/var/log/syslog',
    'pos_file' => '/tmp/td-agent.syslog.pos',
    'tag'      => 'system.syslog',
    'type'     => 'tail',
  },
}

fluentd::match { 'forward':
  pattern  => '**',
  priority => '80',
  config   => {
    'type'    => 'forward',
    'servers' => [
      { 'host' => 'fluentd.example.com', 'port' => '24224' }
    ],
  },
}

...creates the following files:

```
/etc/td-agent/
  ├── config.d
  │   ├── 50-source-apache.conf
  │   ├── 50-source-syslog.conf
  │   └── 80-match-forward.conf
  ├── ...
  ...
```

### Create a Collector

The Collector collects all the data from the Agents. He now stores the data in
files, Elasticsearch or elsewhere.

```
include ::fluentd

fluentd::source { 'collector':
  priority => '10',
  config   => {
    'type' => 'forward',
  }
}

fluentd::match { 'collector':
  pattern => '**',
  config  => {
    'type'            => 'elasticsearch',
    'logstash_format' => true,
  },
}

# all rsyslog daemons on the clients sends their messages to 5140
fluentd::source { 'rsyslog':
  type   => 'syslog',
  config => {
    'port' => '5140',
    'bind' => '0.0.0.0',
    'tag'  => 'system.local',
  },
}
```

...creates the following files:

```
/etc/td-agent/
  ├── config.d
  │   ├── 10-source-collector.conf
  │   ├── 50-match-collector.conf
  │   └── 50-source-rsyslog.conf
  ├── ...
  ...
```

### Copy output to multiple stores

An array of configurations implies type "copy".

````
$logger=[ { 'host' => 'logger-sample01', 'port' => '24224'},
          { 'host' => 'logger-example01', 'port' => '24224', 'standby' => ''} ]

fluentd::match { 'forward_to_logger':
  pattern => 'alocal',
  config  => [
    {
      'type'               => 'forward',
      'send_timeout'       => '60s',
      'recover_wait'       => '10s',
      'heartbeat_interval' => '1s',
      'phi_threshold'      => 8,
      'hard_timeout'       => '60s',
      'flush_interval'     => '5s',
      'servers'            => $logger,
    },
    {
      'type'              => 'stdout',
      'output_type'       => 'json',
    }
  ],
}
```

## Reference

Here, list the classes, types, providers, facts, etc contained in your module. This section should include all of the under-the-hood workings of your module so people know what the module is touching on their system but don't need to mess with things. (We are working on automating this section!)

## Supported Operating Systems

- Debian (tested on Debian 7.5) 
- Ubuntu 
- Redhat 
- CentOS (tested on CentOS 6.4)

## Development

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You may also add any additional sections you feel are necessary or important to include here. Please use the `## ` header. 
