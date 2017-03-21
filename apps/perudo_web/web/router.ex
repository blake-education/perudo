defmodule PerudoWeb.Router do
  use PerudoWeb.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PerudoWeb.Auth, repo: PerudoWeb.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PerudoWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, except: [:delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", PerudoWeb do
  #   pipe_through :api
  # end
end
