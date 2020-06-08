defmodule Payway.Gateways.ConektaAPI do
  @moduledoc false
  # Módulo base para hacer llamadas a Conekta API.

  alias Payway.Helpers.{ApiHelper, ResponseHelper, ConektaOrderHelper}

  @host "https://api.conekta.io/"

  def request("get_client", id) do
    "#{@host}/customers/#{id}"
    |> ApiHelper.get(_headers())
    |> ResponseHelper.handle_response()
  end
  def request("get_order", id) do
    "#{@host}/orders/#{id}"
    |> ApiHelper.get(_headers())
    |> ResponseHelper.handle_response()
  end
  def request("new_client", data) do
    "#{@host}/customers"
    |> ApiHelper.post(data, _headers())
    |> ResponseHelper.handle_response()
  end
  def request("new_order", data, metadata) do
    order = ConektaOrderHelper.set_order(data, metadata) |> IO.inspect

    "#{@host}/orders"
    |> ApiHelper.post(order, _headers())
    |> ResponseHelper.handle_response()
  end

  def _headers() do
    [
      {"Accept", "application/vnd.conekta-v2.0.0+json"},
      {"Authorization", "Basic #{_authorization()}"}
    ]
  end

  defp _authorization() do
    Base.encode64(Application.get_env(:payway, :conekta)[:private_key])
  end
end
