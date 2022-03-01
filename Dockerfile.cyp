FROM cypress/included:6.2.1

WORKDIR /

# Copy Sinatra app into container
# ADD app.rb app.rb
# ADD worker.rb worker.rb
COPY . .

RUN \
  apt-get update && apt-get install -y --no-install-recommends --no-install-suggests curl bzip2 build-essential libssl-dev libreadline-dev zlib1g-dev && \
  rm -rf /var/lib/apt/lists/* && \
  curl -L https://github.com/sstephenson/ruby-build/archive/v20180329.tar.gz | tar -zxvf - -C /tmp/ && \
  cd /tmp/ruby-build-* && ./install.sh && cd / && \
  ruby-build -v 2.5.1 /usr/local && rm -rfv /tmp/ruby-build-* && \
  gem install bundler --no-rdoc --no-ri

# Install Sinatra gem
RUN gem install sinatra --no-ri --no-rdoc

# Start Sinatra
CMD ["ruby", "app.rb"]

# ENTRYPOINT ["cypress", "run"]
