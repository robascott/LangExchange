class HomeController < ApplicationController
  def index
  	@notes = Note.all.order(:created_at).reverse_order
  end
end
