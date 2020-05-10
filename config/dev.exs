
use Mix.Config

config :payway, :conekta,
  private_key: System.get_env("CONEKTA_PRIVATE_KEY")
