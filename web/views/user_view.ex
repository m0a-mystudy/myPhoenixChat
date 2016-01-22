defmodule MyPhoenixChat.UserView do
  use MyPhoenixChat.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, MyPhoenixChat.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, MyPhoenixChat.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name}
  end
end
