require 'lib/configuration'
require 'trello'

class Trelly
  def initialize(options={})
    board_ids = @config[:trello][:boards].merge(options[:boards])
    load_boards(board_ids)
    @delete_on_tag_removal = @config[:delete_on_tag_removal].merge(options[:delete_on_tag_removal])
  end

  def load_boards(board_ids)
    @boards ||= Array.new
    board_ids.each do |board_id|
      @boards << Trello::Board.find(board_id)
    end
  end

  def update_rally()
    @boards.each do |board|

    end
  end
end

trelly = Trelly.new()
trelly.update_rally()
trelly.update_trello()