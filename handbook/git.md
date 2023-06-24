# Upload a local repository to github

## 1

```shell
cd PROJECT_DIR
git init
```

## 2

```shell
git add -A
git commit -m "Initial import"
git branch -M main
git remote add origin git@github.com:roiko/foo.git
git push -u origin main
```

## Notes

`git init` is used to initialise a git repository locally — having a repository on GitHub isn’t enough;<br>
One needs a local repository as well, either from a git clone or a git init.<br>
Then, `git add` and `git commit` allow you to add content to the local repository, and `git push` pushes your local repository’s state to the remote repository (on GitHub).<br>
Credit to Stephen Kitt.
