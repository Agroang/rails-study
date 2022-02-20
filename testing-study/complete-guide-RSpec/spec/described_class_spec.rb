class King
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

RSpec.describe King do
  # subject { King.new('Boris') } # if we need to abstract even further to avoid
  # having to change the class's names if needed, we can use another RSpec
  # helper here called "described_class"
  # let(:luis) { King.new('Luis') }
  subject { described_class.new('Boris') } # same as above examples
  let(:luis) { described_class.new('Luis') }

  it 'represents a great person' do
    expect(subject.name).to eq('Boris')
    expect(luis.name).to eq('Luis')
  end
end
