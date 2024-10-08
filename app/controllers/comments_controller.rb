class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :comment_author, only: [ :destroy ]

  def comment_author
    @comment = Comment.find(params[:id])
    unless @comment.user == current_user
      flash[:alert] = "You can only delete your own comments."
      redirect_to root_path
    end
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end
end
