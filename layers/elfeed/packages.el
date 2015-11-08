;;; packages.el --- elfeed Layer packages File for Spacemacs

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq elfeed-packages
    '(elfeed elfeed-org elfeed-web))

;; List of packages to exclude.
(setq elfeed-excluded-packages '())

;; For each package, define a function elfeed/init-<package-elfeed>
;;

(defvar elfeed-search-mode-map
  (let ((map (make-sparse-keymap)))
    (prog1 map
      (suppress-keymap map)
      (define-key map "q" 'quit-window)
))
  "Keymap for elfeed-search-mode.")

(defun elfeed/init-elfeed ()
  "Initialize my package"
  (use-package elfeed
    :defer t
    :init (progn
            (evilify elfeed-search-mode elfeed-search-mode-map)
            (evil-leader/set-key-for-mode 'elfeed-search-mode
              "mg" 'elfeed-search-update--force
              "mG" 'elfeed-update
              "ms" 'elfeed-search-live-filter
              "mS" 'elfeed-search-set-filter
              "mb" 'elfeed-search-browse-url
              "my" 'elfeed-search-yank
              "mu" 'elfeed-search-tag-all-unread
              "mr" 'elfeed-search-untag-all-unread
              "m+" 'elfeed-search-tag-all
              "m-" 'elfeed-search-untag-all)

            (evilify elfeed-show-mode elfeed-show-mode-map)
            (evil-leader/set-key-for-mode 'elfeed-show-mode
              "md" 'elfeed-show-save-enclosure
              "mg" 'elfeed-show-refresh
              "ms" 'elfeed-show-new-live-search
              "mb" 'elfeed-show-visit
              "my" 'elfeed-show-yank
              ;; "mu" (elfeed-expose #'elfeed-show-tag 'unread)
              "m+" 'elfeed-show-tag
              "m-" 'elfeed-show-untag))))

(defun elfeed/init-elfeed-org ()
  "Initialize my package"
  (use-package elfeed-org
    :defer t))

(defun elfeed/init-elfeed-web ()
  "Initialize my package"
  (use-package elfeed-web
    :defer t))

;; (defun elfeed/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
