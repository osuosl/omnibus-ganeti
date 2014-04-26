
name 'ganeti'
maintainer 'CHANGE ME'
homepage 'CHANGEME.com'

replaces        'ganeti'
install_path    '/opt/ganeti'
build_version   Omnibus::BuildVersion.new.semver
build_iteration 1

# creates required build directories
dependency 'preparation'

# ganeti dependencies/components
# dependency 'somedep'

# version manifest file
dependency 'version-manifest'

exclude '\.git*'
exclude 'bundler\/git'
