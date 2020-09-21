require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      return @board.winner != evaluator && @board.won?
    end
    if @next_mover_mark == evaluator 
      children.all?{|child| child.losing_node?(evaluator)}
    else 
      children.any?{|child| child.losing_node?(evaluator)}
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      return @board.winner == evaluator && @board.won?
    end
    if @next_mover_mark == evaluator 
      children.any?{|child| child.winning_node?(evaluator)}
    else 
      children.all?{|child| child.winning_node?(evaluator)}
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    moves = []
    board.rows.each_with_index do |row, idx1|
      row.each_with_index do |ele, idx2|
        pos = [idx1, idx2]
        if board.empty?(pos)
          new_board = board.dup
          new_board[pos] = @next_mover_mark
          next_mover_mark = (@next_mover_mark == :x ? :o : :x)
          moves << TicTacToeNode.new(new_board, next_mover_mark, pos)
        end  
      end
    end
    moves
  end

end
