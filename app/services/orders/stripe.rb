class UserOrders::Stripe
    INVALID_STRIPE_OPERATION = 'Invalid Stripe Operation'
    def self.execute(user_order:, user:)
      product = user_order.product
      binding.pry
      # Check if the order is a plan
      if product.stripe_plan_name.blank?
        charge = self.execute_charge(price_cents: product.price,
                                     description: product.name,
                                     card_token:  user_order.token)
      else
         #SUBSCRIPTIONS WILL BE HANDLED HERE
      end
  
      unless charge&.id.blank?
        # If there is a charge with id, set order paid.
        user_order.charge_id = charge.id
        user_order.set_paid
      end
    rescue Stripe::StripeError => e
      # If a Stripe error is raised from the API,
      # set status failed and an error message
      user_order.error_message = INVALID_STRIPE_OPERATION
      user_order.set_failed
    end
    private
    def self.execute_charge(price_cents:, description:, card_token:)
      Stripe::Charge.create({
        amount: price.to_s,
        currency: "usd",
        description: description,
        source: card_token
      })
    end
  end