class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :username, :language_id, :languages_learning) }
        devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :current_password, :language_id, :languages_learning) }
    end

  helper_method :get_languages, :get_language_name, :shorten_note

    def get_languages
      languages = LanguageList::COMMON_LANGUAGES
      languages.sort!
      return languages
    end

    def get_language_name(id)
      language = Language.find(id)
      return language.name
    end

    def shorten_note(text)
      new_text = text[0,300]
      if new_text.length < text.length
        new_text = new_text + "…"
      end
      return new_text
    end


end
