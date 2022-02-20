RSpec.describe Hash do
  subject(:hashy) do # we can modify subject by passing a block with the content of what
    # we want it to be. You can pass a symbol that can used to reference the
    # same subject, both will work and will be the same
    { a: 1, b: 2}
  end

  it 'has two key-value pairs' do
    expect(subject.length).to eq(2)
    expect(hashy.length).to eq(2)
  end
end
