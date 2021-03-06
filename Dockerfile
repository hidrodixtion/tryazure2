FROM ruby:2.3-slim
RUN apt-get update -qq && apt-get install -y build-essential patch ruby-dev zlib1g-dev liblzma-dev nodejs sqlite3 libsqlite3-dev
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

# Add a script to be executed everytime the container starts
COPY entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process
CMD ["rails", "server", "-b", "0.0.0.0"]