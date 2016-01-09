;;; packages.el --- my-perspectives Layer packages File for Spacemacs
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
(setq my-perspectives-packages
      '(
        persp-mode
      ))

;; List of packages to exclude.
(setq my-perspectives-excluded-packages '())

;; For each package, define a function my-perspectives/init-<package-name>
;;
;; (defun my-perspectives/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package


(defun my-perspectives/post-init-persp-mode ()
  "Initialize custom perspectives"
  (spacemacs|define-custom-layout "puppetdb"
    :binding "p"
    :body
    (find-file "~/devel/puppetdb/project.clj"))

  (spacemacs|define-custom-layout "puppetdb"
    :binding "x"
    :body
    (find-file "~/devel/pe-puppetdb-extensions/project.clj"))

  (setq org-default-notes-file "~/Dropbox/notes/notes.org")

  (spacemacs|define-custom-layout "notes"
    :binding "n"
    :body
    (find-file org-default-notes-file))


  (defvar persp-before-notes nil)
  (global-set-key (kbd "<f12>")
                  (lambda ()
                    (interactive)
                    (let* ((curr-persp (get-frame-persp))
                           (curr-persp-name (if curr-persp
                                                (persp-name curr-persp)
                                              "Default")))
                      (if (and curr-persp-name (string= "notes" curr-persp-name))
                          (persp-switch persp-before-notes)
                        (progn
                          (setq persp-before-notes curr-persp-name)
                          (spacemacs/custom-perspective-notes))))))


  )



