class CommentsController < ApplicationController
 
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

end
