name "ghc-lens"
default_version '3.10'

dependency 'cabal-update'

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
  command "#{cabal_install} lens==#{default_version}", :env => env
end

