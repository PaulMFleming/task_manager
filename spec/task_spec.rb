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
    context 'when due_date is in the past' do
      let(:due_date) { Date.today - 1 }
      
      it 'returns true' do
        expect(subject.overdue?).to be true
      end
    end

    context 'when due_date is today or in the future' do
      let(:due_date) { Date.today }

      it 'returns false' do
        expect(subject.overdue?).to be false
      end
    end

    context 'when no due date is set' do
      let(:due_date) { nil }

      it 'returns false' do
        expect(subject.overdue?).to be false
      end
    end
  end

  describe 'archive state transitions' do
    it 'transitions from completed to archived on archive' do
      subject.start
      subject.complete
      subject.archive
      expect(subject.state).to eq('archived')
    end

    it 'cannot archive a pending task' do
      expect { subject.archive }.to raise_error(StateMachines::InvalidTransition)
    end

    it 'cannot archive an inprogress task' do
      subject.start
      expect { subject.archive }.to raise_error(StateMachines::InvalidTransition)
  end
end