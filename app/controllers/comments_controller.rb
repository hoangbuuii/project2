class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy
  before_action :load_post, only: :create

  def create
    @comment = Comment.new comment_params
    @comment.post = @post
    @comment.user = current_user

    if @comment.save
      CommentMailer.comment_created(current_user, @comment).deliver
      flash[:success] = t ".comment_created"
    else
      flash[:warning] = t ".comment_cannot_be_created"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    if @comment.destroy
      flash[:success] = t ".comment_deleted"
    else
      flash[:warning] = t ".comment_cannot_be_deletes"
    end
    redirect_to request.referrer || root_url
  end

  private

  def comment_params
    params.require(:comment).permit :content
  end

  def correct_user
    @comment = current_user.comments.find_by id: params[:id]
    redirect_to root_url unless @comment
  end

  def load_post
    @post = Post.find_by id: params[:post_id]
    return if @post
    flash[:warning] = t ".cannot_find_post"
    redirect_to root_path
  end
end
