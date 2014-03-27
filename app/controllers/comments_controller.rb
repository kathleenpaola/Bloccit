class CommentsController < ApplicationController
  respond_to :html, :js
 
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = current_user.comments.create(params[:comment])    

     authorize! :create, @comment, message: "You need to be signed up to do that."
    if @comment.save
      redirect_to [@topic, @post], notice: "Post was saved successfully."
    else
      flash[:error] = "Oops! There was an error saving the comment. Please try again."
      render :new
    end

  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    @comment = @post.comments.find(params[:id])

    authorize! :destroy, @comment, message: "You need to own the comment to delete it."
    
    if @comment.destroy
      flash[:notice] = "Comment was removed."
    else
      flash[:error] = "Comments couldn't be deleted. Try again."
    end
    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
  end
end
