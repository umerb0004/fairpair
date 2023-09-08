# Base image
FROM ruby:2.7.1
# Set working directory
WORKDIR /app
# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./
# Install gems
RUN bundle install
# Copy the rest of the application code
COPY . .

# Set environment variables
ENV RAILS_ENV=development \
    DATABASE_URL=postgres://admin:password@localhost:5432/fair_pair \
    REDIS_URL=redis://redis:6379/0

# Precompile assets
RUN bundle exec rails assets:precompile

# Expose port 3000
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
