RSpec.describe 'a random double' do
  it 'only allows defined methods to be invoked' do
    # in RSpec the doubles are stric so they only will accept the methods
    # that you make them accept, not any method
    # Whenever you are passing a hash as the last argument to a method you
    # don't have to provide the curly braces (of course you can add if you want)
    # The arguments for the double method can be only the identifer but you can
    # also pass the hash containing methods as symbols and the returns of those
    # methods as values of that key/value pair
    stuntman = double('Mr. Danger', fall_off_ladder: 'Argh!', jump: true)

    expect(stuntman.fall_off_ladder).to eq('Argh!')
    expect(stuntman.jump).to eq(true)

    # there is another syntax to write the above so I will create another double
    # to show how it works:

    fake_cat = double('Felix')
    allow(fake_cat).to receive(:miau) # if left like this, the method will work
    # but the return value of that method would be nil
    expect(fake_cat.miau).to be_nil
    allow(fake_cat).to receive(:run).and_return('AHHHH') # the method return this
    expect(fake_cat.run).to eq('AHHHH')

    # there is another syntax in the case we want to make it receive more than
    # 1 method, as receive can only accept 1 method. The syntax is a mix between
    # the first and second examples:

    fake_dog = double('Bobby')
    allow(fake_dog).to receive_messages(bark: 'Woof woof', bite: true)
    expect(fake_dog.bark).to eq('Woof woof')
    expect(fake_dog.bite).to eq(true)
  end
end
