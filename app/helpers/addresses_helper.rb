module AddressesHelper
  def set_address
    @address = current_user.addresses.select(:id,:shipping_address,:city,:state,:zipcode).last(5)
    @addr_hashs = []
    @address.each do |add|
      my_address = "#{add.shipping_address}, #{add.city}, #{add.state} - #{add.zipcode}"
      @addr_hashs << {id: add.id , address: my_address}
    end
    @addr_hashs
  end
end
