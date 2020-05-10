defmodule Payway.Order do
  @moduledoc """
  Modulo para manejar clientes
  """

  @doc """
  Crea un cliente

  ## Parameters

    - source: nombre del servicio a utilizar
    - data: mapa con data necesaria para crear un cliente

  ## Examples

    iex> Payway.Order.create("conekta", %{})
        {:ok, %{
          "corporate" => false,
          "created_at" => 1588323324,
          "custom_reference" => "",
          "email" => "fulanito@conekta.com",
          "id" => "cus_2nctnQwLhYfEnYCz5",
          "livemode" => true,
          "name" => "Fulanito Pérez",
          "object" => "customer"
        }}

    iex> Payway.Client.create("conecta", %{})
        {:error, "conecta is not supported"}

  """
  def create(source, client, data) do
    Payway.request(source, "new_order", {client, data})
  end
end
