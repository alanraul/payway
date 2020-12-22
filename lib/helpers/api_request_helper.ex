defmodule Payway.Helpers.ApiRequestHelper do
  @moduledoc false
  use HTTPoison.Base

  @doc """
  Devuelve la url del request
  """
  @spec process_request_url(String.t()) :: String.t()
  def process_request_url(url), do: url

  @doc """
  Devuelve los headers del request
  """
  @spec process_request_headers(list) :: list
  def process_request_headers(headers), do: headers

  @doc """
  Devuelve el body que se envía en el request
  """
  @spec process_request_body(map) :: String.t()
  def process_request_body(body) when is_binary(body), do: body
  def process_request_body(body), do: Jason.encode!(body)

  @doc """
  Devuelve el body que se recibe en el request
  """
  @spec process_response_body(String.t()) :: map
  def process_response_body(""), do: ""
  def process_response_body(body), do: Jason.decode!(body)
end
