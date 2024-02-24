`tr` replaces string A in string B.

```shell
echo $PATH | tr ':' '\n'
```

Show `PATH` environment variable values in different lines instead in one long one-liner separated with colons (`:`).

Append something to PATH:

```shell
export PATH=$PATH:/your/new/path/here
```

Override PATH (desirably after a backup !):

```shell
export PATH=/your/new/path/here:
```
