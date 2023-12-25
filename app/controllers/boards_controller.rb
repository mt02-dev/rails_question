class BoardsController < ApplicationController

  before_action :set_target_board, only: %i[show edit update destroy]
  def index 
    @boards = Board.page(params[:page])
  end

  def new
    @board = Board.new(flash[:board])
  end
  
  def show 
  
  end
  
  def create
    
    board = Board.new(board_params)
    if board.save
      flash[:notice] = "「#{board.title}」の掲示板を作成しました。"
      redirect_to board
    else
      redirect_to new_board_path, flash: {
        board: board,
        error_messages: board.errors.full_messages
      }
    end
  end 

  def edit
  
  end

  def update
    @board.update(board_params)

    redirect_to @board
  end

  def destroy
    @board.delete

    redirect_to boards_path, status: :see_other, flash: { notice: "#{@board.title}を削除しました。"}
  end
  private

  def board_params
    params.require(:board).permit(:author_name, :title, :body)
  end

  def set_target_board
    @board = Board.find(params[:id])
  end
end
