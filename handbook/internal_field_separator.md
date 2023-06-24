Field splitting (field separation) is a component of word expansion, which is a small portion of command-line parsing in shells.

IFS is a field (internal-content) separation program and the standard "field separator" in shells implementing POSIX behavior in general and Bourne shell and derivates in particular.

Changing `IFS` tends to have really confusing effects. There are a few places where it's relatively safe and has well-defined effects (like setting it for the `read` command, as in `IFS= read -r line`), but trying to understand its behavior in general is, in my opinion, more work than it's worth.

## Bourne shell and derivates

In Bourne shell and derivates the terms “Field splitting” and “word splitting” are used interchangeably.

### Setting IFS

In Bourne shell and derivates, IFS **is set** by default as an environment variable.

### Unsetting IFS

If IFS is not set (as with `unset IFS`), it shall behave as normal for an unset variable but if the shell is ought to do field splitting (for unquoted values, for splitting read input and when delimiting the positional parameters in the `"$*"` string), but the shell shall behave **as if** the value of `IFS` was `<space>`, `<tab>` and `<newline>` which is equivalent to being set to `$' \t\n'`.

### Resetting IFS after unsetting it:

For Bash, zsh and ksh:

    IFS=$' \t\n'

But that's not portable to all shells (and will cause *really* weird effects in shells that don't support `$' '`); Restoring IFS's value in `sh` can be combursome.

## Setting IFS to an empty value

Because unsetting IFS causes special fallback behavior, we can set it to an empty value to force no essential usage of it:

IFS can be set to an empty value ("null" IFS) via:

* `IFS=`
* `IFS=''`
* `IFS=""`  

In that case, no field splitting will be performed so two or more fields will be concatenated together with no field splitting.

## `IFS=!`

* `IFS=!` is merely setting a non-existent value for IFS, so that you can iterate input line by line

## `IFS=$'\n'`

Consider `IFS=$'\n'`

Normally Bash doesn't interpret escape sequences in string literals. So:

* `\n` isn't a linebreak - but the letter `n`
* `'\n'` isn't a linebreak - backslash followed by the letter `n`
* `"\n"` isn't a linebreak - backslash followed by the letter `n`

Unlike `'\n'` --- `$'\n'` is a linebreak.

## IFS and `read`

In POSIX shells, `read`, without any option doesn't read a line, rather, it reads *words* from a possibly backslash-continued line --- where words are `$IFS` delimited and backslashes can be used to continue lines or to escape IFS delimiters.

The `-r` option removes the backslash processing, then backslashes cannot be used to continue lines or to escape IFS delimiters.

## Further reading

* https://unix.stackexchange.com/questions/640010/testing-default-ifs-against-null-ifs
