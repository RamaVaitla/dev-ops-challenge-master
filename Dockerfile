# Use ruby 2.3-alpine image
FROM ruby:2.3-alpine

# Install necessary libraries and tools
RUN apk add --no-cache \
    build-base \
    postgresql-dev \
    nodejs \
    tzdata

# Install specific version of Bundler to match your Gemfile.lock
RUN gem install bundler -v '1.13.6'

# Set working directory in the image to /app
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the image
COPY Gemfile Gemfile.lock ./

# Install the Ruby gems
RUN bundle _1.13.6_ install

# Copy the app code into the image
COPY . .

# # Make sure 'entrypoint.sh' is executable
# RUN ["chmod", "+x", "/app/entrypoint.sh"]

# Expose port 3000 in the image
EXPOSE 3000

# # Run Bash Script
# ENTRYPOINT ["./entrypoint.sh"]

# Set the startup command to run Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
