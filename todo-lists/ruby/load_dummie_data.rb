def load_data
  tasks = [
  Task.new("Finish report", "Complete the quarterly report for review.", "08/30/2024"),
  Task.new("Buy groceries", "Purchase vegetables, fruits, and dairy products.", "09/02/2024"),
  Task.new("Call plumber", "Schedule an appointment for fixing the sink.", "09/05/2024"),
  Task.new("Book flight", "Book a flight for the upcoming conference.", "09/10/2024")
  ]


  taskList = TaskList.new()


  tasks.each do |task|
    taskList.add_task(task)
  end

  taskList.list_tasks()

  storage = Storage.new()

  storage.save taskList

end
