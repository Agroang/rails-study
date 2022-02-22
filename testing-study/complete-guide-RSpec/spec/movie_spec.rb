class Actor

  def initialize(name)
    @name = name
  end

  def ready?
    sleep(3) # pauses for 3 seconds
    true
  end

  def jump_off_ladder
    "Call my agent, no way!"
  end

  def act
    "I will be back!"
  end

  def light_on_fire
    false
  end
end

class Movie
  attr_reader :actor

  def initialize(actor)
    @actor = actor
  end

  def start_shooting
    if actor.ready?
      actor.act
      actor.light_on_fire
      actor.jump_off_ladder
    end
  end
end

# actor = Actor.new('Sponge Bob')
# movie = Movie.new(actor)

# if you really think about it, actor can be tested on its own, you can
# test the methods separately but movie is linked to actor, as you call
# those methods inside the movie instance. Nevertheless, you really don't
# care about the internals of those methods, or how the work, you only care
# that the actor instance accepts those methods as it shoulds, that's why
# doubles/mocks are useful in this kind of cases.

RSpec.describe Movie do
  # in this case, the actual ready? methods sleeps for 3 seconds, that is huge
  # for any test, so that is super helpful in the double, as it returns the true
  # right away
  let(:stuntman) { double("Mr. Danger", ready?: true, jump_off_ladder: 'string', act: 'string', light_on_fire: false) }
  subject { described_class.new(stuntman) }

  describe '#start_shooting method' do
    it 'expects an actor to do 3 actions' do
      expect(stuntman).to receive(:ready?)
      expect(stuntman).to receive(:jump_off_ladder)
      expect(stuntman).to receive(:act).exactly(1).time # times also work
      expect(stuntman).to receive(:light_on_fire)
      # the above is saying that by the end of the example, it is expected
      # to have called those methods on stuntman
      subject.start_shooting # this will trigger the 4 methods above

      # if you want to be precise in the number of times the methods are being
      # called you can use other helpers (commented out as they are bellow
      # the actual call of the methods the subject is doing, so it won't work)
      # expect(stuntman).to receive(:act).once
      # expect(stuntman).to receive(:act).exactly(1).times
      # expect(stuntman).to receive(:act).at_most(1).times
      # expect(stuntman).to receive(:act).at_least(1).times
    end
  end
end
