class HomeController < ApplicationController
  def questions
  	if user_signed_in?
  		@languages = current_user.languages
  	else
  		@languages = Language.all
  	end
  	@path = "/questions"
  	@q = Note.ransack(params[:q])
  	@notes = @q.result.where(question: true).order(:created_at).reverse_order
  end

  def new
  	if user_signed_in?
  		@languages = current_user.languages
  	else
  		@languages = Language.all
  	end
  	@path = "/new" 	
  	@q = Note.ransack(params[:q])
  	@notes = @q.result.where(private: nil).order(:created_at).reverse_order
  end

  def search
  	@path = "/search"
  	@q = User.ransack(params[:q])
  	@notes = @q.result.where(private: nil).order(:created_at).reverse_order
  end

end
