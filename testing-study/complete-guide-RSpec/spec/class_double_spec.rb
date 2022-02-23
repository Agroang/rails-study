class Deck
  def self.build
    # logic to build a bunch of cards, irrelevant for the sake of testing
  end
end

class CardGame
  attr_reader :cards

  def start
    @cards = Deck.build # class method, calling directly on the Deck class
  end
end

RSpec.describe CardGame do
  it 'can only implement class methods that are defined on a class' do
    deck_klass = class_double(Deck, build: ['Ace', 'Queen']).as_stubbed_const
    # if we add methods that are real class methods of the Deck class it will fail
    # The #as_stubbed_const is the one that pretty much says that whenever you
    # need to use a Deck class you need to use the above's double. If the Deck
    # class doesn't exist yet, using 'Deck' as string also will work with this.
    expect(deck_klass).to receive(:build).at_least(1) # you don't need the
    # last method, I am just testing what I studied before
    expect(subject.start).to eq(['Ace', 'Queen'])
    expect(subject.cards).to eq(['Ace', 'Queen'])
  end
end
