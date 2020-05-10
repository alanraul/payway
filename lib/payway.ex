defmodule Payway do
  @moduledoc """
  Documentation for `Payway`.
  """

  alias Payway.Gateways.ConektaAPI

  def request("conekta", action, data) do
    ConektaAPI.request(action, data)
  end
  def request(source, _event, _data) do
    {:error, "#{source} is not supported"}
  end
end
