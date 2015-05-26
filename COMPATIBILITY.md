Shpec Compatibility Notes
-------------------------

You'll find there special thing to consider for using your specific shell with `shpec`


## Zsh

### Disabling End Keyword
If you use `zsh` you should disable the `end` keyword. This won't be that big of a problem
since it belongs to a `foreach...end` structure that is rarely used.

To disable it, just run `disable -r end`.
Otherwise you'll get the following error `parse error near 'end'`

If you have installed `shpec` through `antigen`, there is nothing you need to do,
`shpec.plugin.zsh` defines an alias that does this for you:

    alias shpec="zsh -c 'disable -r end; . $(dirname $0:A)/bin/shpec'"
