name "ghc-crypto"
default_version "4.2.5.1"

dependency 'cabal-install'
dependency 'patchelf'
dependency 'libffi'
dependency 'gmp'

cabal_install = ["#{install_dir}/embedded/bin/cabal install",
                 "--prefix=#{install_dir}/embedded",
                 "--extra-include-dirs=#{install_dir}/embedded/include",
                 "--extra-include-dirs=#{install_dir}/embedded/include/openssl",
                 "--extra-include-dirs=#{install_dir}/embedded/include/curl",
                 "--extra-lib-dirs=#{install_dir}/embedded/lib"].join(" ")

patchelf = [ "#{install_dir}/embedded/bin/patchelf",
             "--set-rpath #{install_dir}/embedded/lib"].join(" ")

patchelf_libs = [ "RSATest", "WordListTest", "QuickTest", "SymmetricTest",
                  "SHA1Test", "HMACTest" ]

env = {
  "CFLAGS"  => ["-I#{install_dir}/embedded/include",
                "-I#{install_dir}/embedded/include/openssl",
                "-I#{install_dir}/embedded/include/curl"].join(" "),
  "LDFLAGS" => "-L#{install_dir}/embedded/lib",
  "PATH"    => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"
}

build do
  command "#{cabal_install} Crypto==#{default_version}", :env => env
  # nasty "hack" to force set the rpath
  patchelf_libs.each do |lib|
    command "#{patchelf} #{install_dir}/embedded/bin/#{lib}"
  end
end

