class Card
  attr_accessor :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
end

RSpec.describe Card do # no need to use RSpec.describe, describe suffice

  # before do
  # # before(:example) do ... this is also another way, you can put :context,
  # # :suit, more info later and/or in my other notes of linkedin tutorial
  #   @card = Card.new('Ace', 'Spade')
  # end
  # def card # helper method that evaluates to a new card, using it bellow
  #   Card.new('Ace', 'Spade')
  # end
  # # there is a big problem with the above method. It does not allow mutation,
  # # if you try to assign a different value within the example you will end
  # # up just calling the method again, and it will always have the same values.

  let(:card) { Card.new('Ace', 'Spade')} # With let, it will create the instance
  # only when it's needed, and it will be avaiable till the end of that example

  it 'has a rank and a rank can change' do
    # card = Card.new('Ace', 'Spade') no longer needed because we have the
    # before hook creating the card
    # expect(@card.rank).to eq('Ace')
    # expect(card.rank).to eq('Ace') # calling card method
    # card.rank = 'Queen' won't work, you are just calling the method again
    expect(card.rank).to eq('Ace')
    card.rank = 'Queen' # same card, kept due to memoization throughout this
    # example, the next example will be a different card
    expect(card.rank).to eq('Queen')
  end

  it 'has a suit' do
    # card = Card.new('Ace', 'Spade')
    # expect(@card.suit).to eq('Spade')
    expect(card.suit).to eq('Spade')#, "I can pass a #{custom} error message here"
    # more info about custom error messages on lesson and a little bit on my .txt
  end
end
