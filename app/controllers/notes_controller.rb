class NotesController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:user_id])
    @note = Note.find(params[:id])
    @language = Language.find(@note['language_id'])
    @comment = Comment.new
    @comments = @note.comments
  end

  def new
    @note = Note.new
    @user = current_user
  end

  def create
    new_note = current_user.notes.create(note_params)
    new_note.save

    redirect_to "/users/#{current_user.id}"
  end

  def edit
    @note = Note.find(params[:id])
    @user = current_user
  end

  def update
  end

  def destroy
    Note.destroy(params[:id])
    redirect_to "/users/#{params[:user_id]}"
  end

  def note_params
    params.require(:note).permit( :title, :language_id, :body, :source, :question, :user_id)
  end
end
