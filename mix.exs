defmodule WeatherDiff.Mixfile do
  use Mix.Project

  def project do
    [
      app: :weather_diff,
      # apps_path: "apps",
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      # build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
      # preferred_cli_env: [coveralls: :test]]
      # preferred_cli_env: [
      #   "coveralls": :test,
      #   "coveralls.html": :test,
      #   "coveralls.json": :test,
      #  ],
      #  test_coverage: [tool: ExCoveralls]]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {WeatherDiff.Application, []},
      extra_applications: [:logger, :runtime_tools ]
      # :postgrex, :absinthe, :absinthe_plug, :absinthe_ecto, :poison, :faker, :comeonin, :guardian, :bcrypt_elixir, :httpoison
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      ## ADDED DEPS ##
      {:httpoison, "~> 1.0"},
      {:poison, "~> 3.1.0"},

      {:comeonin, "~> 4.0"},
      {:argon2_elixir, "~> 1.2"},
      {:absinthe, "~> 1.4.6"},
      {:absinthe_plug, "~> 1.4.2"},
      {:absinthe_ecto, git: "https://github.com/absinthe-graphql/absinthe_ecto.git"},
      {:faker, "~> 0.9"},
      {:bcrypt_elixir, "~> 1.0"},
      {:guardian, "~> 1.0"},
      {:ja_serializer, "~> 0.12.0"}, # github: "vt-elixir/ja_serializer"},
      {:cors_plug, "~> 1.3"},
      {:excoveralls, "~> 0.7.2", only: :test},
      {:oauth, "~> 1.6", github: "tim/erlang-oauth"},
      {:ueberauth, "~> 0.4"},
      {:ueberauth_google, "~> 0.6"},
      {:credo, "~> 0.9.0-rc1", only: [:dev, :test], runtime: false},
      {:ex_machina, "~> 2.1", only: :test},
      {:exactor, "~> 2.2.4", warn_missing: false},
      {:mix_test_watch, "~> 0.2", only: :dev},
      {:dogma, ">= 0.0.0", only: [:dev, :test]},
      # {:hound, "~> 1.0"}
      # {:distillery, "~> 1.5", runtime: false}
      {:confex, ">= 0.0.0"},
      {:scrivener_ecto, "~> 1.2"},
      {:eview, ">= 0.0.0"},
      {:timex, "~> 3.1.0"},
      {:plug_logger_json, "~> 0.5"},
      {:ecto_logger_json, "~> 0.1"},
      {:proper_case, "~> 1.0.0"},
      {:plug, "~> 1.0"},
      {:corsica, "~> 1.0"},

      {:ecto_state_machine, "~> 0.3.0"},
      {:facebook, "~> 0.11.0"},
      {:bodyguard, "~> 2.1"},
      {:remote_ip, "~> 0.1.0"},
      {:hammer, "~> 0.1.0"},
      {:hammer_backend_redis, "~> 0.1.0"},
      {:ua_parser, "~> 1.2"},
      {:recon, "~> 2.3.2"},
      {:mock, "~> 0.2.0", only: :test}

      # {:earmark, "1.0.1" },
      # {:phoenix_html_sanitizer, "~> 1.1.0-rc1"},
      # {:oauth2, "~> 0.0"},
      # {:oauth, github: "tim/erlang-oauth"},
      # {:extwitter, "~> 0.7"},
      # {:scrivener, "~> 1.1"},
      # {:calendar, "~> 0.14"},
      # {:appsignal, "~> 0.0"},
      # {:gelf_logger, "~> 0.7.3"},

      # {:bamboo, "~> 0.7"},
      # {:dialyxir, "~> 0.3", only: [:dev]},
      # {:earmark, github: "pragdave/earmark"},
      # {:envy, "~> 0.0.1"},
      # {:exgravatar, "~> 0.2"},
      # {:good_times, "~> 1.1"},
      # {:honeybadger, "~> 0.6"},
      # {:oauth2, "~> 0.5"},
      # {:pact, "0.1.0"},
      # {:quick_alias, "~> 0.1.0"},
      # {:scrivener_ecto, "~> 1.1"},
      # {:secure_random, "~> 0.1"},
      # {:wallaby, "~> 0.6", only: :test},

      # {:guardian_db, "~> 0.8"},
      # {:logger_file_backend, "0.0.10"},
      # {:bypass, "~> 0.2", only: :test}

      # {:hackney, "~> 1.7.1", override: true},
      # {:jsx, "~> 2.8.0"},
      # {:joken, "~> 1.4.1"},
      # {:elixometer, github: "pinterest/elixometer"},
      # {:exometer_newrelic_reporter, github: "nitro/exometer_newrelic_reporter"},
      # {:lager, "3.2.4", override: true},
      # {:lager_logger, github: "PSPDFKit-labs/lager_logger"},

      # # Test only
      # {:mock, "~> 0.1.1", only: :test},

    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"],
      "ecto.migrate": ["ecto.migrate", "ecto.dump"]
    ]
  end
end
