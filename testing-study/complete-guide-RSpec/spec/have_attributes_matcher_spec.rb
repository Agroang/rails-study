class Plant
  attr_reader :name, :color
  def initialize(name = 'Pepper', color = 'Red')
    @name = name
    @color = color
  end
end

RSpec.describe 'have_attributes matcher' do
  describe Plant do
    it 'checks for object attributes' do
      expect(subject).to have_attributes(name: 'Pepper')
      expect(subject).to have_attributes(name: 'Pepper', color: 'Red')
    end

    it { is_expected.to have_attributes(color: 'Red') }
  end
end
