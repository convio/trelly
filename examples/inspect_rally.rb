require '../lib/configuration'

puts "Using user: #{rally.user.login_name}"
@rally.user.subscription.workspaces.each do |workspace|
  puts workspace.name
  projects = workspace.projects
  #projects = rally.find_all(:project, :workspace => workspace, :pagesize => 100, :fetch => true)
  projects.each do |project|
    puts "  #{project}  #{project.description}"
    iterations = project.iterations
    puts "    iterations:  #{iterations}" if iterations

    releases = project.releases
    puts "    releases:    #{releases}" if releases

    team_members = project.team_members
    puts "    teammembers: #{team_members}" if team_members
  end
  #stories  = rally.find_all(:user_story, :workspace => workspace, :pagesize => 100, :fetch => true)
end

#rally.user.subscription.workspaces.each do |workspace|
#  puts workspace
#
#
#  workspace.projects.each do |project|
#    puts "  #{project}"
#    puts "  children: #{project.children}" if project.children
#    #
#    #project.iterations.each do |iteration|
#    #  puts "    #{iteration.name}"
#    #end if project.iterations
#  end if workspace.projects
#end