require 'pry'
require 'pry-byebug'
require 'date'
require_relative '../task'

RSpec.describe Task do
  let(:title) { 'Test Task' }
  let(:description) { 'A test task' }
  let(:due_date) { Date.today - 1 }

  subject { Task.new(
    title: title,
    description: description,
    due_date: due_date
  ) }

  it 'has initial state pending' do
    expect(subject.state).to eq('pending')
  end

  it 'transitions from pending to inprogress on start' do
    subject.start
    expect(subject.state).to eq('inprogress')
  end

  it 'transitions from inprogress to completed on complete' do
    subject.start
    subject.complete
    expect(subject.state).to eq('completed')
  end

  it 'transitions from completed to archived on archive' do
    subject.start
    subject.complete
    subject.archive
    expect(subject.state).to eq('archived')
  end

  describe 'attributes' do
   it 'has a title' do
     expect(subject.title).to eq('Test Task')
   end

    it 'has a description' do
      expect(subject.description).to eq('A test task')
    end

    it 'has a due date' do
      expect(subject.due_date).to eq(Date.today - 1)
    end
  end

  describe '#overdue?' do
    it 'returns true if current task is after due date' do
      expect(subject.overdue?).to be true
    end

    it 'returns false if current task is before or on due date' do
      subject.due_date = Date.today + 1
      expect(subject.overdue?).to be false

      subject.due_date = Date.today
      expect(subject.overdue?).to be false
    end

    it 'returns false if no due date is set' do
      subject.due_date = nil
      expect(subject.overdue?).to be false  
    end
  end
end