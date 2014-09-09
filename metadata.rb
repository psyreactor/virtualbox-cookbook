name             "virtualbox"
maintainer       "Mariani Lucas"
maintainer_email "marianilucas@gmail.com"
license          "Apache 2.0"
description      "Installs virtualbox"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue "0.1.0"

%w(ubuntu debian centos redhat fedora).each do |os|
  supports os
end

depends 'build-essential'
depends 'apt'
depends 'yum'
depends 'apache2'
