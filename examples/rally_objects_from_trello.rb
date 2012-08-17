require '../lib/configuration'

config = @config[:trello]

boards = Array.new
config[:boards].each do |board_id|
  boards << Trello::Board.find(board_id)
end

rally_tags = %w"#defect #story #task"
rally_project = @rally.find(:project, :workspace => @rally_workspace, :fetch => true) {equal :name, "Trelly"}.first

boards.each do |board|
  puts "entering #{board.name}"

  #create objects in rally from list names in trello
  board.lists.each do |list|
    case list.name
      when /\#defect/
      when /\#story/
        story_name = list.name.sub(/\#story\s*/,'').strip

        # a story is a hierarchical_requirement
        rally_story = @rally.find(:hierarchical_requirement, :workspace => @rally_workspace, :project => rally_project) {equal :name, story_name}.first

        # create the story in rally if it does not exist, but remove the tag.
        @rally.create(:hierarchical_requirement, :workspace => @rally_workspace, :project => rally_project, :name => story_name) unless rally_story
      when /\#task/
        rally_task = @rally.find(:task, :workspace => @rally_workspace, :project => rally_project) {equal :name, list.name.sub(/\#task\s*/,'').strip}.first
        @rally.create(:task, :workspace => @rally_workspace, :project => rally_project, :name => list.name.sub(/\#task\s*/,'').strip) unless rally_task
      else
        #do nothing
    end

    if rally_tags.any? {|t| list.name[t]}
      puts list.name
    end
  end
end