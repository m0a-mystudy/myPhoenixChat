ExUnit.start

Mix.Task.run "ecto.create", ~w(-r MyPhoenixChat.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r MyPhoenixChat.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(MyPhoenixChat.Repo)

