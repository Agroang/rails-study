RSpec.describe 'Card' do # no need to use RSpec.describe, describe suffice
  it 'has a type' do
    card = Card.new('Ace of Spades')
    expect(card.type).to eq('Ace of Spades')
  end
end
