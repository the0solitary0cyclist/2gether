FROM cypress/included:6.2.1

WORKDIR /

# Copy Sinatra app into container
# ADD app.rb app.rb
# ADD worker.rb worker.rb
COPY . .

RUN sudo apt-get update \
    && sudo apt-get --allow-releaseinfo-change-suite update
    && sudo apt-get install -y ruby-full ruby-dev build-essential \
    && gem install bundler --no-ri --no-rdoc \
    && bundle install \
    && sudo apt-get purge -y ruby-dev build-essential ruby-full \
    && sudo apt-get install -y ruby \
    && sudo apt-get clean && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Install Sinatra gem
RUN gem install sinatra --no-ri --no-rdoc

# Start Sinatra
CMD ["ruby", "app.rb"]

# ENTRYPOINT ["cypress", "run"]
