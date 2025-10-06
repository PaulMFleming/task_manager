require 'date'
require 'pry-byebug'
require_relative '../task'
require_relative '../task_list'

RSpec.describe TaskList do
  let(:task1) { Task.new(title: 'Task 1', due_date: (Date.today - 1))}
  let(:task2) { Task.new(title: 'Task 2', due_date: (Date.today + 1))}
  let(:task3) { Task.new(title: 'Task 3', due_date: nil)}
  subject { TaskList.new([task1, task2, task3]) }

  it 'returns all tasks' do
    expect(subject.all).to eq([task1, task2, task3])
    expect(subject.all.size).to eq(3)
  end

  it 'returns all tasks' do
    expect(subject.all).to eq([task1, task2, task3])
    expect(subject.all.size).to eq(3)
  end

  it 'adds a new task' do
    new_task = Task.new(title: 'Task 4')
    subject.add(new_task)
    expect(subject.all.size).to eq(4)
    expect(subject.all).to include(new_task)
  end

  it 'returns overdue tasks' do
    expect(subject.overdue).to eq([task1])
  end

  describe '#complete_all_pending' do
    it 'completes all pending tasks' do
      #binding.pry
      subject.complete_all_pending
      
      expect(subject.all.select { 
        |t| t.state == 'completed' }
        .size).to be > 0
    end
  end

  # describe '#by_state' do
  #   it 'returns tasks in a specific state' do
  #     task = Task.new(title: 'To Do')
  #     subject.add(task)
  #     expect(subject.by_state('pending').to include(task))
  #   end
  # end
end