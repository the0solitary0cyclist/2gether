FROM cypress/included:6.2.1

WORKDIR /

# Copy Sinatra app into container
# ADD app.rb app.rb
# ADD worker.rb worker.rb
COPY . .

RUN apt-get update \
    && apt-get --allow-releaseinfo-change-suite update \
    && apt-get install -y ruby-full ruby-dev build-essential \
    && gem install bundler --no-ri --no-rdoc \
    && bundle install \
    && apt-get purge -y ruby-dev build-essential ruby-full \
    && apt-get install -y ruby \
    && apt-get clean && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Install Sinatra gem
RUN gem install sinatra --no-ri --no-rdoc

# Start Sinatra
CMD ["ruby", "app.rb"]

# ENTRYPOINT ["cypress", "run"]
