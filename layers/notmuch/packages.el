;;; packages.el --- notmuch Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq notmuch-packages
    '(
      notmuch
      notmuch-labeler
      notmuch-unread
      ))

;; List of packages to exclude.
(setq notmuch-excluded-packages '())

;; For each package, define a function notmuch/init-<package-notmuch>
;;
(defun notmuch/init-notmuch ()
  "Initialize my package"
  (use-package notmuch
    :defer t
    :commands notmuch
    :init (evil-leader/set-key "an" 'notmuch)
    :config (progn
              (evilify notmuch-hello-mode notmuch-hello-mode-map)
              (evilify notmuch-tree-mode notmuch-tree-mode-map)
              (evilify notmuch-search-mode notmuch-search-mode-map)
              (evilify notmuch-show-mode notmuch-show-mode-map)
              )
    ;; :init (tabbar-mode)
    ;; :bind (("C-<tab>" . tabbar-forward-tab)
    ;;        ("C-S-<tab>" . tabbar-backward-tab)))
    )
  )

;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
