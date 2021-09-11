FROM ruby:3

ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID devel
RUN useradd -u $UID -g devel -m devel
RUN echo "devel ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# updateではエラー以外表示させない
RUN apt-get update -qq && apt-get install -y nodejs npm default-mysql-client
RUN npm install -g yarn

WORKDIR /tmp
COPY ./docker/rails/init/Gemfile /tmp/Gemfile
COPY ./docker/rails/init/Gemfile.lock /tmp/Gemfile.lock
RUN bundle install

RUN mkdir /apps
COPY . /apps

# コンテナ起動時に実行されるスクリプトを追加
COPY ./docker/rails/shell/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

USER devel
WORKDIR /apps
