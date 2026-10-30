" Mostly AI nonsense at the moment
"
" --- Color Guide ---
"
" Active State
" * `++` / `+>` / ` +` : Lime Green  - Code newly added in the current rework
" * ` -`               : Bold Red    - Code newly deleted in the current rework
" * `+-`               : Soft Red    - Old additions discarded/replaced in the rework
"
" Historical Context
" * `-+`               : Blue/Muted  - The previous version's proposed replacement
" * `--` / `-<`        : Slate Grey  - Old deletion dropped/reverted
" * `+ ` / `- `        : White       - Unchanged baseline diffs between v1 and v2

if exists("b:current_syntax")
  finish
endif

syn clear

" 1. Hunk headers & File boundaries (4 spaces)
syn match gitRangeDiffHunkHeader /^    [-+ ]*@@\+.*$/
syn match gitRangeDiffFileHeader /^    [-+ ]*##\+.*##\+/

" 2. Commit series status metadata (Flush-left)
syn match gitRangeDiffCommitEqual   /^\d\+:\s\+[0-9a-fA-F]\+\s\+=\s\+\d\+:\s\+[0-9a-fA-F]\+.*$/
syn match gitRangeDiffCommitChanged /^\d\+:\s\+[0-9a-fA-F]\+\s\+!\s\+\d\+:\s\+[0-9a-fA-F]\+.*$/
syn match gitRangeDiffCommitAdded   /^-\s*:\s*-\+\s*<\s*\d\+:\s*[0-9a-fA-F]\+.*$/
syn match gitRangeDiffCommitRemoved /^\d\+:\s*[0-9a-fA-F]\+\s*>\s*-\s*:\s*-\+.*$/

" 3. Dual-column diff markers (Order defines precedence)

" Winning additions in new revision:
" 4 spaces + ( ++ | +> | ' +' ) : (Lime Green)
" Matches ++, +>, and exactly 1 space followed by + (excluding +-)
syn match gitRangeDiffAddedNew      /^    \(++\|+>\|\s+[^+]\).*$/

" Brand new deletions introduced in rework:
" Exactly 4 spaces, 1 space, 1 minus (Bold Red)
syn match gitRangeDiffNewDel        /^     -[^+].*$/

" Lines scrapped/replaced between revisions:
" 4 spaces + +- : (Soft Red - line was discarded in new commit)
syn match gitRangeDiffModOld        /^    +-[^!].*$/
" 4 spaces + -+ : (Muted Blue/Grey - prior diff artifact)
syn match gitRangeDiffModNew        /^    -+.*$/

" Dropped deletions / historical diff removals:
" 4 spaces + -- or -< : (Dim Slate/Cyan so it doesn't look like an addition)
syn match gitRangeDiffRestoredOld   /^    \(--\|-<\).*$/

" Base diff lines identical across both versions:
" 4 spaces + '+ ' (White)
syn match gitRangeDiffBothAdd       /^    + .*$/
" 4 spaces + '- ' (White)
syn match gitRangeDiffBothDel       /^    - .*$/

" 4. Structural links
hi def link gitRangeDiffFileHeader   Title
hi def link gitRangeDiffHunkHeader   Type
hi def link gitRangeDiffCommitEqual  Comment
hi def link gitRangeDiffCommitChanged PreProc
hi def link gitRangeDiffCommitAdded  String
hi def link gitRangeDiffCommitRemoved Comment

" 5. Color definitions
hi gitRangeDiffAddedNew      guifg=#3cc43c ctermfg=77 gui=bold
hi gitRangeDiffNewDel        guifg=#ff5555 ctermfg=Red gui=bold
hi gitRangeDiffModOld        guifg=#f38ba8 ctermfg=210
hi gitRangeDiffModNew        guifg=#89b4fa ctermfg=111
hi gitRangeDiffRestoredOld   guifg=#6c7086 ctermfg=244
hi gitRangeDiffBothAdd       guifg=#ffffff ctermfg=White
hi gitRangeDiffBothDel       guifg=#ffffff ctermfg=White

let b:current_syntax = "gitrangediff"
