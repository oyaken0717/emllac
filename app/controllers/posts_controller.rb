class PostsController < ApplicationController
  before_action :post_access, only: [:new]
  before_action :check_correct_post, only: [:edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :destroy, :update]

  def index
    @posts = Post.all
# ーー検索フォーム（titleで）ーーーーーーーーーーーーーーーーーーーーーーーーーー
    if params[:post].present?
      @posts = Post.search_title(params[:post][:title])
    end
    # @posts = Post.all.order(仕事の難しさレベル: :asc) if params[:仕事の難しさレベル] == "true"
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
    @comments = @post.comments
    @comment = @post.comments.build
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
    render :new if @post.invalid?
  end

  private

  def set_post
    post_optional = Post.find_by(id:params[:id])
    if post_optional
      @post = post_optional
    else
      redirect_to posts_path
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, :image, :image_cache, :group, tag_ids: [])
  end

  def check_correct_post
    if current_user != Post.find(params[:id]).user
      redirect_to posts_path
    end
  end

  def post_access
      redirect_to new_session_path unless logged_in?
  end
end
