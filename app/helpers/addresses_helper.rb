module AddressesHelper
  def set_address
    # binding.pry
    # @address = @admin.addresses.recent(10)
    @address = current_user.addresses.recent(5)
    # @address = current_user.addresses.select(:id,:shipping_address,:city,:state,:zipcode).last(5)
    addr_hash = []
    @address.each do |add|
      my_address = "#{add.shipping_address}, #{add.city}, #{add.state} - #{add.zipcode}"
      addr_hash << {id: add.id , address: my_address}
    end
    addr_hash
  end
end
