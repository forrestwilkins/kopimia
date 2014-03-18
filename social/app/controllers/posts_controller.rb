class PostsController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comment = Comment.new
  end
  
  def create
    @user = User.find(current_user.id)
    @post = @user.posts.create(params[:post].permit(:text))
    redirect_to user_path(@user)
  end

  def destroy
    @user = User.find(current_user.id)
    @post = @user.posts.find(params[:id])
    @post.destroy
    redirect_to user_path(@user)
  end
  
  def like
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @post.like!
    redirect_to user_path(@user)
  end
end
