class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
end

RSpec.describe 'Card' do # no need to use RSpec.describe, describe suffice

  before do
  # before(:example) do ... this is also another way, you can put :context,
  # :suit, more info later and/or in my other notes of linkedin tutorial
    @card = Card.new('Ace', 'Spade')
  end
  it 'has a rank' do
    # card = Card.new('Ace', 'Spade') no longer needed because we have the
    # before hook creating the card
    expect(@card.rank).to eq('Ace')
  end

  it 'has a suit' do
    # card = Card.new('Ace', 'Spade')
    expect(@card.suit).to eq('Spade')
  end
end
