In a case where `tree` isn't installed and can't be installed (as in Namecheap's shared hosting environment as of 27/09/2026) use this alternative:

```
find . -print | sed -e 's;[^/]*/;|--;g'
```
