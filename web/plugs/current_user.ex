defmodule CodeCorps.Plug.CurrentUser do
  @analytics Application.get_env(:code_corps, :analytics)

  alias CodeCorps.GuardianSerializer

  def init(opts), do: opts

  def call(conn, _opts) do
    case Guardian.Plug.current_token(conn) do
      nil ->
        conn
      current_token ->
        with {:ok, claims} <- Guardian.decode_and_verify(current_token),
             {:ok, user} <- GuardianSerializer.from_token(claims["sub"]) do
                @analytics.identify(user)
                Plug.Conn.assign(conn, :current_user, user)
        else
          {:error, _reason} -> conn
        end
    end
  end
end
