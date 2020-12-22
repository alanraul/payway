defmodule Payway do
  @moduledoc """
  Documentation for `Payway`.
  """

  alias Payway.Gateways.{ConektaAPI, PaypalAPI}

  @spec request(String.t, String.t, any) :: tuple
  @spec request(String.t, String.t, any, any) :: tuple
  def request("conekta", action, data), do: ConektaAPI.request(action, data)
  def request("paypal", action, data), do: PaypalAPI.request(action, data)
  def request("conekta", action, data, metadata) do
    ConektaAPI.request(action, data, metadata)
  end
  def request("paypal", action, data, metadata) do
    PaypalAPI.request(action, data, metadata)
  end
  def request(source, _event, _data), do: {:error, "#{source} is not supported"}
  def request(source, _event, _data, _metadata) do
    {:error, "#{source} is not supported"}
  end
end
