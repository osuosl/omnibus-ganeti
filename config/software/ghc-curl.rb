name "ghc-curl"
default_version "1.3.8"

dependency 'cabal-update'
dependency 'curl'

cabal_install = ["#{install_dir}/embedded/bin/cabal install",
                 "--prefix=#{install_dir}/embedded",
                 "--extra-include-dirs=#{install_dir}/embedded/include",
                 "--extra-include-dirs=#{install_dir}/embedded/include/openssl",
                 "--extra-include-dirs=#{install_dir}/embedded/include/curl",
                 "--extra-lib-dirs=#{install_dir}/embedded/lib"].join(" ")
env = {
  "CFLAGS"  => ["-I#{install_dir}/embedded/include",
                "-I#{install_dir}/embedded/include/openssl",
                "-I#{install_dir}/embedded/include/curl"].join(" "),
  "LDFLAGS" => "-L#{install_dir}/embedded/lib",
  "PATH"    => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"
}

build do
  command "#{cabal_install} curl==#{default_version}", :env => env
end

