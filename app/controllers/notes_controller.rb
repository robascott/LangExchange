class NotesController < ApplicationController
  def index
  end

  def show
    @note = Note.find(params[:id])
    @user = User.find(@note['user_id'])

    if @note['private'] != true || (user_signed_in? && @user['id'] == current_user.id)
      @language = Language.find(@note['language_id'])
      if is_youtube?(@note['source'])
        @youtube = true
      else
        @youtube = false
      end
      @comment = Comment.new
      @comments = @note.comments.order(:created_at).reverse_order
    else
      redirect_to "/"
    end

  end

  def new
    @note = Note.new
    @user = current_user
    @method = "post"
    @route = notes_path
  end

  def create
    new_note = current_user.notes.create(note_params)
    new_note.save

    redirect_to "/users/#{current_user.id}"
  end

  def edit
    @note = Note.find(params[:id])
    @user = @note.user

    if user_signed_in? && @user['id'] == current_user.id
      @method = "put"
      @route = note_path
    else
      redirect_to "/"
    end    
  end

  def update
    note = Note.find(params[:id])
    
    if params[:private] == nil
      note.private = nil
    end
    
    if params[:question] == nil
      note.question = nil
    end
    
    note.update(note_params)

    redirect_to note_path
  end

  def destroy
    user = Note.find(params[:id]).user
    if user_signed_in? && user['id'] == current_user.id
      Note.destroy(params[:id])
      redirect_to user_path(current_user)
    else
      redirect_to "/"
    end
  end

  def note_params
    params.require(:note).permit( :title, :language_id, :body, :source, :question, :private )
  end
end
