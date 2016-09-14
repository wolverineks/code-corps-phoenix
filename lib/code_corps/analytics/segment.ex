defmodule CodeCorps.Analytics.Segment do
  def identify(user) do
    %Segment.Analytics.Identify
      {
        userId: user.id,
        traits: traits(user)
      }
      |> Segment.Analytics.identify
  end

  defp traits(user) do
    %{
      admin: user.admin,
      biography: user.biography,
      created_at: user.inserted_at,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      state: user.state,
      twitter: user.twitter,
      username: user.username
    }
  end
end
