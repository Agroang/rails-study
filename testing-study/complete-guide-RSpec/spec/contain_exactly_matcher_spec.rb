RSpec.describe 'contain_exactly matcher' do
  subject { [1, 2, 3] }

  describe 'long form syntax' do
    it 'should check for the presence of all elements' do
      expect(subject).to contain_exactly(2, 1, 3) # order doesn't matter, only
      # the elements, not the array!, it needs exactly those elements inside
      expect(subject).to contain_exactly(1, 2, 3)
      expect(subject).to contain_exactly(3, 2, 1)

      expect(subject).not_to contain_exactly(1, 2) # missing 1 element
      expect(subject).not_to contain_exactly(1, 2, 3, 4) # 1 extra element
    end
  end

  describe 'with one-liner syntax' do
    it { is_expected.to contain_exactly(1, 2, 3) }
    it { is_expected.to contain_exactly(2, 1, 3) }
    it { is_expected.to contain_exactly(3, 2, 1) }

    it { is_expected.not_to contain_exactly(1, 2, 3, 4) }
  end
end
