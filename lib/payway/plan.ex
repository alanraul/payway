
defmodule Payway.Plan do
  @moduledoc """
  Modulo para manejar planes
  """

  @doc """
  Lista planes

  - paypal: https://developer.paypal.com/docs/api/subscriptions/v1/#plans_list
  """
  def list(source, data) do
    Payway.request(source, "plans", data)
  end

  @doc """
  Crea un cliente

  - conekta: https://developers.conekta.com/reference/planes
  - paypal: https://developer.paypal.com/docs/api/subscriptions/v1/#plans_create
  """
  def create(source, data) do
    Payway.request(source, "new_plan", data)
  end

  @doc """
  Crea un cliente

  ## Parameters

    - source: nombre del servicio a utilizar
    - data: mapa con data necesaria para crear un cliente

  ## Examples

    iex> Payway.Plan.get("conekta", "plan24-222ay")
      {:ok, client_data}

    iex> Payway.Plan.get("conecta", %{})
      {:error,}
  """
  def get(source, id), do: Payway.request(source, "plan", id)
  def get(source, id), do: Payway.request(source, "plan", id)
end
