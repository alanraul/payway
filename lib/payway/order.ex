defmodule Payway.Order do
  @moduledoc """
  Módulo para manejar ordernes
  """

  @doc """
  Crea un cliente

  ## Parameters

    - source: nombre del servicio a utilizar
    - data: mapa con data necesaria para crear un cliente

  ## Examples

    iex> Payway.Order.create("conekta", %{})

    iex> Payway.Client.create("conecta", %{})
        {:error, "conecta is not supported"}

  """
  def create(source, data, metadata \\ nil) do
    Payway.request(source, "new_order", data, metadata)
  end

  def get(source, id) do
    Payway.request(source, "get_order", id)
  end
end
