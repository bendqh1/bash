## Question

What is the Bash heredocument syntax with which I could wrap both a filename and file contents  and then run it in Bash to create a file with the same name and same contents (no indentation)? Short answer.

## Answer

```shell
cat > filename <<'EOF'
file contents
EOF
```
