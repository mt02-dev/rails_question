class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      flash[:notice] = 'コメントを投稿しました'
      # comment.boardでリダイレクトできるのは、belongs_toのアソシエーションを設定したから
      # これにより、borad_idに紐づくcommentを自動的に取得してくれる
      redirect_to comment.board
    else
      redirect_back fallback_location: comment.board
      flash[:comment] = comment
      flash[:error_messages] = comment.errors.full_messages
      
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to comment.board, flash: { notice: 'コメントが削除されました。'} 
  end

  private
  def comment_params
    params.require(:comment).permit(:board_id, :name, :comment)
  end
end
