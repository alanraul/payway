defmodule Payway.Gateways.ConektaAPI do
  @moduledoc false
  # Módulo base para hacer llamadas a Conekta API.

  alias Payway.Helpers.{ApiHelper, ResponseHelper}

  @host "https://api.conekta.io/"

  def request("new_client", data) do
    "#{@host}/customers"
    |> ApiHelper.post(data, _headers())
    |> ResponseHelper.handle_response()
  end
  def request("new_order", {client, data}) do
    order = Map.put(data, :customer_info, %{customer_id: client["id"]})

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
