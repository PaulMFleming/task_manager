require_relative '../task'

RSpec.describe Task do
  subject { Task.new }

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
end