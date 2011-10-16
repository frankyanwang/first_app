class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(params[:comment])
    if @comment.save
      flash[:notice] = "Your comment has been saved."
      #temporary redirect to itself. Need to make it an ajax or REST API call.
      redirect_to request.referer
    else
      flash[:error] = "unable to save comments."
      redirect_to request.referer end    
  end
  
  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    flash[:error] = "Your comment is removed."
    redirect_to request.referer  
  end

end
