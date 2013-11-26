name             'radio'
maintainer       'kangaechu.com'
maintainer_email 'kangae2@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures radio'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
%w[ cpan apt ].each do |cb_depend|
  depends cb_depend
end

%w[ ubuntu ].each do |os|
  supports os
end
