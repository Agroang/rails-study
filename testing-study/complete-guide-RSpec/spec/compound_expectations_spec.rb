RSpec.describe 25 do
  it 'can test for multiple matchers' do
    # expect(subject).to be_odd
    # expect(subject).to be > 20

    expect(subject).to be_odd.and be > 20 # && == #and method, checks both
  end

  it { is_expected.to be_odd.and be > 20 }
  # it { is_expected.to be_odd and be > 20 } # this one is not working I think,
  # because on although it passes it only shows that to be odd is passing
end

RSpec.describe 'Jalapeno Pizza' do
  it 'supports multiple matchers on a single line' do
    expect(subject).to start_with('Jal').and end_with('zza')
  end

  it { is_expected.to start_with('J').and end_with('a') }
end

RSpec.describe [:chile, :peru, :argentina] do
  it 'can check for multiple possibilities' do
    expect(subject.sample).to eq(:chile).or eq(:peru).or eq(:argentina)
    # || can be used as #or in RSpec just like the above example, no one-liner
    # example here as to use the same example I need to use the #sample method
    # on the subject and on the one-liner I can't do that, I can only use the
    # subject as it is
  end
end
