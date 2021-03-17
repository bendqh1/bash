IFS is a field (internal-content) separation program and the Bourne shell and derivates standard "field separator".

In Bourne shell and derivates the terms “Field splitting” and “word splitting” are used interchangeably.

## Setting IFS

In Bourne shell and derivates, IFS **is set** by default as an environment variable.

## Unsetting IFS

If IFS is not set (as with `unset IFS`), the shell shall behave **as if** the value of `IFS` was `<space>`, `<tab>` and `<newline>` which is equivalent to being set to `$' \t\n'`.

## Resetting IFS after unsetting it:

For Bash, zsh and ksh:

    IFS=$' \t\n'
    
Restoring IFS's value in `sh` could be more complex though.

## Setting IFS to an empty value
IFS can be set to an empty value ("null" IFS) via:

* `IFS=`
* `IFS=''`
* `IFS=""`  

In that case, no field splitting will be performed at all and with `echo "$*"` all fields will be concatenated together with no spaces.

## Miscellaneous

Consider `IFS=$'\n'`

Normally Bash doesn't interpret escape sequences in string literals. So:

* `\n` isn't a linebreak - but the letter `n`
* `'\n'` isn't a linebreak - backslash followed by the letter `n`
* `"\n"` isn't a linebreak - backslash followed by the letter `n`

Unlike `'\n'` --- `$'\n'` is a linebreak.
