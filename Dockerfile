from ruby

run curl -sSL https://bin.equinox.io/c/ekMN3bCZFUn/forego-stable-linux-amd64.tgz | tar xfz - -C /usr/local/bin

workdir /tmp
copy Gemfile* /tmp/
run bundle install

workdir /app
