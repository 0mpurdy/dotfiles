# Commands for generating git configuration

To edit the git global config:

```sh
git config --global --edit
```

Git `lol` alias

```sh
git config --global --add alias.lola 'log --graph --decorate --abbrev-commit --all --date=local --pretty=format:"%C(auto)%h%d %C(blue)%an %C(green)%cd %C(red)%GG %C(reset)%s" --date=local'
```

Auto completion [docs][1]. Add `source ~/git-completion.bash` to `.bashrc`.
URL for getting script: https://github.com/git/git/blob/master/contrib/completion/git-completion.bash

[1]: https://git-scm.com/book/en/v1/Git-Basics-Tips-and-Tricks

```.gitconfig
[alias]
	lola = log --graph --decorate --abbrev-commit --all --date=local --pretty=format:\"%C(auto)%h%d %C(blue)%an %C(green)%cd %C(red)%GG %C(reset)%s\" --date=local
	refdate = reflog --format=\"%C(auto)%h %C(green)%cd %C(reset)%gs %C(auto)%d%C(reset)\"
[rebase]
	autoSquash = true
```

Useful "I forgot to switch git user" command

```sh
git -c rebase.instructionFormat='%s%nexec GIT_COMMITTER_DATE="%cD" GIT_AUTHOR_DATE="%aD" git commit --amend --no-edit --reset-author' rebase -f origin/main
```
