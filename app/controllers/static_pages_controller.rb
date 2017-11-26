class StaticPagesController < ApplicationController
  def home
    @posts = Post.order_by_created_at_desc.paginate page: 
    params[:page], per_page: Settings.per_page
    return unless user_signed_in?
      @feed_items = current_user.feed.order_by_created_at_desc
        .paginate page: params[:page], per_page: Settings.per_page
  end

  def help; end
end
