(import-macros {: g! : go! : set!}
  :nvim-laurel.macros)

(set! :cmdheight 0)

(g! :maplocalleader ",")

;; send-to-term
(g! :send_disable_mapping true)
(g! :send_multiline {:ghci {:begin ":{\n" :end "\n:}\n" :newline "\n"}})

;; tmux-navigator
(g! :tmux_navigator_no_wrap true)
(g! :tmux_navigator_disable_when_zoomed true)
(g! :tmux_navigator_preserve_zoom true)
