require 'state_machines'

class Task
  attr_accessor :state, :title, :description, :due_date

  state_machine :state, initial: :pending do
    event :start do
      transition pending: :inprogress
    end

    event :complete do
      transition inprogress: :completed
    end

    event :archive do
      transition completed: :archived
    end
  end

  def overdue?
    return false if due_date.nil?
    due_date < Date.today
  end

  def initialize(title: nil, description: nil, due_date: nil)
    @title = title
    @description = description
    @due_date = due_date
    super() # Initialize the state machine
  end
end

