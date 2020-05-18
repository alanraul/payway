alias Payway.{Client, Order}

date = Timex.now("America/Mexico_City")

order = %{
  "order" => 1,
  "currency" => "MXN",
  "customer" => %{
    "id" => 1,
    "conekta_id" => "cus_2ndkDk1vNVEJWcaH7",
    "email" => "kat@addabra.com",
    "name" => "katherine",
    "phone" => "5215578870362",
  },
  "items" => [
    %{
      "id" => 3,
      "order_id" => 1,
      "name" => "Arepa maíz blanco",
      "unit_price" => 20.0,
      "product_id" => 1,
      "quantity" => 5,
    }
  ],
  "payment_method" => %{
    "type" => "oxxo_cash",
    "expires_at" => Timex.to_unix(Timex.set(date, month: date.month + 1))
  }
}

metadata = %{
  line_items: "items",
  items: [{:name, "name"}, {:unit_price, "unit_price"}, {:quantity,  "quantity"}],
  payment_method: ["type", "expires_at"]
}


order = Order.create("conekta", order, metadata) |> IO.inspect

IO.inspect "Orden: #{order["id"]}"
IO.inspect "Status: #{order["payment_status"]}"

IO.inspect "Total: #{order["amount"]}"

IO.inspect "Detail:"
Enum.map(order["line_items"]["data"], fn item ->
  IO.inspect "#{item["quantity"]} - #{item["name"]} - #{item["unit_price"]}"
end)

IO.inspect "Detail:"

Enum.map(order["charges"]["data"], fn %{"payment_method" => paymethod} ->
  IO.inspect "code: #{paymethod["auth_code"]}"
  IO.inspect "card info: #{paymethod["last4"]} - #{paymethod["brand"]} - #{paymethod["type"]}"
end)
