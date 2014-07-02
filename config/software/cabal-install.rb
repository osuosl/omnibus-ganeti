name "cabal-install"
default_version "1.20.0.1"

dependency 'curl'

cabal_install = ["/usr/bin/cabal install",
                 "--prefix=#{install_dir}/embedded",
                 "--extra-include-dirs=#{install_dir}/embedded/include",
                 "--extra-include-dirs=#{install_dir}/embedded/include/openssl",
                 "--extra-include-dirs=#{install_dir}/embedded/include/curl",
                 "--extra-lib-dirs=#{install_dir}/embedded/lib"].join(" ")

cabal_sandbox = ["#{install_dir}/embedded/bin/cabal",
                 "sandbox --sandbox=#{install_dir}/embedded init"].join(" ")

env = {
  "CFLAGS"  => ["-I#{install_dir}/embedded/include",
                "-I#{install_dir}/embedded/include/openssl",
                "-I#{install_dir}/embedded/include/curl"].join(" "),
  "LDFLAGS" => "-L#{install_dir}/embedded/lib",
  "LANG"    => "en_US.UTF-8",
  "PATH"    => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"
}

build do
  command "rm -rf ~/.cabal ~/.ghc"
  command "/usr/bin/cabal update"
  command "#{cabal_install} cabal cabal-install==#{default_version}", :env => env
  command "#{cabal_sandbox}", :env => env
end
