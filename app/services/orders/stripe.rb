class Orders::Stripe
  require 'stripe'
  Stripe.api_key = 'sk_test_51ME59WSDCO9rQieouDgPB589PVx9cdYWonNq11UlMzvKx3K2jpon9sLXMdwrrCTcpMEXFk25r9F1XBYo7LcfX0uc00DXuFAO1L'
    INVALID_STRIPE_OPERATION = 'Invalid Stripe Operation'
    def self.execute(user_order:, user:, product:)
      if product.stripe_plan_name.blank?
        binding.pry
        charge = self.execute_payment_intent(price: product.price,
                                    description: product.name)
      end
      unless charge&.id.blank?
        # If there is a charge with id, set order paid.
        user_order.charge_id = charge.id
        user_order.set_paid
      end
      rescue Stripe::StripeError => e
        user_order.error_message = INVALID_STRIPE_OPERATION
        user_order.set_failed
        
      end
      private
      def self.execute_payment_intent(price:, description:)
      Stripe::PaymentIntent.create({
        amount: price,
        currency: "inr",
        description: description,
        # source: card_token
      })
    end
end
# pi_3MJ9TwSDCO9rQieo1rDPBqie