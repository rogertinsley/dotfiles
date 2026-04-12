setopt AUTO_CD               # `foo/bar` -> cd foo/bar
setopt AUTO_PUSHD            # cd pushes to dir stack
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt EXTENDED_GLOB         # **/*, ^pattern, *(.), etc.
setopt INTERACTIVE_COMMENTS  # allow # comments at interactive prompt
setopt NO_BEEP
setopt NO_CLOBBER            # > won't overwrite; use >| to force
bindkey -v                   # vi mode

# Treat / and . as word boundaries so Ctrl-W deletes path segments
WORDCHARS='*?_-[]~&;!#$%^(){}<>'
