RSpec.describe Array do
  it 'returns 0 for #length' do
    expect(subject.length).to eq(0)
    subject.push(1)
    expect(subject.length).to eq(1)
  end
end
