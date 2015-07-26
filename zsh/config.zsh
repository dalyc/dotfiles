#!/bin/zsh
export LSCOLORS='exfxcxdxbxegedabagacad'
export CLICOLOR=true

#fpath=($ZSH/functions $fpath)

autoload -U "$ZSH"/functions/*(:t)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# don't nice background tasks
setopt NO_BG_NICE
setopt NO_HUP
setopt NO_LIST_BEEP
# allow functions to have local options
setopt LOCAL_OPTIONS
# allow functions to have local traps
setopt LOCAL_TRAPS
# share history between sessions ???
setopt SHARE_HISTORY
# add timestamps to history
setopt EXTENDED_HISTORY
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt NO_BANG_HISTORY
setopt IGNORE_EOF
# adds history
setopt APPEND_HISTORY
# adds history incrementally and share it across sessions
setopt INC_APPEND_HISTORY SHARE_HISTORY
# don't record dupes in history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt HIST_EXPIRE_DUPS_FIRST
# dont ask for confirmation in rm globs*
setopt RM_STAR_SILENT

#zle -N newtab

# shellcheck disable=SC2004
#if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
#  function zle-line-init() {
#    echoti smkx
#  }
#  function zle-line-finish() {
#    echoti rmkx
#  }
#  zle -N zle-line-init
#  zle -N zle-line-finish
#fi

#colin
# vi-bindings (rgh)
KEYTIMEOUT=1

bindkey -rpM viins '\e'
bindkey -v

function zle-line-init { zle -K vicmd; }
zle -N zle-line-init
# /vi-bindings (rgh)

# /key-bindings (rgh)
function reload-history { fc -R; zle accept-line }

zle -N reload-history

bindkey -M vicmd "/" vi-history-search-backward

bindkey -M vicmd "^t" transpose-chars
bindkey -M vicmd "u"  undo
bindkey -M vicmd "^r" reload-history

bindkey -M viins "^t" transpose-chars

bindkey -M viins "^u" backward-kill-line
bindkey -M viins "^w" backward-kill-word
bindkey -M viins "^h" backward-delete-char
bindkey -M viins "^?" backward-delete-char

bindkey -M viins "^f" push-line
bindkey -M vicmd "^f" push-line

bindkey -M viins "^l" clear-screen
bindkey -M viins '^i' expand-or-complete-prefix
# /key-bindings (rgh)
#/colin

# ignore case
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# menu if nb items > 2
zstyle ':completion:*' menu select=2
# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
