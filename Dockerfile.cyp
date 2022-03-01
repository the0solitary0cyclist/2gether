FROM cypress/included:6.2.1

WORKDIR /

# Copy Sinatra app into container
# ADD app.rb app.rb
# ADD worker.rb worker.rb
COPY . .

#RUN apt-get update && apt-get install -y ruby ruby-dev ruby-bundler build-essential
#RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Local ruby
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
  &&  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc \
  &&  echo 'eval "$(rbenv init -)"' >> ~/.bashrc

ENV HOME /home/jenkins # Change this dir as needed.
ENV PATH "$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
ENV RUBY_VERSION 2.6.3

RUN mkdir -p "$(rbenv root)"/plugins \
    && git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

RUN rbenv install $RUBY_VERSION

RUN rbenv global $RUBY_VERSION && rbenv versions && ruby -v

# RUN curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash # Uncomment this to get rbenv to validate your setup.

# Install Sinatra gem
RUN gem install sinatra --no-ri --no-rdoc

# Start Sinatra
CMD ["ruby", "app.rb"]

# ENTRYPOINT ["cypress", "run"]
