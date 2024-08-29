$LOAD_PATH << '.'



require 'Storage'
require 'TaskList'
require 'Task'
require 'date'

class Todo_list

  def initializer()
    start_app
  end

  def start_app
    @storage = Storage.new()

    @task_list = @storage.load

    system "clear"
    system "cls"

    if @task_list.tasks.length > 0
      puts <<-'EOF'
__          __  _                            _                _    _
\ \        / / | |                          | |              | |  | |
 \ \  /\  / /__| | ___ ___  _ __ ___   ___  | |__   __ _  ___| | _| |
  \ \/  \/ / _ \ |/ __/ _ \| '_ ` _ \ / _ \ | '_ \ / _` |/ __| |/ / |
   \  /\  /  __/ | (_| (_) | | | | | |  __/ | |_) | (_| | (__|   <|_|
    \/  \/ \___|_|\___\___/|_| |_| |_|\___| |_.__/ \__,_|\___|_|\_(_)
EOF

      puts("Load previous data? (Y/N)")

      load_data = gets

      if load_data.downcase == "n"
        task_list = []
      end

    else

      puts <<-'EOF'
      __          __  _                          _
      \ \        / / | |                        | |
       \ \  /\  / /__| | ___ ___  _ __ ___   ___| |
        \ \/  \/ / _ \ |/ __/ _ \| '_ ` _ \ / _ \ |
         \  /\  /  __/ | (_| (_) | | | | | |  __/_|
          \/  \/ \___|_|\___\___/|_| |_| |_|\___(_)
EOF
      sleep(0.6)



  end
      run_app

  end

  def run_app ()

    system "clear"
    system "cls"

    puts <<-'EOF'
  _______        _         _ _     _
 |__   __|      | |       | (_)   | |  _
    | | ___   __| | ___   | |_ ___| |_(_)
    | |/ _ \ / _` |/ _ \  | | / __| __|
    | | (_) | (_| | (_) | | | \__ \ |_ _
    |_|\___/ \__,_|\___/  |_|_|___/\__(_)
EOF
    sleep(0.5)
    puts("(A) Add task - (S) Save - (Q) Quit")
    main_menu_render

    puts("\n Select a task or use a command: ")

    option = gets.chomp

    if !is_int option
      option = option.downcase
      case option

      when "a"
        return render_add_task

      when "s"
        @storage.save(@task_list)
        puts("Saving...")
        sleep(1.2)
        puts("Saved!")
        sleep(0.4)

      when "q"
        return quit_render

      else
        puts("Invalid option")
        sleep(1)
        return run_app
      end

    else
      option = option.to_i

      if option.to_i < 1 || option.to_i > @task_list.tasks.length

        puts("This task does not exist")
        sleep(1)
        return run_app

      else

        return render_one_task(@task_list.find_task_by_id(option.to_i), option.to_i)

      end

    end

    return

  end

  def main_menu_render ()

    if @task_list.tasks.length == 0

      puts("You don't have any tasks")

    else

      puts("Your tasks: ")

      @task_list.list_tasks

    end

  end

  def render_one_task (task, id)

    system "clear"
    system "cls"

    puts("(C) Complete task - (U) Update task information - (D) Delete task - (Q) Cancel")

    task.to_str

    option = gets.chomp

    if is_int option
      puts("Invalid input")

    else
      option = option.downcase

      case option

        when "c"
          task.mark_complete
          @task_list.update_tasks_status
          puts("Task completed!")
          sleep(1.5)
          return run_app

        when 'u'
          return update_render(task, id)

        when 'd'
          return render_delete(task, id)

        when 'q'
          return run_app

        else
          puts("Invalid option")
          sleep(0.6)
          return render_one_task task, id
        end
    end

  end

  def update_render task, id

    system "clear"
    system "cls"

    puts("(1) Update title - (2) Update description - (3) Update deadline - (C) Cancel")

    task.to_str
    option = gets.chomp

    if !is_int option

      if option.downcase == "c"
        return render_one_task task, id
      end

      puts("Invalid option")
      return update_render(task, id)

    else

      option = option.to_i

      case option

      when 1
        puts("New title: ")
        task.title = gets.chomp

      when 2
        puts("New description: ")
        task.description = gets.chomp

      when 3
        puts("New deadline: ")

        puts("Date in mm/dd/yyyy format")

        new_date = gets.chomp

        if date_valid?(new_date)

          formated_date = due_date.split("/")

          task.due_date = Date.new(formated_date[2].to_i, formated_date[0].to_i, formated_date[1].to_i)

        else
          puts("Invalid date format!")
          sleep(0.5)
          return update_render task, id
        end

      else
        print("Invalid input")
        sleep(0.5)

        return update_render task, id
      end

    end
    return update_render(task, id)
  end

  def render_add_task ()
    system "clear"
    system "cls"

    puts("Creating task...")

    puts("\n\nTitle: ")
    title = gets.chomp

    puts("\nDescription: ")
    description = gets.chomp


    puts("\nDeadline: ")
    puts("Date in mm/dd/yyyy format")
    new_date = gets.chomp

        if !date_valid?(new_date)
          puts("Invalid date format!")
          sleep(0.5)
          return update_render task, id
        end

    task_create = Task.new(title, description, new_date)

    puts("\n\n")

    task_create.to_str


    puts("\n\n(S) Save new task - (C) Cancel - (R) Remake task")
    option = gets.chomp

    if is_int option
      puts("Invalid option!")
      sleep(0.5)
      return render_add_task

    else
      option = option.downcase

      case option

      when "s"
        @task_list.add_task(task_create)
        sleep(0.4)
        return run_app

      when "c"
        puts("Canceling...")
        sleep(0.5)
        return run_app

      when "r"
        sleep(0.3)
        return render_add_task

      else
        puts("Invalid option!")
        sleep(0.4)
        return render_add_task
      end



    end

  end

  def render_delete(task, id)

    system "clear"
    system "cls"

    puts("Are you sure you want to delete this task?(Y/N)\n\n")

    task.to_str

    option = gets.chomp

    if is_int option
      puts("Invalid option!")
      sleep(0.5)
      return render_delete(task, id)

    else
      option = option.downcase

      case option
      when "y"
        puts("Ok, deleting task")
        sleep(0.5)
        @task_list.remove_task task
        return run_app

      when "n"
        puts("Ok, canceling")
        sleep(0.5)
        return render_one_task(task, id)

      else

        puts("Invalid option")
        sleep(0.5)
        return render_delete(task, id)

      end


    end


  end


  def quit_render()

    system "clear"
    system "cls"


    puts("(C) Cancel")

    puts("Would you like to save before quitting? (Y/N)")

    option = gets.chomp

    if is_int(option)
      puts("Invalid option")
      sleep(0.5)
      return quit_render
    end

    option = option.downcase

    case option
      when 'y'
        @storage.save(@task_list)

      when 'n'

      when 'c'
        return run_app

      else
        puts("Invalid option")
        sleep(0.5)
        return quit_render
    end

    puts <<-'EOF'

     _____ _           _
    / ____| |         (_)
   | |    | | ___  ___ _ _ __   __ _
   | |    | |/ _ \/ __| | '_ \ / _` |
   | |____| | (_) \__ \ | | | | (_| |_ _ _
    \_____|_|\___/|___/_|_| |_|\__, (_|_|_)
                                __/ |
                               |___/

  EOF

  sleep(1)

  puts <<-'EOF'
  ____             _
 |  _ \           | |
 | |_) |_   _  ___| |
 |  _ <| | | |/ _ \ |
 | |_) | |_| |  __/_|
 |____/ \__, |\___(_)
         __/ |
        |___/
EOF


  end


  def date_valid?(date)
    format = '%m/%d/%Y'
    date = Date.strptime(date, format) rescue false

    if date
      return true
    end

    return false

  end

  def chek_if_command(s)
    if s.downcase == "m" || s.downcase == "s" || s.downcase == "q"
      return true
    end

    return false
  end

  def is_int i
    return Integer(i) rescue false

  end
end
