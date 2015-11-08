;;; extensions.el --- my-perspectives Layer extensions File for Spacemacs
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

(setq my-perspectives-pre-extensions '(custom-perspectives))

(setq my-perspectives-post-extensions '())


(defun custom-persp/puppetdb ()
  (interactive)
  (custom-persp "puppetdb"
                (progn (find-file "~/devel/puppetdb/project.clj"))))


(defun custom-persp/pe-puppetdb-extensions ()
  (interactive)
  (custom-persp "pe-puppetdb-extensions"
                (progn (find-file "~/devel/pe-puppetdb-extensions/project.clj"))))


(defun custom-persp/spacemacs ()
  (interactive)
  (custom-persp "spacemacs-config"
                (progn
                  (switch-to-buffer "*Messages*")
                  (split-window-right)
                  (find-file "~/devel/spacemacs-custom/dotspacemacs"))))

(defun custom-persp/clo-bubbles ()
  (interactive)
  (custom-persp "clo-bubbles"
                (progn
                  (find-file "~/devel/clo-bubbles/project.clj"))))

(setq org-default-notes-file "~/Dropbox/notes/notes.org")

(defun update-notes-perspective ()
  (interactive)

  (if (string= "notes" (persp-name persp-curr))
      (progn
        (select-window-1)
        (find-file org-default-notes-file)

        (select-window-2)
        (save-window-excursion
          (with-output-to-temp-buffer "*pdb-pull-requests*"
            (async-shell-command "cd /Users/mullr/devel/puppetdb && gh pr | tail -n +3 | sed -e 's/^\([a-zA-Z]\)/\* \1/'"
                                 "*pdb-pull-requests*" "*Messages*")))
        (switch-to-buffer "*pdb-pull-requests*")
        (button-lock-mode)
        (evil-normal-state)

        (select-window-3)
        (save-window-excursion
          (with-output-to-temp-buffer "*pe-pull-requests*"
            (async-shell-command "cd /Users/mullr/devel/pe-puppetdb-extensions && gh pr | tail -n +3 | sed -e 's/^\([a-zA-Z]\)/\* \1/'"
                                 "*pe-pull-requests*" "*Messages*")))
        (switch-to-buffer "*pe-pull-requests*")
        (button-lock-mode)
        (evil-normal-state)

        (select-window-4)
        (save-window-excursion
          (with-output-to-temp-buffer "*jira-board*"
            (async-shell-command "cd /Users/mullr/devel/puppetdb-dev-tools/pdbflow && node main.js"
                                 "*jira-board*" "*Messages*")))
        (switch-to-buffer "*jira-board*")
        (button-lock-mode)
        (evil-normal-state)
        ;; (org-mode)

        ;; (select-window-4)
        ;; (save-window-excursion
        ;;   (with-output-to-temp-buffer "*gcalcli-agenda*"
        ;;     (async-shell-command "gcalcli agenda --nocolor" "*gcalcli-agenda*" "*Messages*")))
        ;; (switch-to-buffer "*gcalcli-agenda*")

        ;; (switch-to-buffer-other-window "*scratch* (notes)")
        ;; (delete-window)

        (select-window-1))))

(defun custom-persp/notes ()
  (interactive)
  (custom-persp "notes"
                (progn
                  (split-window-right-and-focus)
                  (split-window-below)
                  (split-window-below)
                  (update-notes-perspective)
                  (global-set-key (kbd "<f5>") #'update-notes-perspective))))

;; For each extension, define a function my-perspectives/init-<extension-name>
;;
(defun my-perspectives/init-custom-perspectives ()
  "Initialize custom perpsectives"

  (evil-leader/set-key "Lop" 'custom-persp/puppetdb)
  (evil-leader/set-key "Loe" 'custom-persp/pe-puppetdb-extensions)
  (evil-leader/set-key "Los" 'custom-persp/spacemacs)
  (evil-leader/set-key "Lon" 'custom-persp/notes)
  (evil-leader/set-key "Lob" 'custom-persp/clo-bubbles)

  (global-set-key (kbd "A-<tab>") #'persp-next)
  (global-set-key (kbd "S-A-<tab>") #'persp-prev)

  (defvar persp-before-notes nil)

  (global-set-key (kbd "<f12>")
                  (lambda ()
                    (interactive)
                    (if (string= "notes" (persp-name persp-curr))
                        (progn
                          (persp-activate persp-before-notes))
                      (progn
                        (setq persp-before-notes persp-curr)
                        (custom-persp/notes)))))

  (add-hook 'persp-activated-hook
            (lambda ()
              (interactive)
              (set-frame-name (concat "Emacs - " (persp-name persp-curr)))))

  (evil-leader/set-key "pp" 'projectile-persp-switch-project)

  )

;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
