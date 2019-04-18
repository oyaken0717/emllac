class CommentsController < ApplicationController
  def create
    @post = Post.new(comment_params)
    @comment = @post.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.js { render :index }
      else
        format.html { render :new }
        format.js { render :index }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :content)
  end
end
