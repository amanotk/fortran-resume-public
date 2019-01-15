(require 'whitespace)
(setq whitespace-style '(face trailing spaces tabs space-mark tab-mark))
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark   ?\t   [?\xBB ?\t])
        ))
(set-face-attribute 'whitespace-trailing nil
                    :background "navy")
(global-whitespace-mode 1)
