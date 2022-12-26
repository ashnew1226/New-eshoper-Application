#<ActionController::Parameters {
    "authenticity_token"=>"l8CXQrlm93rlwAXz9mp6-xyjm4938ZYV3m34_9WLMM5ckVBhZalPUW0fdxEkPnXp_PWZDoR6H0wJ5V9fxTtC4w", 
    "user_orders"=>#<ActionController::Parameters {
        "payment_gateway"=>"stripe", 
        "product_id"=>"5", 
        "token"=>"tok_1MFEgCSDCO9rQieoJL9H4fBG"
    } permitted: false>, 
    "payment-selection"=>"stripe", 
    "controller"=>"orders", 
    "action"=>"submit"
} 
permitted: false>


<%= form_for UserOrder.new,  url: eshop_user_order_information_path, turbo_method: :post do |form| %>				
							<div class="row">
								<div class="row">
									<div class="col-md-6 mb-3">
										<%= form.label :full_name %>
										<%= form.text_field :full_name, class:"form_control" %>
										<div class="invalid-feedback">
											Valid first name is required.
										</div>
									</div>
									<div class="col-md-6 mb-3">
										<%= form.label :mobile_number %>
										<%= form.text_field :mobile_number, class:"form_control" %>
										<div class="invalid-feedback">
											Valid last name is required.
										</div>
									</div>
								</div>
								<div class="mb-3"  style="margin-bottom: 20px;">
									<label for="email"><%= form.label :email%><span class="text-muted">(required)</span></label>
									<%= form.email_field :email, class: "form-control" %>
									<div class="invalid-feedback">
										Please enter a valid email address for shipping updates.
									</div>
								</div>
								<div class="mb-3">
									<%= form.label :Billing_address %>
									<%= form.text_field :address_2, class:"form-control" %>
									<div class="invalid-feedback">
										Please enter your shipping address.
									</div>
								</div>
								<div class="row" style="margin-bottom: 50px;">
									<div class="col-md-5 mb-3">
										<label for="country">City</label>
										<%= form.text_field :billing_city, class: "form-control" %>
									</div>
									<div class="col-md-4 mb-3">
										<label for="state">State</label>
										<%= form.text_field :billing_state, class: "form-control" %>
									</div>
									<div class="col-md-3 mb-3">
										<label for="zip">Zip</label>
										<%= form.text_field :billing_zipcode, class: "form-control" %>
									</div>	
								</div>
								<div class="mb-3">
									<%= form.label :Shipping_address %>
									<%= form.text_field :address_1, class:"form-control" %>
								</div>
								<div class="row">
									<div class="col-md-5 mb-3">
										<label for="country">City</label>
										<%= form.text_field :shipping_city, class: "form-control" %>
									</div>
									<div class="col-md-4 mb-3">
										<label for="state">State</label>
										<%= form.text_field :shipping_state, class: "form-control" %>
									</div>
									<div class="col-md-3 mb-3">
										<label for="zip">Zip</label>
										<%= form.text_field :shipping_zipcode, class: "form-control" %>
									</div>	
								</div>
								
							</div>
							<div class="payment-options" style="margin-top: 30px;">
							  <%= check_box_tag "pages[#{@user_order.id}]", true %>
								<%#= label_tag  %>
								<span>
									<label><input type="checkbox"> Direct Bank Transfer</label>
								</span>
								<span>
									<label><input type="checkbox"> Check Payment</label>
								</span>
								<span>
									<label><input type="checkbox"> Paypal</label>
								</span><br>
								<%= form.submit "Place Order", class: "btn btn-primary" %>
							</div>
						<% end %>
