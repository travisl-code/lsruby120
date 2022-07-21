require 'pry'

class TaskManager
  attr_reader :owner
  attr_accessor :tasks

  def initialize(owner)
    @owner = owner
    @tasks = []
  end

  def add_task(name, priority=:normal)
    task = Task.new(name, priority)
    tasks.push(task)
  end

  def complete_task(task_name)
    completed_task = nil

    tasks.each do |task|
      completed_task = task if task.name == task_name
    end

    if completed_task
      tasks.delete(completed_task)
      puts "Task '#{completed_task.name}' complete! Removed from list."
    else
      puts "Task not found."
    end
  end

  def display_all_tasks
    display(tasks)
  end

  def display_high_priority_tasks
    high_tasks = tasks.select do |task|
      task.priority == :high
    end

    display(high_tasks)
  end

  private

  def display(tasks)
    puts "--------"
    tasks.each do |task|
      puts task
    end
    puts "--------"
  end
end

class Task
  attr_accessor :name, :priority

  def initialize(name, priority=:normal)
    @name = name
    @priority = priority
  end

  def to_s
    "[" + sprintf("%-6s", priority) + "] #{name}"
  end
end

valentinas_tasks = TaskManager.new('Valentina')

valentinas_tasks.add_task('pay bills', :high)
valentinas_tasks.add_task('read OOP book')
valentinas_tasks.add_task('practice Ruby')
valentinas_tasks.add_task('run 5k', :low)

valentinas_tasks.complete_task('read OOP book')

valentinas_tasks.display_all_tasks
valentinas_tasks.display_high_priority_tasks

=begin
Error raised. Find bug and fix.

Error message was "private method `select' called for nil". I'm honestly not too sure why `tasks` is returning nil in this example. I would have assumed it would create a local variable `tasks` and assign it to the return of the getter `tasks`, which has `select` called on it. However, that doesn't seem to be the case, but when I modified the local variable name from `tasks` to `high_tasks`, the program executed as expected.

Ruby has to do some disambiguation work. When we first invoke `task = `, it knows its not a setter because that would be `self.tasks = `, so it initializes a local variable `tasks` with nothing assigned to it yet (`nil`). Then, on the right of the `=` operator, Ruby invokes `tasks.select`, but it chooses to do so on the local variable we just initialized, not the `tasks` getter method. This is variable shadowing at play.
=end
