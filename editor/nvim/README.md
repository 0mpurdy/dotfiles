# Notes on config

## Error format

efm / errorformat
see `:h errorformat`

easiest example for just pure filenames:

```vim
:set efm=%f
```

once you've prepared a buffer

```vim
:h cb
```

Error format for manually filtering Telescope quickfix

```vim
set errorformat+=%f\|%l\ col\ %c\|\ %m
```
