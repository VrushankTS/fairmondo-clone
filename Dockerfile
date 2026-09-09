FROM ruby:2.7-alpine

# Install build dependencies
RUN apk add --no-cache \
    build-base \
    postgresql-dev \
    imagemagick \
    nodejs \
    postgresql-client \
    git \
    tzdata

WORKDIR /app

# Install bundler 2.4.22
RUN gem install bundler -v 2.4.22

# Copy Gemfiles first for layer caching
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 5

# Copy app code
COPY . .

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]