use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.

webpack_args = ["node_modules/webpack/bin/webpack.js", "--watch", "--colors",
  "--progress"]
# Remove progress argument to make iex display log normally
if IEx.started?, do: webpack_args = List.delete(webpack_args, "--progress")

config :myPhoenixChat, MyPhoenixChat.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  check_origin: false,
 # watchers: [{Path.expand("node_modules/webpack/bin/webpack.js"), ["--watch", "--colors", "--progress"]}]
 watchers: [node: webpack_args]
# Watch static and templates for browser reloading.
config :myPhoenixChat, MyPhoenixChat.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :myPhoenixChat, MyPhoenixChat.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "devuser",
  password: "devuserdevuser",
  database: "myphoenixchat_dev",
  hostname: "localhost",
  pool_size: 10

# configure Twitter auth
config :extwitter, :oauth,
  consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET")
  
