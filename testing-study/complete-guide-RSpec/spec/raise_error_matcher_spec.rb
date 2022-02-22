RSpec.describe 'raise_error matcher' do

  def some_method # just for testing, x is not defined so it will trigger a
    # NameError if invoked, check list of ruby errors on google if needed
    x
  end

  class CustomError < StandardError; end # simple syntax to write a simple class
  #this inherits from the StandardError, so you can make your own errors if you
  # want to

  it 'can check for a specific error being raised' do
    # we use a block instead of the regular argument for expect {} not ()
    expect { some_method }.to raise_error(NameError)
    expect { 1 / 0 }.to raise_error(ZeroDivisionError)
  end

  it 'can check for use-created errors' do
    expect { raise CustomError }.to raise_error(CustomError)
    # raise here just calls the error
  end
end
