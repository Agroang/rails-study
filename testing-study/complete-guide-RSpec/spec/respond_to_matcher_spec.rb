RSpec.describe 'respond_to matcher' do

  class ChilliSauce
    def drink
     'OH GOD HELP!'
    end

    def drop
      'What a waste...'
    end

    def buy(number)
      number == 1 ?
      "Hell yeah, #{number} moar hot sauce!" :
      "Hell yeah, #{number} moar hot sauces!"
    end
  end

  describe ChilliSauce do
    it 'confirms that an object can respond to a method' do
      expect(subject).to respond_to(:drop)
      expect(subject).to respond_to(:buy) # don't even need the arguments
      expect(subject).to respond_to(:drink, :drop, :buy) # can check more than 1
    end

    it 'confirms that an object can respondo to a method with arguments' do
      expect(subject).to respond_to(:buy)
      expect(subject).to respond_to(:buy).with(1) # with(1) means that accepts
      # 1 argument, is not that the argument will be the number 1
      expect(subject).to respond_to(:buy).with(1).argument # also works
      expect(subject).to respond_to(:buy).with(1).arguments # also works for
      # some reason, the tutorial only uses .arguments
    end

    it { is_expected.to respond_to(:drink, :drop) }
    it { is_expected.to respond_to(:buy).with(1).argument }
    it { is_expected.not_to respond_to(:buy).with(2).arguments }
  end

end
