defmodule Payway.Helpers.ResponseHelper do
  @moduledoc false
  # ---------------------------------------------------------------------------
  # Define la respuesta como la necesitamos en una tupla.
  # ---------------------------------------------------------------------------
  @spec handle_response(tuple) :: tuple
  def handle_response({:ok, %{status_code: 200, body: response}}) do
    {:ok, response}
  end
  def handle_response({:ok, %{body: error} = response}) do
    _handle_error(error)
  end

  defp _handle_error(%{"error" => error}) do
    {:error, error}
  end
  defp _handle_error(error) do
    {:error, error["details"]}
  end
end
