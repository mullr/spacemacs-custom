;;; extensions.el --- jira-link Layer extensions File for Spacemacs
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

(setq jira-link-pre-extensions
  '(
    ;; pre extension jira-links go here
    ))


(setq jira-link-post-extensions
  '(jira-link))


;; For each extension, define a function jira-link/init-<extension-jira-link>
;;
(defun jira-link/init-jira-link ()
  "Initialize my extension"
  (use-package jira-link
    :config (global-jira-link-mode 1)))
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
