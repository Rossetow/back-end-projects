$LOAD_PATH << '.'

require 'json'
require 'Task'

class TaskList

  attr_accessor :tasks

  def initialize()
    @tasks = []
    @finished_tasks = []
    @open_tasks = []
  end


  def add_task (task)

    @tasks.push(task)

    puts("Task added successfully")

  end

  def remove_task (task)

    @tasks.delete(task)

  end

  def list_tasks ()


    @tasks.each_with_index do |task, index|
      task.to_str
    end

  end

  def find_task_by_id (id)

    if id > 0 && id < @tasks.length

      return @tasks[id-1]

    else

      puts("Invalid ID")
      return

    end

  end

  def task_details (id)

    task_detail = find_task_by_id(id)

    task_detail.to_str()

  end

  def to_json

    json_tasks = []

    @tasks.each do |task|
      json_tasks.push(task.to_json)
    end

    {'tasks' => json_tasks}.to_json
  end

  def update_tasks_status()

    @tasks.each do |task|

      if task.completed
        @finished_tasks.push(task)

      else
        @open_tasks.push(task)

      end

    end

  end

end
