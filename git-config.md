# Commands for generating git configuration

To edit the git global config:

```
git config --global --edit
```

Git `lol` alias

```
git config --global --add alias.lola 'log --graph --decorate --abbrev-commit --all --date=local --pretty=format:"%C(auto)%h%d %C(blue)%an %C(green)%cd %C(red)%GG %C(reset)%s" --date=local'
```

Auto completion [docs][1]. Add `source ~/git-completion.bash` to `.bashrc`.
URL for getting script: https://github.com/git/git/blob/master/contrib/completion/git-completion.bash

[1]: https://git-scm.com/book/en/v1/Git-Basics-Tips-and-Tricks
