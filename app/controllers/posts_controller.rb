class PostsController < ApplicationController
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
  end

  def create
    @post = Post.new(post_params)
    if @post.save
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
    @post = Post.new(post_params)
    render new if @post.invalid?
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :image, :image_cache)
  end

end
