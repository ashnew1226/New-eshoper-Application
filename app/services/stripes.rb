class Stripes
  require 'stripe'
  Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    INVALID_STRIPE_OPERATION = 'Invalid Stripe Operation'
    def self.execute(user_order:, user:, product:, amount:, user_address:, coupon:)
      if product.stripe_plan_name.blank?
        charge = self.execute_payment_intent(price: amount,
                                    description: product.name)
      end
      unless charge&.id.blank?
        # If there is a charge with id, set order paid.
        user_order.payment_id = charge.id
        user_order.user_address_id = user_address.id
        if coupon.present?
          user_order.coupon_id = coupon.id
        end 
        user_order.set_paid
      end
      rescue Stripe::StripeError => e
        user_order.error_message = INVALID_STRIPE_OPERATION
        user_order.set_failed
        
      end
      private
      def self.execute_payment_intent(price:, description:)

      cutomer = Stripe::Customer.create({
        description: "test user for stripe api"
      })

      pay_method = Stripe::PaymentMethod.create({
        type: 'card',
        card: {
          number: '4242424242424242',
          exp_month: 8,
          exp_year: 2050,
          cvc: '314',
        },
      })

      pay_intent = Stripe::PaymentIntent.create({
        payment_method_types: ['card'],
        payment_method: pay_method.id,
        customer: cutomer.id,
        amount: price.to_s,
        currency: "inr",
        description: description,
        
      })
      Stripe::PaymentIntent.confirm(
        pay_intent.id,
        {payment_method: pay_method.id},
      )
    end
end
