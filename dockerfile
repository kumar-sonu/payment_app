FROM ruby:2.6.3

RUN apt-get update && apt-get -y install nodejs && apt-get -y install nano && apt-get -y install curl
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update && apt-get install -y yarn && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock package.json yarn.lock ./
RUN bundle install

COPY . .

RUN yarn install
 
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
