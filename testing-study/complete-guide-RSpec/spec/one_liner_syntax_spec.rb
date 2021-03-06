RSpec.describe 'shorthand syntax' do
  subject { 5 } #must have a subject to be able to use the one-line syntax

  context 'with classic syntax' do
    it 'equals to 5' do
      expect(subject).to eq(5)
    end
  end

  context 'with one-line syntax' do
    it { is_expected.to eq(5) } # string is autogenerated, and targets a
    # subject, that's why a subject must be present to use this syntax
  end

  #both examples are the same in the end
end
