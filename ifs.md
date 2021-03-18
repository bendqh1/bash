IFS is a field (internal-content) separation program and the standard "field separator" in shells implementing POSIX behavior in general and Bourne shell and derivates in particular.

In Bourne shell and derivates the terms “Field splitting” and “word splitting” are used interchangeably.

## Setting IFS

In Bourne shell and derivates, IFS **is set** by default as an environment variable.

## Unsetting IFS

If IFS is not set (as with `unset IFS`), it shall behave as normal for an unset variable but if the shell is ought to do field splitting (for unquoted values, for splitting read input and when delimiting the positional parameters in the `"$*"` string), but the shell shall behave **as if** the value of `IFS` was `<space>`, `<tab>` and `<newline>` which is equivalent to being set to `$' \t\n'`.

## Resetting IFS after unsetting it:

For Bash, zsh and ksh:

    IFS=$' \t\n'
    
Restoring IFS's value in `sh` could be more complex though.

## Setting IFS to an empty value

Because unsetting IFS causes some special fallback behavior, we can set it to an empty value to force not using it (or minimally using it):

IFS can be set to an empty value ("null" IFS) via:

* `IFS=`
* `IFS=''`
* `IFS=""`  

In that case, no field splitting will be performed at all and with `echo "$*"` all fields will be concatenated together with no spaces.

## Miscellaneous

* `IFS=!` is merely setting a non-existent value for IFS, so that you can iterate input line by line

Consider `IFS=$'\n'`

Normally Bash doesn't interpret escape sequences in string literals. So:

* `\n` isn't a linebreak - but the letter `n`
* `'\n'` isn't a linebreak - backslash followed by the letter `n`
* `"\n"` isn't a linebreak - backslash followed by the letter `n`

Unlike `'\n'` --- `$'\n'` is a linebreak.

## IFS and `read`

In POSIX shells, `read`, without any option doesn't read a line, rather, it reads *words* from a possibly backslash-continued line --- where words are `$IFS` delimited and backslashes can be used to continue lines or to escape delimiters.
