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

;; (setq my-perspectives-pre-extensions '(custom-perspectives))

;; (setq my-perspectives-post-extensions '())

;; (defun custom-persp/notes ()
;;   (interactive)
;;   (custom-persp "notes"
;;                 (progn
;;                   (split-window-right-and-focus)
;;                   (split-window-below)
;;                   (split-window-below)
;;                   (update-notes-perspective)
;;                   (global-set-key (kbd "<f5>") #'update-notes-perspective))))

;; (defun custom-persp/mail ()
;;   (interactive)
;;   (custom-persp "mail"
;;                 (progn
;;                   ;; (setq notmuch-show-mark-read-tags '())
;;                   ;; (setq notmuch-archive-tags '())
;;                   ;; (setq notmuch-search-oldest-first nil)
;;                   ;; (setq notmuch-show-max-text-part-size 100000)
;;                   (notmuch))))

(defun window-toggle-split-direction ()
  "Switch window split from horizontally to vertically, or vice versa.

   i.e. change right window to bottom, or change bottom window to
   right."
  (interactive)
  (require 'windmove)
  (let ((done))
    (dolist (dirs '((right . down) (down . right)))
      (unless done
        (let* ((win (selected-window))
               (nextdir (car dirs))
               (neighbour-dir (cdr dirs))
               (next-win (windmove-find-other-window nextdir win))
               (neighbour1 (windmove-find-other-window neighbour-dir win))
               (neighbour2 (if next-win (with-selected-window next-win
                                          (windmove-find-other-window neighbour-dir next-win)))))
          ;;(message "win: %s\nnext-win: %s\nneighbour1: %s\nneighbour2:%s" win next-win neighbour1 neighbour2)
          (setq done (and (eq neighbour1 neighbour2)
                          (not (eq (minibuffer-window) next-win))))
          (if done
              (let* ((other-buf (window-buffer next-win)))
                (delete-window next-win)
                (if (eq nextdir 'right)
                    (split-window-vertically)
                  (split-window-horizontally))
                (set-window-buffer (windmove-find-other-window neighbour-dir) other-buf))))))))



;; ;; For each extension, define a function my-perspectives/init-<extension-name>
;; ;;
;; (defun my-perspectives/init-custom-perspectives ()
;;   "Initialize custom perpsectives"

;;   (evil-leader/set-key "wt" 'window-toggle-split-direction)

;;   (evil-leader/set-key "Lop" 'custom-persp/puppetdb)
;;   (evil-leader/set-key "Lox" 'custom-persp/pe-puppetdb-extensions)
;;   (evil-leader/set-key "Los" 'custom-persp/spacemacs)
;;   (evil-leader/set-key "Lon" 'custom-persp/notes)
;;   (evil-leader/set-key "Lom" 'custom-persp/mail)
;;   (evil-leader/set-key "Lob" 'custom-persp/clo-bubbles)

;;   (global-set-key (kbd "A-<tab>") #'persp-next)
;;   (global-set-key (kbd "S-A-<tab>") #'persp-prev)

;;   (defvar persp-before-notes nil)
;;   (global-set-key (kbd "<f12>")
;;                   (lambda ()
;;                     (interactive)
;;                     (if (string= "notes" (persp-name persp-curr))
;;                         (progn
;;                           (persp-activate persp-before-notes))
;;                       (progn
;;                         (setq persp-before-notes persp-curr)
;;                         (custom-persp/notes)))))

;;   (defvar persp-before-mail nil)
;;   (global-set-key (kbd "<f11>")
;;                   (lambda ()
;;                     (interactive)
;;                     (if (string= "mail" (persp-name persp-curr))
;;                         (progn
;;                           (persp-activate persp-before-mail))
;;                       (progn
;;                         (setq persp-before-mail persp-curr)
;;                         (custom-persp/mail)))))

;;   (add-hook 'persp-activated-hook
;;             (lambda ()
;;               (interactive)
;;               (set-frame-name (concat "Emacs - " (persp-name persp-curr)))))

;;   (evil-leader/set-key "pp" 'projectile-persp-switch-project)

;;   )

;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
