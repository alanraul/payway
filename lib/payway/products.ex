defmodule Payway.Products do
  @moduledoc """
  Modulo para manejar productos
  """

  @doc """
  Lista productos
  """
  def list(source, data \\ %{page_size: 50, page: 1}) do
    Payway.request(source, "products", data)
  end

  @doc """
  Crea un cliente
  """
  def create(source, data) do
    Payway.request(source, "new_product", data)
  end

  @doc """
  obtiene un cliente
  """
  def get(source, id), do: Payway.request(source, "product", id)
end
