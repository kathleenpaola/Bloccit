class FavoritesController < ApplicationController
end

def create
  @topic = Topic.find(params[:topic_id])
  @post = @topic.posts.find(params[:post_id])

  favorite = current_user.favorites.create(post: @post)
  if favorite.valid?
    flash[:notice] = "Favorited post"
    redirect_to [@topic, @post]
  else
    flash[:error] = "Unable to add favorite. Please try again."
    redirect_to [@topic, @post]
  end
end

