require 'state_machines'

class TaskList
  def initialize(tasks = [])
    @tasks = tasks
  end

  def add(task)
    @tasks << task
  end

  def all
    @tasks
  end

  def overdue
    @tasks.select { |task| task.overdue? }
  end

  def complete_all_pending
    @tasks.each do |t|
      if t.state == 'pending'
        t.start
        t.complete
      end
    end
  end

  def by_state(state)
    @tasks.select { |task| task.state == state }
  end
end