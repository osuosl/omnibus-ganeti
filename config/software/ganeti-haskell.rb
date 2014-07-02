name "ganeti-haskell"

dependency 'cabal-update'
dependency 'patchelf'
dependency 'libffi'
dependency 'gmp'
dependency 'curl'
dependency 'pcre'

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

ganeti_haskell_deps = ["json network parallel utf8-string curl hslogger",
                       "Crypto text hinotify==0.3.2 regex-pcre zlib",
                       "attoparsec vector base64-bytestring"].join(" ")

env = {
  "CFLAGS"  => ["-I#{install_dir}/embedded/include",
                "-I#{install_dir}/embedded/include/openssl",
                "-I#{install_dir}/embedded/include/curl"].join(" "),
  "LDFLAGS" => "-L#{install_dir}/embedded/lib",
  "LANG"    => "en_US.UTF-8",
  "LC_ALL"  => "en_US.UTF-8",
  "PATH"    => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"
}

build do
  # cleanup any prior builds
  command "rm -rf ~/.ghc/*/package.conf.d/*.conf"
  # Install all the haskell deps
  command "#{cabal_install} #{ganeti_haskell_deps}", :env => env
  # nasty "hack" to force set the rpath
  patchelf_libs.each do |lib|
    command "#{patchelf} #{install_dir}/embedded/bin/#{lib}"
  end
  # remove cabal command since its linked to external libraries but is no longer
  # needed.
  #command "rm -rf #{install_dir}/embedded/bin/cabal"
end

