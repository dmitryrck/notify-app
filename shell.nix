with import <nixpkgs> {};

mkShell {
  buildInputs = [
    ruby_3_1

    libxml2
    nss # google-chrome & chromedriver
  ];

  shellHook = ''
    USER_CACHE_PATH=~/.cache/niz/$(basename $(pwd))

    export GEM_HOME=$USER_CACHE_PATH/ruby-$(ruby --version | cut -d' ' -f2)
    mkdir -p $GEM_HOME
    export GEM_PATH=$GEM_HOME
    export PATH=$GEM_HOME/bin:$PATH
  '';
}
