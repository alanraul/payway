
use Mix.Config

config :payway, :conekta,
  private_key: System.get_env("CONEKTA_PRIVATE_KEY")

config :payway, :paypal,
  client_id: System.get_env("PAYPAL_CLIENT_ID"),
  client_secret: System.get_env("PAYPAL_CLIENT_SECRET")
