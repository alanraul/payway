
alias Payway.{Client, Order}

client = %{
  email: "kathe@conekta.com",
  name: "kathe",
  phone: "+5215555555555",
  payment_sources: [%{
    token_id: "tok_test_visa_4242",
    type: "card"
  }],
}

order_1 = %{
  currency: "MXN",
  line_items: [%{
    name: "Arepa maíz blanco",
    unit_price: 35,
    quantity: 10
  }],
  charges: [%{
    payment_method: %{
      type: "default"
    }
  }]
}

date = Timex.now("America/Mexico_City")

order_2 = %{
  currency: "MXN",
  line_items: [%{
    name: "Testla model 3",
    unit_price: 10_000_000,
    quantity: 1
  }],
  charges: [%{
    payment_method: %{
      monthly_installments: 12,
      type: "default"
    }
  }]
}

order_3 = %{
  currency: "MXN",
  line_items: [%{
    name: "Bicicleta",
    unit_price: 359_900,
    quantity: 1
  }],
  shipping_lines: [%{
    amount: 5_000,
    carrier: "FEDEX"
  }],
  shipping_contact: %{
    address: %{
      street1: "Calle 123, int 2",
      postal_code: "06100",
      country: "MX"
     }
  },
  charges: [%{
    payment_method: %{
      type: "oxxo_cash",
      expires_at: Timex.to_unix(Timex.set(date, month: date.month + 1))
    }
  }]
}

{:ok, client} = Client.create("conekta", client)

{:ok, order} = Order.create("conekta", client, order_1)
# IO.inspect order
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

{:ok, order} = Order.create("conekta", client, order_1)
# IO.inspect order
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


{:ok, order} = Order.create("conekta", client, order_2)
# IO.inspect order
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

{:ok, order} = Order.create("conekta", client, order_3)
IO.inspect order
