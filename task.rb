require 'state_machines'

class Task
  attr_accessor :state, :title, :description, :due_date, :started_at, :completed_at, :archived_at

  state_machine :state, initial: :pending do
    after_transition pending: :inprogress, do: :set_started_at
    after_transition inprogress: :completed, do: :set_completed_at
    after_transition completed: :archived, do: :set_archived_at

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
    @started_at = nil
    @completed_at = nil
    @archived_at = nil
    super() # Initialize the state machine
  end

  def set_started_at
    @started_at = Time.now
  end

  def set_completed_at
    @completed_at = Time.now
  end

  def set_archived_at
    @archived_at = Time.now
  end
end

