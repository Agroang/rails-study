RSpec.describe 'change matcher' do
  subject { [1, 2, 3] }

  it 'checks that a method changes object state' do
    # very connected to subject, if subject's length changes this test breaks.
    # also, the syntax is quite different from others as we are passing a lot
    # of ruby blocks (to expect and to change)
    expect { subject.push(4) }.to change { subject.length }.from(3).to(4)
    # another way to write this, but more abstract and probably more scalable is
    expect { subject.push(4) }.to change { subject.length }.by(1)
  end

  it 'accepts negative arguments' do
    expect { subject.pop }.to change { subject.length }.from(3).to(2)
    expect { subject.pop }.to change { subject.length }.by(-1) # negatives OK
  end
end
