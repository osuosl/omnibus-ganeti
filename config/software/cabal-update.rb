name "cabal-update"

build do
  # pull in latest package db
  command "#{install_dir}/embedded/bin/cabal update"
end
