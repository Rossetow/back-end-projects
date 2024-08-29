$LOAD_PATH << '.'
require 'load_dummie_data.rb'
require 'todo-list.rb'

if !File.exist?("data.json")
  File.write("data.json", "")
end

puts("Load dummie data? (Y to load)")

option = gets.chomp

if option.downcase == 'y'
  load_data
end

app = Todo_list.new()

app.start_app
