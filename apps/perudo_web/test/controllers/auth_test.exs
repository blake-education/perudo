defmodule PerudoWeb.AuthTest do
  use PerudoWeb.ConnCase
  alias PerudoWeb.Auth

  setup %{conn: conn} do
    conn =
      conn
      |> bypass_through(PerudoWeb.Router, :browser)
      |> get("/")
    {:ok, %{conn: conn}}
  end

  test "authenticate_user should halt when no current_user exists", %{conn: conn} do
    conn = Auth.authenticate_user(conn, [])
    assert conn.halted
  end

  test "login should create a session for a user", %{conn: conn} do
    login_conn =
      conn
      |> Auth.login(%PerudoWeb.User{id: 1})
      |> send_resp(:ok, "")

    next_conn = get(login_conn, "/")
    assert get_session(next_conn, :user_id) == 1
  end

  test "logout should drop the session", %{conn: conn} do
    logout_conn =
      conn
      |> put_session(:user_id, 1)
      |> Auth.logout()
      |> send_resp(:ok, "")

    next_conn = get(logout_conn, "/")
    assert get_session(next_conn, :user_id)
  end

  test "call with no session sets current_user to nil", %{conn: conn} do
    conn = Auth.call(conn, Repo)
    assert conn.assigns.current_user == nil
  end

  test "login with valid username and password", %{conn: conn} do
    user = insert_user(username: "annie", password: "123456")
    {:ok, conn} =
      Auth.login_by_username_and_pass(conn, "annie", "123456", repo: Repo)
    assert conn.assigns.current_user.id == user.id
  end

  test "login with a user that isnt found", %{conn: conn} do
    assert{:error, :not_found, _conn} =
      Auth.login_by_username_and_pass(conn, "annie", "123456", repo: Repo)
  end

  test "login with password mismatch", %{conn: conn} do
    _ = insert_user(username: "me", password: "secret")
    assert {:error, :unauthorized, _conn} =
      Auth.login_by_username_and_pass(conn, "me", "wrong", repo: Repo)
  end
end
