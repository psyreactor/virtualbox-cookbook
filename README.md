[![Build Status](https://travis-ci.org/psyreactor/virtualbox-cookbook.svg?branch=master)](https://travis-ci.org/psyreactor/virtualbox-cookbook)

VirtualBox Cookbook
==================

This cookbook installs VirtualBox. This cookbook is based on [virtualbox cookbook](https://github.com/jtimberman/virtualbox-cookbook)(not is a fork)

####[VirtualBox](https://www.virtualbox.org/)
"VirtualBox is a powerful x86 and AMD64/Intel64 virtualization product for enterprise as well as home use. Not only is VirtualBox an extremely feature rich, high performance product for enterprise customers, it is also the only professional solution that is freely available as Open Source Software under the terms of the GNU General Public License (GPL) version 2"

Requirements
------------
#### Cookbooks:

- apache2 - https://github.com/onehealth-cookbooks/apache2
- yum - https://github.com/opscode-cookbooks/yum
- apt - https://github.com/opscode-cookbooks/apt
- build-essential - https://github.com/opscode-cookbooks/build-essential

The following platforms and versions are tested and supported using Opscode's test-kitchen.

- CentOS 5.8, 6.3
- Debian 7.2.0
- Ubuntu 12.04


The following platform families are supported in the code, and are assumed to work based on the successful testing CentOS.


- Red Hat (rhel)
- Fedora
- Amazon Linux

Recipes
-------
#### virtualbox:default
The recipe install virtualbox, according to the version defined in node[:virtualbox][:version]. 

##### Basic Config
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>node[:virtualbox][:version]</tt></td>
    <td>String</td>
    <td>version of virtualbox to install</td>
    <td><tt>4.3.12</tt></td>
  </tr>
  <tr>
    <td><tt>node[:virtualbox][:base_url]</tt></td>
    <td>String</td>
    <td>base url for virtualbox</td>
    <td><tt>http://download.virtualbox.org/virtualbox</tt></td>
  </tr>
  <tr>
    <td><tt>node[:jboss][:timeout]</tt></td>
    <td>Integer</td>
    <td>yum install timeout</td>
    <td><tt>3_000</tt></td>
  </tr>
</table>

#### virtualbox:webservice
The recipe install the VirtualBox web service (vboxwebsrv) is used for controlling VirtualBox remotely. (Requeride for webportal)

#### virtualbox:webportal
The recipe install the [PhpVirtualBox](http://sourceforge.net/projects/phpvirtualbox/) web open source, AJAX implementation of the VirtualBox user interface written in PHP.

Usage
-----
### virtualbox::default
#### Example role:

```ruby
name "virtualbox"
description "Install Oracle VirtualBox"
run_list [
    "recipe[virtualbox::default]",
    "recipe[virtualbox::webportal]"
    ]

"default_attributes": {

}

```
Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

[More details](https://github.com/psyreactor/virtualbox-cookbook/blob/master/CONTRIBUTING.md)

License and Authors
-------------------
Authors:
Lucas Mariani (Psyreactor)
- [marianiluca@gmail.com](mailto:marianiluca@gmail.com)
- [Github](https://github.com/psyreactor)
-------------------
