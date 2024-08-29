require 'json'

class Storage

  def save(taskList)

    task_json = taskList.to_json

    File.open("data.json", "w") do |file|
      file.write(task_json)
    end

  end

  def load()

    file_json = File.read('data.json')

    taskList = TaskList.new()

    if file_json == ''
      return taskList
    end

    file_json = JSON.parse(file_json)



    file_json["tasks"].each do |task|

      task_obj = Task.new(
        task["title"],
        task["description"],
        task["urgency"],
        task["due_date"]
      )

      taskList.add_task task_obj

    end

    return taskList

  end

end
