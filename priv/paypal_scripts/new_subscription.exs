alias Payway.{Products, Plan, Customer, Subscription}

product_data = %{
  name: "Massivex",
  description: "CRM para Whatsapp",
  type: "SERVICE",
  category: "SOFTWARE",
  image_url: "https://massivex.io/css/kit/core/img/logo_black.svg",
  home_url: "https://massivex.io/"
}

# -------------------------------------------------------------------------
# Billing Cycles.
#
# tenure_type:    (REGULAR | TRIAL)
# sequence:       Orden de prioridad TRIAL siempre deberia ser 1
# total_cycles:   Cantidad de veces que se ejecuta este ciclo de facturación 0 - 999 [0 infinito].
# pricing_scheme: Esquema de precios, un ciclo de prueba no requiere un esquema.
# interval_unit:  (DAY | WEEK | MONTH | YEAR)
# interval_count: Número de intervalos después de los cuales se factura a un suscriptor
#                 Ej: Si interval_unit es DAY con un interval de 2, la suscripción se factura 1 vez cada dos días.
#
# Payment preferences.
#
# auto_bill_outstanding:     Si se factura automáticamente el importe pendiente en el próximo ciclo de facturación.
# setup_fee:                 Tarifa de instalación inicial.
# setup_fee_failure_action:  Acción a realizar si falla el pago inicial (CONTINUE | CANCEL)
# payment_failure_threshold: Máximo de errores de pago antes de suspender la suscripción 0 - 999
# -------------------------------------------------------------------------

plan_data = %{
  # product_id: "PROD-XXCD1234QWER65782",
  name: "Starter",
  description: "Pequeñas Empresas",
  status: "ACTIVE",
  billing_cycles: [
    %{
      tenure_type: "REGULAR",
      sequence: 1,
      total_cycles: 0,
      pricing_scheme: %{
        fixed_price: %{
          value: "45",
          currency_code: "USD"
        }
      },
      frequency: %{
        interval_unit: "MONTH",
        interval_count: 1
      },
    }
  ],
  payment_preferences: %{
    auto_bill_outstanding: true,
    setup_fee: %{
      value: "0",
      currency_code: "USD"
    },
    setup_fee_failure_action: "CONTINUE",
    payment_failure_threshold: 3
  },
  taxes: %{
    percentage: "0",
    inclusive: true
  }
}

customer_data = %{
  name: "Katherine",
  email: "kat@conekta.com",
  phone: "+5215578870362",
  payment_sources: [%{
    type: "card",
    token_id: "tok_test_visa_4242"
  }]
}

{:ok, %{"products" => products}} = Products.list("paypal")

product =
  with nil <- Enum.find(products, &(&1["name"] == product_data.name)) do
    {:ok, product} = Products.create("paypal", product_data)

    product
  end

{:ok, %{"plans" => plans}} = Plan.list("paypal", product["id"])

plan =
  with nil <- Enum.find(plans, &(&1["name"] == plan_data.name)) do
    {:ok, plan} = Plan.create("paypal", Map.put(plan_data, :product_id, product["id"]))

    plan
  end
