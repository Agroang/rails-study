class Car

  attr_accessor :make, :year, :color, :doors
  attr_reader :wheels

  def initialize(options={})
    self.make = options[:make] || 'Volvo'
    self.year = (options[:year] || 2007).to_i
    self.color = options[:color] || 'unknown'
    @wheels = 4
    # @doors = 4
    self.doors = (options[:doors] || 4).to_i
    self.doors = 4 unless [2, 4].include?(doors) # very cool code, defaults to
    # 4 unless doors includes 2 or 4
  end

  def self.colors
    ['blue', 'black', 'red', 'green']
  end

  def full_name
    "#{self.year.to_s} #{self.make} (#{self.color})"
  end
end
