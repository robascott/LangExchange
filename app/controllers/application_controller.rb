class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ActionView::Helpers::TagHelper
  include ActionView::Context    

  
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :username, :language_id, :languages_learning) }
        devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :current_password, :language_id, :languages_learning) }
    end

  helper_method :get_languages, :get_language_name, :shorten_note, :embed_youtube, :is_youtube?

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

    def convert_time(time)
      if time.include? "m"
        time_seconds = (time.scan(/\d+/).first.to_i * 60) + (time.scan(/\d+/).first.to_i)
        return time_seconds.to_s
      else
        return time.scan(/\d+/).first
      end
    end

    def embed_youtube(youtube_url)
        regex = /^(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?([\w-]{10,})/
        youtube_id = youtube_url.match(regex)[1]

        timestamp = youtube_url.split("?t=").last
        
        if timestamp.length
          youtube_id += "?start=" + convert_time(timestamp)
        end

        content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{youtube_id}")
    end

    def is_youtube?(url)
      regex = /^(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?([\w-]{10,})/
      if url.match(regex) != nil
        return true
      else
        return false
      end
    end


end
