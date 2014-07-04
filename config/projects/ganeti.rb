
name 'ganeti'
maintainer 'Lance Albertson'
homepage 'https://code.google.com/p/ganeti/'

install_path    '/opt/ganeti'
version = ENV['GANETI_VERSION'] || '2.11.2'
build_version   "#{version}-#{Time.now.strftime('%Y%m%d-%H%M%S')}"
build_iteration 1

# creates required build directories
dependency 'preparation'

# ganeti dependencies/components
dependency 'ganeti'

# version manifest file
dependency 'version-manifest'

exclude '\.git*'
exclude 'bundler\/git'
