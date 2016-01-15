class HomeController < ApplicationController
  def questions
  	if user_signed_in?
  		@languages = current_user.languages
  	else
  		@languages = Language.all
  	end
    if user_signed_in?
      @notes = Note.where(question: true, language_id: current_user['language_id']).order(:created_at).reverse_order
    else
      @path = "/questions"  
      @q = Note.ransack(params[:q])
      @notes = @q.result.where(question: true).order(:created_at).reverse_order
    end
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
