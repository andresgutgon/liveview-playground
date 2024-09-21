FROM elixir:1.17.2

RUN apt-get update && \
    apt-get install --yes build-essential inotify-tools postgresql-client git && \
    apt-get clean
#
ADD . /app
#
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install --force hex phx_new 1.7.14

RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs

WORKDIR /app

RUN mix deps.get
RUN npm install --prefix ./assets

EXPOSE 4004

CMD ["mix", "phx.server"]
