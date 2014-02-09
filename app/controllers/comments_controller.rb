class CommentsController < ApplicationController
 
  def create
    @comment = current_user.comments.create(params[:post])    
  end

end
