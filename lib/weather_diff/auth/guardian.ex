defmodule WeatherDiff.Auth.Guardian do
    use Guardian, otp_app: :weather_diff

    alias WeatherDiff.Repo
    alias WeatherDiff.Features.User

    # The subject_for_token needs to return something that can identify our user, so we will return the id field
    def subject_for_token(%User{} = user, _claims), do: {:ok, to_string(user.id)}
    def subject_for_token(_, _), do: {:error, "Unknown resource type"}

    # The resource_from_claims is just the opposite, where we extract an id from the claims of JWT, then return the matching user.
    def resource_from_claims(%{"sub" => user_id}) do
      user = Repo.get(User, user_id)
      { :ok, user }
    end

    def resource_from_claims(_claims), do: {:error, "Unknown resource type"}
  end