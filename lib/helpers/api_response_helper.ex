defmodule Payway.Helpers.ApiResponseHelper do
  @moduledoc false

  # ---------------------------------------------------------------------------
  # Define la respuesta como la necesitamos en una tupla.
  # ---------------------------------------------------------------------------
  @spec handle(tuple) :: tuple
  def handle({:ok, %{status_code: 200, body: response}}), do: {:ok, response}
  def handle({:ok, %{status_code: 201, body: response}}), do: {:ok, response}
  def handle({:ok, %{status_code: 404}}), do: {:error, "404 not found"}
  def handle({:ok, %{status_code: 204, request_url: url}}) do
    if String.contains?(url, "/cancel") do
      {:ok, :cancel}
    else
      {:error, 204}
    end
  end
  def handle({:ok, %{body: error} = response}) do
    _handle_error(error)
  end
  def handle({:error, %HTTPoison.Error{id: nil, reason: {:options, _}}}) do
    {:error, "Internal server error"}
  end

  defp _handle_error(%{"error" => error}), do: {:error, error}
  defp _handle_error(%{"details" => details}), do: {:error, details}
end
