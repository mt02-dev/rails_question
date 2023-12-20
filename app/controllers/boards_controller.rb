class BoardsController < ApplicationController

  def index 
    @boards = Board.all
  end

  def new
    @board = Board.new
  end
  
  def show 
    @board = Board.find(params[:id])
    binding.pry
  end
  
  def create
    board = Board.create(board_params)
    redirect_to board
  end 

  def edit
    @board = Board.find(params[:id])
  end

  def update
    board = Board.find(params[:id])
    board.update(board_params)

    redirect_to board
  end

  def destroy
    board = Board.find(params[:id])
    board.delete
    binding.pry

    redirect_to boards_path, status: :see_other
  end
  private

  def board_params
    params.require(:board).permit(:author_name, :title, :body)
  end
end
