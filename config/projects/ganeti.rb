
name 'ganeti'
maintainer 'Lance Albertson'
homepage 'https://code.google.com/p/ganeti/'

install_path    '/opt/ganeti'
#build_version   Omnibus::BuildVersion.new.semver
build_version   '2.11.0'
build_iteration 1

# creates required build directories
dependency 'preparation'

# ganeti dependencies/components
dependency 'ganeti'

# version manifest file
dependency 'version-manifest'

exclude '\.git*'
exclude 'bundler\/git'
