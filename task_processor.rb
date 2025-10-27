require 'state_machines'

class TaskProcessor
  attr_accessor :list, :tasks

  def initialize(list)
    @list = list
    @tasks = list.all
  end

  def process_all
    @tasks.each do |task|
      task.start
    end
  end

  # def complete_all

  # end
end