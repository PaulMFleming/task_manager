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
    #binding.pry
    expect(subject.overdue).to eq([task1])
  end
end