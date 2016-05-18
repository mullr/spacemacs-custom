;;; packages.el --- notmuch Layer packages File for Spacemacs

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq notmuch-packages
    '(notmuch
      notmuch-labeler
      notmuch-unread))

;; List of packages to exclude.
(setq notmuch-excluded-packages '())


(defun notmuch/search ()
  (interactive)
  (require 'notmuch)
  (notmuch-search))

(defun notmuch/tree ()
  (interactive)
  (require 'notmuch)
  (notmuch-tree))

(defun notmuch/jump-search ()
  (interactive)
  ;; (require 'notmuch)
  (notmuch-jump-search)
  (bind-map-change-major-mode-after-body-hook))

(defun notmuch/new-mail ()
  (interactive)
  (require 'notmuch)
  (notmuch-mua-new-mail))

(defun notmuch/inbox ()
  (interactive)
  (require 'notmuch)
  (notmuch-tree "is:unread")
  (bind-map-change-major-mode-after-body-hook))

(defun notmuch/tree-show-message ()
  (interactive)
  (notmuch-tree-show-message-in)
  (select-window notmuch-tree-message-window))

;; For each package, define a function notmuch/init-<package-notmuch>
(defun notmuch/init-notmuch ()
  "Initialize my package"
  (use-package notmuch
    :defer t
    ;; :commands notmuch
    :init (progn
            (spacemacs/set-leader-keys
              "amn" 'notmuch/new-mail
              "amm" 'notmuch/jump-search
              "ami" 'notmuch/inbox)

            (spacemacs/set-leader-keys-for-major-mode 'notmuch-search-mode
              "t+" 'notmuch-search-add-tag)

            (spacemacs/set-leader-keys-for-major-mode 'notmuch-tree-mode
              "tt" 'notmuch-tree-tag-thread
              "t+" 'notmuch-tree-add-tag
              "t-" 'notmuch-tree-remove-tag
              "r" 'notmuch-tree-refresh-view
              "a" 'notmuch-tree-archive-message-then-next
              "a" 'notmuch-tree-archive-thread
              "g" 'notmuch-poll-and-refresh-this-buffer
              "s" 'notmuch-search-from-tree-current-query
              "c" 'notmuch-show-stash-map
              "m" 'notmuch-mua-new-mail
              "w" 'notmuch-show-save-attachments)
            )

    :config (progn
              ;; ;; Fix helm
              ;; ;; See id:m2vbonxkum.fsf@guru.guru-group.fi
              ;; (setq notmuch-address-selection-function
              ;;       (lambda (prompt collection initial-input)
              ;;         (completing-read prompt (cons initial-input collection) nil t nil 'notmuch-address-history)))

              (evilified-state-evilify-map notmuch-search-mode-map
                :mode notmuch-search-mode
                :bindings
                (kbd "q") 'notmuch-search-quit)

              (evilified-state-evilify-map notmuch-show-mode-map
                :mode notmuch-show-mode)

              (evilified-state-evilify-map notmuch-tree-mode-map
                :mode notmuch-tree-mode
                :bindings
                (kbd "q") 'notmuch-bury-or-kill-this-buffer
                (kbd "?") 'notmuch-help
                (kbd "RET") 'notmuch/tree-show-message
                (kbd "}") 'notmuch-tree-scroll-or-next
                (kbd "{") 'notmuch-tree-scroll-message-window-back)

              ;; (evilify notmuch-hello-mode notmuch-hello-mode-map
              ;;          (kbd "C-j") 'widget-forward
              ;;          (kbd "C-k") 'widget-backward
              ;;          )
              ;; (evilify notmuch-show-mode notmuch-show-stash-map)
              ;; (evilify notmuch-show-mode notmuch-show-part-map)
              ;; (evilify notmuch-show-mode notmuch-show-mode-map
              ;;          (kbd "N") 'notmuch-show-next-message
              ;;          (kbd "n") 'notmuch-show-next-open-message)
              ;; (evilify notmuch-tree-mode notmuch-tree-mode-map)
              ;; (evilify notmuch-search-mode notmuch-search-mode-map)
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
