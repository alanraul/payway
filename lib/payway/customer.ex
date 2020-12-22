defmodule Payway.Customer do
  @moduledoc """
  Modulo para manejar clientes
  """

  @doc """
  Crea un cliente

  ## Parameters

    - source: nombre del servicio a utilizar
    - data: mapa con data necesaria para crear un cliente

  ## Examples

    iex> Payway.Customer.create("conekta", %{email: "kat@conekta.com", name: "Katherine"})
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
  def create(source, data) do
    with {:ok, client} <- Payway.request(source, "new_customer", data) do
      {:ok, client}
    end
  end

  @doc """
  Crea un cliente

  ## Parameters

    - source: nombre del servicio a utilizar
    - data: mapa con data necesaria para crear un cliente

  ## Examples

    iex> Payway.Customer.get("conekta", "cus_2ndkDk1vNVEJWcaH7")
      {:ok, client_data}

    iex> Payway.Customer.get("conecta", %{})
      {:error,}
  """
  def get(source, %{conekta_id: id}), do: Payway.request(source, "get_customer", id)
  def get(source, id), do: Payway.request(source, "get_customer", id)
end
