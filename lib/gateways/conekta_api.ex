defmodule Payway.Gateways.ConektaAPI do
  @moduledoc """
  Módulo base para hacer llamadas a Conekta API.
  """

  alias Payway.Helpers.ApiRequestHelper, as: Request
  alias Payway.Helpers.ApiResponseHelper, as: Response
  alias Payway.Helpers.ConektaOrderHelper

  @host "https://api.conekta.io"

  @doc """
  Realiza petición al API de conkecta y devuelve una respuesta
  manejable
  """
  @spec request(String.t, any) :: tuple
  def request("get_customer", id) do
    "#{@host}/customers/#{id}"
    |> Request.get(_headers())
    |> Response.handle()
  end
  def request("get_order", id) do
    "#{@host}/orders/#{id}"
    |> Request.get(_headers())
    |> Response.handle()
  end
  def request("plan", id) do
    "#{@host}/plans/#{id}"
    |> Request.get(_headers())
    |> Response.handle()
  end
  def request("new_customer", data) do
    "#{@host}/customers"
    |> Request.post(data, _headers())
    |> Response.handle()
  end
  def request("new_order", data, metadata) do
    order = ConektaOrderHelper.set_order(data, metadata)

    "#{@host}/orders"
    |> Request.post(order, _headers())
    |> Response.handle()
  end
  def request("new_plan", data) do
    "#{@host}/plans"
    |> Request.post(data, _headers())
    |> Response.handle()
  end
  def request("new_subscription", customer, data) do
    "#{@host}/customers/#{customer}/subscription"
    |> Request.post(data, _headers())
    |> Response.handle()
  end

  @spec _headers() :: list
  defp _headers() do
    [
      {"Accept", "application/vnd.conekta-v2.0.0+json"},
      {"Authorization", "Basic #{_authorization()}"}
    ]
  end

  @spec _authorization() :: String.t
  defp _authorization() do
    Base.encode64(Application.get_env(:payway, :conekta)[:private_key])
  end
end
