;;; packages.el --- notmuch Layer packages File for Spacemacs

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq notmuch-packages
    '(notmuch
      notmuch-labeler
      notmuch-unread))

;; List of packages to exclude.
(setq notmuch-excluded-packages '())

;; For each package, define a function notmuch/init-<package-notmuch>
(defun notmuch/init-notmuch ()
  "Initialize my package"
  (use-package notmuch
    :defer t
    :commands notmuch
    :init (progn
            (evil-leader/set-key "an" 'notmuch)
            (evil-leader/set-key "Ns" 'notmuch-search)
            (evil-leader/set-key "Nc" 'notmuch-mua-new-mail)
            
            ) 
    :config (progn
              ;; Fix helm
              ;; See id:m2vbonxkum.fsf@guru.guru-group.fi
              (setq notmuch-address-selection-function
                    (lambda (prompt collection initial-input)
                      (completing-read prompt (cons initial-input collection) nil t nil 'notmuch-address-history)))

              (evilify notmuch-hello-mode notmuch-hello-mode-map
                       (kbd "C-j") 'widget-forward
                       (kbd "C-k") 'widget-backward
                       )
              (evilify notmuch-show-mode notmuch-show-stash-map)
              (evilify notmuch-show-mode notmuch-show-part-map)
              (evilify notmuch-show-mode notmuch-show-mode-map
                       (kbd "N") 'notmuch-show-next-message
                       (kbd "n") 'notmuch-show-next-open-message)
              (evilify notmuch-tree-mode notmuch-tree-mode-map)
              (evilify notmuch-search-mode notmuch-search-mode-map)
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
