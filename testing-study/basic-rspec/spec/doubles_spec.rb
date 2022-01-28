describe 'Doubles' do

  it 'allows stubbing methods' do
    dbl = double('Chant')
    allow(dbl).to receive(:hey!)
    expect(dbl).to respond_to(:hey!)
  end

  it 'allows stubbing a response with a block' do
    dbl = double('Chant')
    # when I say 'hey!' you say 'ho!'
    allow(dbl).to receive(:hey!) { 'Ho!' }
    # 'hey!', 'ho!'
    expect(dbl.hey!).to eq('Ho!')
  end

  it 'allows stubbing responses with #and_return' do
    dbl = double('Chant')
    # quite easy to understand syntax, reads better than above
    allow(dbl).to receive(:hey!).and_return('Ho!')
    expect(dbl.hey!).to eq('Ho!')
  end

  it 'allows stubbing multiple methods with the hash syntax' do
    dbl = double('Person')
    # note this uses #receive_messages, not #receive
    allow(dbl).to receive_messages(:full_name => 'Mary Smith', :initials => 'MTS')
    expect(dbl.full_name).to eq('Mary Smith')
    expect(dbl.initials).to eq('MTS')
  end

  it 'allows stubbing with a hash argument to #dobule' do
    dbl = double('Person', :full_name => 'Mary Smith', :initials => 'MTS')
    expect(dbl.full_name).to eq('Mary Smith')
    expect(dbl.initials).to eq('MTS')
  end

  it 'allows stubbing multiple responses with #and_return' do
    die = double('Die')
    allow(die).to receive(:roll).and_return(1, 5, 2, 6)
    expect(die.roll).to eq(1)
    expect(die.roll).to eq(5)
    expect(die.roll).to eq(2)
    expect(die.roll).to eq(6)
    expect(die.roll).to eq(6) # continues returning the last value
  end
end
