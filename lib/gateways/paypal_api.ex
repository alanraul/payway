defmodule Payway.Gateways.PaypalAPI do
  @moduledoc """
  Módulo base para hacer llamadas a Conekta API.
  """

  alias Payway.Helpers.ApiRequestHelper, as: Request
  alias Payway.Helpers.ApiResponseHelper, as: Response
  alias Payway.Helpers.ConektaOrderHelper

  require Logger

  @auth_headers [{"Content-Type", "application/x-www-form-urlencoded"}]

  @doc """
  Realiza petición al API de conkecta y devuelve una respuesta
  manejable
  """
  @spec request(String.t, any) :: tuple
  def request("get_customer", id) do
    "customers/#{id}"
    |> _set_url()
    |> Request.get(_headers())
    |> Response.handle()
  end

  def request("products", data) do
    "catalogs/products?page_size=#{data.page_size}&page=#{data.page}"
    |> _set_url()
    |> Request.get(_headers())
    |> Response.handle()
  end
  def request("new_product", data) do
    "catalogs/products"
    |> _set_url()
    |> Request.post(data, _headers())
    |> Response.handle()
  end
  def request("product", id) do
    "catalogs/products/#{id}"
    |> _set_url()
    |> Request.get(_headers())
    |> Response.handle()
  end

  def request("plans", product_id) do
    "billing/plans?product_id=#{product_id}"
    |> _set_url()
    |> Request.get(_headers())
    |> Response.handle()
  end
  def request("new_plan", data) do
    "billing/plans"
    |> _set_url()
    |> Request.post(data, _headers())
    |> Response.handle()
  end

  def request("new_subscription", data) do
    "billing/subscriptions"
    |> _set_url()
    |> Request.post(data, _headers())
    |> Response.handle()
  end
  def request("cancel_subscription", subscription, data) do
    "billing/subscriptions/#{subscription}/cancel"
    |> _set_url()
    |> Request.post(data, _headers())
    |> Response.handle()
  end

  @spec _set_url(String.t) :: String.t
  defp _set_url(endpoint) do
    case System.get_env("MIX_ENV") do
      "prod" ->
        "https://api-m.paypal.com/v1/#{endpoint}"
      _ ->
        "https://api-m.sandbox.paypal.com/v1/#{endpoint}"
    end
  end

  @spec _headers() :: list
  defp _headers() do
    [
      {"Authorization", "Bearer #{_authorization()}"},
      {"Content-Type", "application/json"}
    ]
  end

  @spec _authorization() :: String.t
  defp _authorization() do
    options = [hackney: [basic_auth: {
      Application.get_env(:payway, :paypal)[:client_id],
      Application.get_env(:payway, :paypal)[:client_secret]
    }]]

    response =
      "oauth2/token"
      |> _set_url()
      |> Request.post("grant_type=client_credentials", @auth_headers, options)

    case Response.handle(response) do
      {:ok, %{"access_token" => token} = response} ->
        token
      {:error, error} ->
        Logger.error("Paypal auth error: #{inspect(error)}")

        nil
    end
  end
end
