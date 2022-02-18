class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
end

RSpec.describe 'Card' do # no need to use RSpec.describe, describe suffice
  it 'has a rank' do
    card = Card.new('Ace', 'Spade')
    expect(card.rank).to eq('Ace')
  end

  it 'has a suit' do
    card = Card.new('Ace', 'Spade')
    expect(card.suit).to eq('Spade')
  end
end
