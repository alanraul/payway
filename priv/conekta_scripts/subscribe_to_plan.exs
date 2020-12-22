alias Payway.{Plan, Customer, Subscription}

plan_data = %{
  id: "free-plan",
  name: "Free Plan",
  amount: 3_000, # Precio en centavos
  currency: "USD",
  interval: "month",
  frequency: 1,
  trial_period_days: 0,
  expiry_count: 1
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

with {:error, "404 not found"} <- Plan.get("conekta", plan_data.id) do
  {:ok, plan} = Plan.create("conekta", plan_data)
end

{:ok, customer} = Customer.create("conekta", customer_data)

{:ok, subscription} = Subscription.new(
    "conekta", customer["id"], %{"plan" => plan_data.id}
  )

# subscription = %{
#   "billing_cycle_end" => 1610496001,
#   "billing_cycle_start" => 1607817601,
#   "card_id" => "src_2otf1CRaoUNGsu8Lx",
#   "charge_id" => "5fd5598b6a7745317f081aea",
#   "created_at" => 1607817611,
#   "customer_id" => "cus_2otf1CRaoUNGsu8Lu",
#   "id" => "sub_2otf1CYNevM38FYmt",
#   "last_billing_cycle_order_id" => "ord_2otf1CYNevM38FYmw",
#   "object" => "subscription",
#   "billing_plan_id" => "free-plan",
#   "status" => "active",
#   "subscription_start" => 1607817611,
#   "trial_end" => 1607817611
# }

