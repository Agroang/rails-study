RSpec.describe 'start_with and end_with matchers' do
  describe "Peter" do
    it 'checks for substring at the beginning or end' do
      expect(subject).to start_with("Pe")
      expect(subject).to end_with("er")

      expect(subject).not_to start_with("pe")
    end

    it { is_expected.to start_with('P') }
    it { is_expected.to end_with('r') }

    it { is_expected.not_to start_with('p') }
  end

  describe [1, 2, 3, 4] do
    it 'checks for elements at the beginning or end of the array' do
      expect(subject).to start_with(1)
      expect(subject).to start_with(1, 2)
      expect(subject).to end_with(3, 4)
      expect(subject).to end_with(4)

      expect(subject).not_to start_with(0)
    end

    it { is_expected.to start_with(1, 2, 3) }
    it { is_expected.to end_with(4) }

    it { is_expected.not_to start_with(1, 3) }
  end
end
