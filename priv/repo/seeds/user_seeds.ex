alias WeatherDiff.Repo
alias WeatherDiff.Features.User

Repo.insert! %User{
  first_name: "Joe",
  last_name: "Bruno",
  email: "joevbruno@me.com",
  username: "joevbruno",
  password: "password"
}
