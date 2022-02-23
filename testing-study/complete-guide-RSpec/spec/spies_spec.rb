RSpec.describe 'spies' do
  let(:animal) { spy('animal') } # the string is not necessary, is an identifier

  it 'confirms that a message (method) has been received' do
    animal.eat_food
    expect(animal).to have_received(:eat_food) # as you check after the call you
    # write #have_received instead of the double's way that is #receive
    expect(animal).not_to have_received(:eat_human)
  end

  it 'resets between examples' do
    expect(animal).not_to have_received(:eat_food)
  end

  it 'retains same functionality of a double' do
    animal.eat_food
    animal.eat_food
    animal.eat_food('Sushi')
    expect(animal).to have_received(:eat_food).exactly(3).times
    expect(animal).to have_received(:eat_food).at_least(2).times
    expect(animal).to have_received(:eat_food).with('Sushi')
    expect(animal).to have_received(:eat_food).once.with('Sushi')
  end
end
