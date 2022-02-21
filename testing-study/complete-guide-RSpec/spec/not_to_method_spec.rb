RSpec.describe 'not_to method' do
  it 'checks that two values do not match' do
    expect(1).not_to eq(2)
    expect([1, 2, 3]).not_to eq([1, 2])
    expect('Bye').not_to eq('bye')
  end
end
