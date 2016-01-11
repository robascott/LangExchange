class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :username, :native_language, :languages_learning) }
        devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :current_password, :native_language, :languages_learning) }
    end

  helper_method :get_languages_options_array, :get_languages

    def get_languages
      languages = LanguageList::COMMON_LANGUAGES
      languages.sort!
      return languages
    end

    def get_languages_options_array
      languages = LanguageList::COMMON_LANGUAGES
      languages.sort!

      # binding.pry

      languages_array = []

      languages.each do |language|
        languages_array.push([language.name,language.iso_639_1])
      end

      return languages_array
    end

end
