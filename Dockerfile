FROM elixir:1.10.4-alpine as build

# prepare build dir
RUN mkdir /app
COPY . /app
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
  mix local.rebar --force

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get
RUN mix deps.compile

# build project
RUN mix compile
EXPOSE 4000

RUN chmod +x /app/entrypoint.sh
USER nobody


CMD [ "/app/entrypoint.sh" ]
