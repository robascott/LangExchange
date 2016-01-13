class UsersController < ApplicationController
  def index
  end

  def show
  	@user = User.find(params[:id])
  	@notes = @user.notes.order(:created_at).reverse_order
  end


  def preferences
  	@user = current_user
  end


  def list_users
  	@users = User.all

  	languages = get_languages

  	languages.each do |language|
  	  string = "Language.create(name: '#{language.name}', code: '#{language.iso_639_1}')"
  	  puts string
  	end
  end


  def set_preferences

  	language_ids = params[:user][:language_ids]

  	language_ids.each do |id|
  		new_learning = Learning.new(user_id: params[:user_id], language_id: id)
  		new_learning.save
  	end

  	redirect_to "/"
  end
end
