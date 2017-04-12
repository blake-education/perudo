defmodule PerudoWeb.TestHelpers do
  alias PerudoWeb.Repo

  def insert_user(attrs \\ %{}) do
    changes = Dict.merge(%{
      name: "Annie Mik",
      username: "annie1",
      password: "123456",
    }, attrs)

    %PerudoWeb.User{}
    |> PerudoWeb.User.registration_changeset(changes)
    |> Repo.insert!()
  end
end
