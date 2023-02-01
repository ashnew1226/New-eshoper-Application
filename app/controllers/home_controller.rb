class HomeController < ApplicationController
  before_action :authenticate_user!
    def index
      @banners = BannerManagement.all
      @products = Product.all.limit(6)
      @category = Category.where(parent_id: nil)
      @cms = ContentManagementSystem.last
    end
end
