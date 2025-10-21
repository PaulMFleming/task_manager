
require_relative '../task'
require_relative '../task_list'
require_relative '../task_processor'

Rspec.describe TaskProcessor do
  let(:task1) { Task.new(title: 'Build feature') }
  let(:task2) { Task.new(title: 'Write tests') }
  let(:list) { TaskList.new([task1, task2]) }

  subject { TaskProcessor.new(list) }

  describe '#process_all' do
    it 'starts all pending tasks and marks them as in progress' do
      subject.process_all
      expect(list.by_state('inprogress').size).to eq(2)
    end
  end

  describe '#complete_all' do
    it 'completes all in-progress tasks' do
      list.by_state('pending').each(&:start)
      subject.complete_all
      expect(list.by_state('completed').size).to eq(2)
    end
  end
end