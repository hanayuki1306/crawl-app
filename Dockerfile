# Use an official Elixir runtime as a parent image
FROM elixir:latest

RUN apt-get update && \
  apt-get install -y postgresql-client

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex package manager

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get

# Compile the project
RUN mix do compile

CMD ["/app/entrypoint.sh"]
# CMD ["mix", "ecto.migrate"]
# CMD ["mix","run","priv/repo/seeds.exs"]
# CMD ["mix","phx.server"]
