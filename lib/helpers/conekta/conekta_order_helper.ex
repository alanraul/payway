defmodule Payway.Helpers.ConektaOrderHelper do
  @moduledoc """
  Helper para falicitar el definir una order
  """

  @metadata %{
    line_items: :items,
    items: [{:name, :name}, {:unit_price, :unit_price}, {:quantity, :quantity}],
    payment_method: [:type, :expires_at]
  }

  def set_order(order, metadata) do
    with {:ok, customer} <- _get_customer(order),
      {:ok, currency} <- _get_currency(order),
      {:ok, paymethod} <- _get_paymethod(order, metadata),
      items <- _get_items(order, metadata) do

        %{
          currency: currency,
          customer_info: customer,
          line_items: items,
          charges: [%{
            payment_method: paymethod
          }]
        }
    end
  end

  defp _get_customer(%{customer: %{conekta_id: id}}), do: _set_customer_info(id)
  defp _get_customer(%{"customer" => %{"conekta_id" => id}}), do: _set_customer_info(id)

  defp _get_currency(%{currency: currency}), do: {:ok, currency}
  defp _get_currency(%{"currency" => currency}), do: {:ok, currency}

  defp _set_customer_info(id) when is_binary(id), do: {:ok, %{customer_id: id}}
  defp _set_customer_info(id), do: {:error, "Order: invalid customer id #{inspect(id)}"}

  # ---------------------------------------------------------------------------
  #
  # ---------------------------------------------------------------------------
  @spec _get_items(map, map) :: list
  defp _get_items(order, nil) do
    order
    |> Map.get(@metadata.line_items)
    |> _set_items(@metadata.items)
  end
  defp _get_items(order, %{line_items: line_items, items: items}) do
    order
    |> Map.get(line_items)
    |> _set_items(items)
  end
  defp _get_items(order, %{line_items: line_items}) do
    order
    |> Map.get(line_items)
    |> _set_items(@metadata.items)
  end
  defp _get_items(order, %{items: items}) do
    order
    |> Map.get(@metadata.line_items)
    |> _set_items(items)
  end
  defp _get_items(_order, _metadata), do: {:error, "Items not found"}

  # ---------------------------------------------------------------------------
  #
  # ---------------------------------------------------------------------------
  @spec _set_items(nil | list, {list, atom}) :: map
  defp _set_items(nil, _metadata), do: {:error, "Items not found"}
  defp _set_items(items, keys) do
    Enum.map(items, fn item ->
      Enum.reduce(keys, %{}, fn {elem, value}, acc ->
        item
        |> _get_item_value(value)
        |> _set_price(elem)
        |> (&Map.put(acc, elem, &1)).()
      end)
    end)
  end

  # ---------------------------------------------------------------------------
  #
  # ---------------------------------------------------------------------------
  @spec _get_item_value(map, list | atom | String.t) :: any
  defp _get_item_value(item, keys) when is_list(keys) do
    Enum.reduce(keys, item, &(Map.get(&2, &1)))
  end
  defp _get_item_value(item, key), do: Map.get(item, key)

  defp _set_price(value, :unit_price), do: Kernel.trunc(value * 100)
  defp _set_price(value, _), do: value

  # ---------------------------------------------------------------------------
  #
  # ---------------------------------------------------------------------------
  @spec _get_paymethod(map, map) :: tuple
  defp _get_paymethod(%{payment_method: method}, metadata) do
    _set_paymethod(method, metadata)
  end
  defp _get_paymethod(%{"payment_method" => method}, metadata) do
    _set_paymethod(method, metadata)
  end
  defp _get_paymethod(_order, _metadata), do: {:error, "Payment method not found"}

  # ---------------------------------------------------------------------------
  #
  # ---------------------------------------------------------------------------
  @spec _get_paymethod(map, map) :: tuple
  defp _set_paymethod(nil, metadata), do: {:error, "Payment method not found"}
  defp _set_paymethod(paymethod, %{payment_method: paymethod}) do
    {:ok, Map.take(paymethod, paymethod)}
  end
  defp _set_paymethod(paymethod, metadata) do
    {:ok, Map.take(paymethod, @metadata.payment_method)}
  end

end
