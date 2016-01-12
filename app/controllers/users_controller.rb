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
end
