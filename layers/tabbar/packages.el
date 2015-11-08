;;; packages.el --- tabbar Layer packages File for Spacemacs
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

(setq tabbar-packages '(tabbar))
(setq tabbar-excluded-packages '())


;; For each package, define a function tabbar/init-<package-tabbar>
;;
;; (defun tabbar/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package


(defun tabbar/init-tabbar ()
  "Initialize tabbar mode"
  (use-package tabbar
    :init (tabbar-mode)
    :bind (("C-<tab>" . tabbar-forward-tab)
           ("C-S-<tab>" . tabbar-backward-tab))))
