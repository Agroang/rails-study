# How to use CSS Variables with Ruby on Rails (name of the cast)

# Check Jumpstart (it comes with configuration based on the user it seems)

# There is a color_field method in rails.
# You can pass colors that you like or that you have saved before with it!
# https://devdocs.io/rails~6.1/actionview/helpers/formbuilder#method-i-color_field

# You can add a color column to the account table to save those variables in
# there (pretty slick approach).

# rails g migration addColorToAccount color

# You would have to accept the color variable on the account controler as a
# safe param.

# This will provide a color picker if you use the rails form and color_field!
# And as that will be an input, to save it you need to whitelist it (that why
# you need it in your white listed params).

# Definetely worth checking ActionView::Helpers::Form .... (lots of stuff
# inside).
