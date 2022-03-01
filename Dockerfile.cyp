FROM cypress/included:6.2.1
FROM heroku/heroku:16

WORKDIR /

# Copy Sinatra app into container
# ADD app.rb app.rb
# ADD worker.rb worker.rb
COPY . .

# Install Sinatra gem
RUN gem install sinatra --no-ri --no-rdoc

# Start Sinatra
CMD ["ruby", "app.rb"]

# ENTRYPOINT ["cypress", "run"]
