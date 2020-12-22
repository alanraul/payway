
defmodule Payway.Subscription do
  @moduledoc """
  Modulo para manejar subscripciones

  Conekta: https://developers.conekta.com/reference/suscripciones
  Paypal: https://developer.paypal.com/docs/api/subscriptions/v1/#subscriptions
  """

  @doc """
  Crea una subscripción
  """
  @spec new(String.t, map) :: tuple
  def new(source, data) do
    Payway.request(source, "new_subscription", data)
  end

  @doc """
  Cancela una subscripción
  """
  @spec cancel(String.t, String.t, map) :: tuple
  def cancel(source, subscription, data) do
    Payway.request(source, "cancel_subscription", subscription, data)
  end
end
