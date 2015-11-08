;;; packages.el --- pixie Layer packages File for Spacemacs
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
(setq pixie-packages
    '(
      pixie-mode
      inf-clojure
      ))

;; List of packages to exclude.
(setq pixie-excluded-packages '())


;; For each package, define a function pixie/init-<package-pixie>
;;
(defun pixie/init-pixie-mode ()
  "Initialize pixie-mode"
  (use-package pixie-mode
    :config (add-hook 'pixie-mode-hook #'inf-clojure-minor-mode)))

(defun pixie/init-inf-clojure ()
  "Initialize inf-clojure"
  (use-package inf-clojure)
  )

;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
