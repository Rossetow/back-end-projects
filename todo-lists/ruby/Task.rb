require 'json'
require 'date'

class Task
  attr_accessor :title, :description, :urgency, :due_date, :completed

  def initialize(title, description, urgency, due_date)

    formated_date = due_date.split("/")

    @title = title
    @description = description
    @urgency = urgency
    @due_date = Date.new(formated_date[2].to_i, formated_date[0].to_i, formated_date[1].to_i)
    @completed = false
  end

  def mark_complete ()
    puts ("#{@title} completed!")
    @completed = true
  end

  def edit_title ()
    puts("Renaming title from #{@title} to: ")
    @title = gets

    puts("#{@title} updated!")

  end

  def edit_description ()
    puts("Changing description from \n #{@title}  \n to: ")

    @description = gets

    puts("#{@title}'s description updated!")

  end

  def edit_description ()
    puts("Changing deadline from \n #{@due_date}  \n to: ")

    @due_date = gets

    puts("#{@title}'s deadline updated! \n")

    puts("You now have #{days_left()} days left.")

  end

  def days_left()
    current_day = Time.now().to_date()

    days_left = @due_date.yday - current_day.yday

    return days_left

  end

  def to_str ()

    puts("\n")

    puts(@title + "         " + (@completed ? "[finished]" : "[open]"))

    puts("-" * (@title.length * 2))

    puts(@description)

    puts("Due " + @due_date.strftime("%m/%d/%Y"))

    puts(days_left().to_s + " days left \n")

  end

  def to_json ()

    return {
      title: @title,
      description: @description,
      urgency: @description,
      due_date: @due_date.strftime("%m/%d/%Y"),
      completed: @completed
    }

  end

end
