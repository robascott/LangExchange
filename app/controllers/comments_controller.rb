class CommentsController < ApplicationController

  def create
    new_comment = current_user.comments.create(:text => params[:comment][:text], :note_id => params[:note_id])

    new_comment.save

    redirect_to "/users/#{current_user.id}/notes/#{params[:note_id]}"
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
