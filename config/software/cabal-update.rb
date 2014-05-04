name "cabal-update"

build do
  # clean out any previous installation details
  command "rm -rf ~/.cabal ~/.ghc"
  # pull in latest package db
  command "/usr/bin/cabal update"
end
