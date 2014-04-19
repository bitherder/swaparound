# Swaparound Vim plugin

It's not that big of a deal, but I often have to switch around the order of
elements in a list like:

    :foo, :bar, :baz

So that the list is now:

    :bar, :foo, :baz

It's a bit of a hassle to select one element, move it back or forward in the
list and then place it back in the list. Instead, I've written this plugin to
do this for you.

In the original case, you would visually select :foo, :bar and type `<leader>a,`
and the the two elements are swapped around.
