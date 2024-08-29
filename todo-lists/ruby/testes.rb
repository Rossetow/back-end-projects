# # require 'json'
require 'date'
# # require 'time'
# #
# $LOAD_PATH << '.'



# require 'Storage'
# require 'TaskList'
# require 'Task'

# tasks = [
#   Task.new("Finish report", "Complete the quarterly report for review.", "High", "08/30/2024"),
#   Task.new("Buy groceries", "Purchase vegetables, fruits, and dairy products.", "Medium", "09/02/2024"),
#   Task.new("Call plumber", "Schedule an appointment for fixing the sink.", "Low", "09/05/2024"),
#   Task.new("Book flight", "Book a flight for the upcoming conference.", "High", "09/10/2024")
# ]


# taskList = TaskList.new()


# tasks.each do |task|
#   taskList.add_task(task)
# end

# taskList.list_tasks()

# storage = Storage.new()

# storage.save taskList

# taskList2 = storage.load

# taskList2.list_tasks


def validate_date(string)
  format_ok = string.match(/\d{2}-\d{2}-\d{4}/)

  print(format_ok)
  parseable = Date.strptime(string, '%m-%d-%Y') rescue false

  print(parseable)

  if format_ok && parseable
    return true
  else
    return false
  end
end



puts(date_valid?("10-29-2024"))
