;;; packages.el --- jira-link Layer packages File for Spacemacs
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

(setq jira-link-packages
  '(button-lock popup))

(setq jira-link-excluded-packages '())

(defun jira-link/init-button-lock ()
  "Initialize button-lock"
  (use-package button-lock))

(defun jira-link/init-popup ()
  "Initialize popup"
  (use-package popup))

;; For each package, define a function jira-link/init-<package-jira-link>
;; PDB-1234
;; (defun jira-link/init-button-lock ()
;;   "Initialize jira links"
;;   (use-package button-lock
;;    :init (progn
;;            (global-button-lock-mode 1)
;;            (button-lock-register-global-button
;;             "[A-Z][A-Z]+-[0-9]+"
;;             (lambda (event) (interactive "e")
;;               (let* ((point (posn-point (event-end event)))
;;                      (bounds (button-lock-find-extent point))
;;                      (ticket-id (buffer-substring-no-properties (car bounds) (cdr bounds))))

;;                 (browse-url (concat "https://tickets.puppetlabs.com/browse/"
;;                                     ticket-id))))

;;             :face 'link
;;             :face-policy 'prepend
;;             :additional-property 'jira-link))
;;     )
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
