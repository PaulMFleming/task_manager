require 'pry'
require 'pry-byebug'
require 'date'
require_relative '../task'

RSpec.describe Task do
  subject { Task.new(
    title: 'Test Task', 
    description: 'A test task', 
    due_date: Date.today - 1
    ) 
  }

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
  end
end