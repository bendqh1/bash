```shell
for f in *; do
    [[ -f $f ]] || continue
    printf '\n\033[1;31m===== %s =====\033[0m\n' "$f"
    cat -- "$f"
done
```
