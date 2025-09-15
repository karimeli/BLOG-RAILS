class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [ :edit, :update, :destroy ]
  before_action :authorize_comment, only: [ :edit, :update, :destroy ]

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    if @comment.save
      redirect_to @post, notice: "Comment was successfully created."
    else
      render "posts/show"
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @post, notice: "Comment was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @post, notice: "Comment was successfully destroyed."
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def authorize_comment
    redirect_to @post, alert: "Not authorized" unless @comment.user == current_user
  end
end
