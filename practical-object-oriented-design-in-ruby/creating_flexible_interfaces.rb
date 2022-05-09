# An object-oriented application is more than just classes. It is made up of
# classes but defined by messages. Classes control what’s in your source code
# repository; messages reflect the living, animated application.

# Design, therefore, must be concerned with the messages that pass between
# objects. It deals not only with what objects know (their responsibilities) and
# who they know (their dependencies) but also with how they talk to one another.
# The conversation between objects takes place using their interfaces.

# The word interface can refer to a number of different concepts. Here the term
# is used to refer to the kind of interface that is within a class. Classes
# implement methods; some of those methods are intended to be used by others,
# and these methods make up its public interface.

# Each of your classes is like a kitchen. The class exists to fulfill a single
# responsibility but implements many methods. These methods vary in scale and
# granularity and range from broad, general methods that expose the main
# responsibility of the class to tiny utility methods that are only meant to be
# used internally. Some of these methods represent the menu for your class and
# should be public; others deal with internal implementation details and are
# private.

# Public Interfaces:
# The methods that make up the public interface of your class comprise the face
# it presents to the world. They:
# • Reveal its primary responsibility.
# • Are expected to be invoked by others.
# • Will not change on a whim.
# • Are safe for others to depend on.
# • Are thoroughly documented in the tests.

# Private Interfaces
# All other methods in the class are part of its private interface. They:
# • Handle implementation details.
# • Are not expected to be sent by other objects.
# • Can change for any reason whatsoever.
# • Are unsafe for others to depend on.
# • May not even be referenced in the tests.

# Good public interfaces reduce the cost of unanticipated change; bad public
# interfaces raise it.

# "domain objects" are obvious because they are persistent; they stand for big,
# visible real-world things that will end up with a representation in your
# database.

# Design experts notice domain objects without concentrating on them; they focus
# not on these objects but on the messages that pass between them. These
# messages are guides that lead you to discover other objects, ones that are
# just as necessary but far less obvious.

# There is a perfect, low-cost way to experiment with objects and messages:
# "sequence diagrams". Sequence diagrams are defined in the Unified Modeling
# Language (UML) and are one of many diagrams that UML supports.

# Sequence diagrams are quite handy. They provide a simple way to experiment
# with different object arrangements and message-passing schemes. They bring
# clarity to your thoughts and provide a vehicle to collaborate and communicate
# with others.

# The previous design emphasis was on classes and who and what they knew.
# Suddenly, the conversation has changed; it is now revolving around messages.
# Instead of deciding on a class and then figuring out its responsibilities, you
# are now deciding on a message and figuring out where to send it.

# This transition from class-based design to message-based design is a turning
# point in your design career. The message-based perspective yields more
# flexible applications than does the class-based perspective. Changing the
# fundamental design question from “I know I need this class, what should it
# do?” to “I need to send this message, who should respond to it?” is the first
# step in that direction.
