class UsersController < ApplicationController
  def index
  	@users = User.all

  	languages = get_languages

  	languages.each do |language|
  	  string = "Language.create(name: '#{language.name}', code: '#{language.iso_639_1}')"
  	  puts string
  	end

  end

  def show
  end


  def preferences
  	@user = current_user
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
