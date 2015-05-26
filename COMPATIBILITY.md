Shpec Compatibility Notes
-------------------------

The following are shell-specific quirks you might care about when using `shpec`.

## zsh

### Disabling the 'end' Keyword
If you use `zsh` you must disable the `end` keyword. This won't be that big of a problem
since it belongs to a `foreach...end` structure that is rarely used.

To disable it, just run `disable -r end`.
Otherwise you'll get the following error `parse error near 'end'`

If you have installed `shpec` through `antigen`, there is nothing you need to do,
`shpec.plugin.zsh` defines an alias that does this for you:

    alias shpec="zsh -c 'disable -r end; . $(dirname $0:A)/bin/shpec'"
