require 'state_machines'

class TaskList
  def initialize(tasks = [])
    @tasks = tasks
  end
  
  def all
    @tasks
  end

  def add(task)
    @tasks << task
  end

  def overdue
    @tasks.select { |task| task.overdue? }
  end
end