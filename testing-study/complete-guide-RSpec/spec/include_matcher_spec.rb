RSpec.describe 'include_matcher' do
  describe 'chilli pepper plant!' do
    it 'checks for substring inclusion' do
      expect(subject).to include('chi')
      expect(subject).to include('plant')
      expect(subject).to include('pe')

      expect(subject).not_to include('hot')
    end

    it { is_expected.to include('pper') }
  end

  describe [1, 2, 3] do
    it 'checks for inclusion in the array, regardless of order' do
      expect(subject).to include(1)
      expect(subject).to include(1, 2)
      expect(subject).to include(3, 2)

      expect(subject).not_to include(4)
    end

    it { is_expected.to include(2) }
    it { is_expected.not_to include(4) }
  end

  describe ({ a: 1, b: 3 }) do # we put the hash in parenthesis or RSpec might
  # recognize the curly braces as a block
    it 'can check for key existence' do
      expect(subject).to include(:a)
      expect(subject).to include(:a, :b)
    end

    it 'can check for key-value pair' do
      expect(subject).to include(b: 3)
      expect(subject).to include(b: 3, a: 1)
    end

    it { is_expected.to include(a: 1) }
    it { is_expected.not_to include(:c) }
  end
end
