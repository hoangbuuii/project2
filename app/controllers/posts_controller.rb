class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search]
      @posts = Post.search(params[:search]).order_by_created_at_desc
        .paginate page: params[:page], per_page: Settings.per_page
    else
      @posts = Post.all.order_by_created_at_desc
        .paginate page: params[:page], per_page: Settings.per_page
    end
  end

  def show
    @comment = @post.comments.build(params[:comment])
    @comments = @post.comments.order_by_created_at_desc
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @user = current_user
    @post = @user.posts.new(post_params)
    respond_to do |format|
      if @post.save
        PostMailer.post_created(@post).deliver
        format.html {redirect_to @post, notice:  t(".post_was_successfully_created")}
        format.json {render :show, status: :created, location: @post}
      else
        format.html {render :new}
        format.json {render json: @post.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html {redirect_to @post, notice: t(".post_was_successfully_updated")}
        format.json {render :show, status: :ok, location: @post}
      else
        format.html {render :edit}
        format.json {render json: @post.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html {redirect_to posts_url, notice: t(".post_was_successfully_destroyed")}
      format.json {head :no_content}
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :user_id)
    end
end
