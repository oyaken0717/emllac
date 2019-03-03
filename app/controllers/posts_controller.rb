class PostsController < ApplicationController
  before_action :post_access, only: [:new]
  before_action :access, only: [:create, :edit, :update, :destroy, :confirm]
  before_action :set_post, only: [:show, :edit, :destroy, :update]

  def index
    @posts = Post.all
  end

  def new
    if params[:back]
      @post = Post.new(post_params)
    else
      @post = Post.new
    end
  end

  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      ContactMailer.contact_mail(@post).deliver
      redirect_to posts_path, notice:"作成ができました。"
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "編集しました"
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "削除しました"
  end

  def confirm
    @post = current_user.posts.build(post_params)
    render new if @post.invalid?
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :image, :image_cache)
  end

  def post_user
    @post = Post.find(params[:id])
    @post.user
  end

  def access
    if current_user != post_user
      redirect_to new_session_path
    end
  end

  def post_access
      redirect_to new_session_path unless logged_in?
  end
end
