class CommentsController < ApplicationController

  def create
    new_comment = current_user.comments.create(:text => params[:comment][:text], :note_id => params[:note_id])

    new_comment.save

    redirect_to "/users/#{current_user.id}/notes/#{params[:note_id]}"
  end

  def destroy
    comment = Comment.find(params[:id])
    user = Note.find(params[:note_id]).user
    if user_signed_in? && user['id'] == current_user.id
      Comment.destroy(params[:id])
    end

    note = comment.note
    redirect_to note_path(note)  
  end

end
