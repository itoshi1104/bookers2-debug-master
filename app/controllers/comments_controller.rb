class CommentsController < ApplicationController
    before_action :correct_user, only: [:destroy]

  def create
    book = Book.find(params[:article_id])
    comment = Comment.new(comment_params)
    comment.article_id = article.id
    comment.user_id = current_user.id
    @book = comment.book
    if comment.save
    @book.create_notification_comment!(current_user, comment.id)
      redirect_back(fallback_location: root_path) 
    else
      render 'books/show'
    end
  end

  def destroy
    comment = Comment.find(params[:article_id])
    comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def correct_user
    comment = Comment.find(params[:article_id])
    redirect_to book_path if current_user.id != comment.user_id
  end
end
