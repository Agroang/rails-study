# Object-oriented design (OOD) requires that you shift from thinking of the
# world as a collection of predefined procedures to modeling the world as a
# series of messages that pass between objects.

# It is the need for change that makes design matter.

# Applications that are easy to change are a pleasure to write and a joy to
# extend.

# Object-oriented applications are made up of parts that interact to produce the
# behavior of the whole. The parts are objects; interactions are embodied in the
# messages that pass between them. Getting the right message to the correct
# target object requires that the sender of the message know things about the
# receiver. This knowledge creates dependencies between the two, and these
# dependencies stand in the way of change.

# Design is not an assembly line where similarly trained workers construct
# identical widgets; it’s a studio where like-minded artists sculpt custom
# applications. Design is thus an art, the art of arranging code.

# Practical design does not anticipate what will happen to your application; it
# merely accepts that something will and that, in the present, you cannot know
# what. It doesn’t guess the future; it preserves your options for accommodating
# the future. It doesn’t choose; it leaves you room to move.

# The purpose of design is to allow you to do design later, and its primary goal
# is to reduce the cost of change.

# Agile works because it acknowledges that certainty is unattainable in advance
# of the  application’s existence; Agile’s acceptance of this truth allows it to
# provide strategies to overcome the handicap of developing software while
# knowing neither the target nor the timeline.

# * Check for "ruby metrics" in Google, seems there are good gems to check if
# are doing good OOD *
# This has some interesting options:
# https://www.ruby-toolbox.com/categories/code_metrics

# Sometimes the value of having the feature right now is so great that it
# outweighs any future increase in costs. If lack of a feature will force you
# out of business today, it doesn’t matter how much it will cost to deal with
# the code tomorrow; you must do the best you can in the time you have. Making
# this kind of design compromise is like borrowing time from the future and is
# known as taking on technical debt. This is a loan that will eventually need to
# be repaid, quite likely with interest.

# Class-based OO languages like Ruby allow you to define a class that provides
# a blueprint for the construction of similar objects. A class defines methods
# (definitions of behavior) and attributes (definitions of variables). Methods
# get invoked in response to messages. The same method name can be defined by
# many different objects; it’s up to Ruby to find and invoke the right method of
# the correct object for any sent message.
