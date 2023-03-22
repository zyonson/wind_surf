FROM ruby:3.1.2

ENV APP_ROOT /wind_surf
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT
COPY Gemfile $APP_ROOT/Gemfile
COPY Gemfile.lock $APP_ROOT/Gemfile.lock
RUN apt-get update && apt-get install -y libvips42
RUN yarn install --frozen-lockfile
RUN bundle install

COPY . $APP_ROOT


COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD /bin/sh -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 8080 -b '0.0.0.0'"
