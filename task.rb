require 'state_machines'

class Task
  attr_accesor: state,

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

  def initialize
    super() # Initialize the state machine
  end
end

