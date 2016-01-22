defmodule MyPhoenixChat.AuthController do
  use MyPhoenixChat.Web, :controller
#   def index(conn, _params) do
#     render conn, "index.html"
#   end
  
  def index(conn, %{"provider" => provider}) do
    redirect conn, external: authorize_url(provider)
  end

  defp authorize_url("twitter") do
    token = ExTwitter.request_token("http://127.0.0.1:4000/auth/twitter/callback")
    {:ok,url} = ExTwitter.authenticate_url(token.oauth_token)
    url
  end
  
  def callback(conn, %{ "provider" => provider, 
                        "oauth_token" => oauth_token, 
                        "oauth_verifier" => oauth_verifier }) do
    # Exchange an auth code for an access token
    
        
     
    {:ok, access_token} = ExTwitter.access_token(oauth_verifier, oauth_token)

    # Configure ExTwitter to use your newly obtained access token
    ExTwitter.configure(
        consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
        consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"),
        access_token: access_token.oauth_token,
        access_token_secret: access_token.oauth_token_secret
    )
    # Request the user's data with the access token
    # user = get_user!(provider, token)
    profile = ExTwitter.verify_credentials
    user = %{ name: profile.name, avater: profile.profile_image_url}

    # Store the user in the session under `:current_user` and redirect to /.
    # In most cases, we'd probably just store the user's ID that can be used
    # to fetch from the database. In this case, since this example app has no
    # database, I'm just storing the user map.
    #
    # If you need to make additional resource requests, you may want to store
    # the access token as well.
    conn
    |> put_session(:current_user, user)
    |> put_session(:access_token, access_token.oauth_token)
    |> put_session(:access_token_secret, access_token.oauth_token_secret)
    |> redirect(to: "/")
  end
  
   def delete(conn, _params) do
        conn
        |> put_flash(:info, "You have been logged out!")
        |> configure_session(drop: true)
        |> redirect(to: "/")
    end
end
