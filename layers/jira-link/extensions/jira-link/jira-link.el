(require 'button-lock)
(require 'popup)

(defun jira-link-open-ticket-in-jira (ticket-id)
  (message "opening %s in jira" ticket-id)
  (browse-url (concat "https://tickets.puppetlabs.com/browse/"
                      ticket-id)))

(defun jira-link-find-ticket-in-github (ticket-id)
  (message "opening %s in github" ticket-id)
  (browse-url (concat "https://github.com/search?q=user:puppetlabs+"
                      ticket-id
                      "&type=Issues&utf8=✓")))

(defun jira-link-selected-ticket-id (event)
  (let* ((point (posn-point (event-end event)))
         (bounds (button-lock-find-extent point)))
    (buffer-substring-no-properties (car bounds) (cdr bounds))))

(setq jira-link-open-menu
      '(keymap
        "Open ticket in..."
        (jira-link-open-ticket-in-jira "JIRA" . identity)
        (jira-link-find-ticket-in-github "Github" . identity)))

(defun jira-link-handle-mouse-1 (event)
  (interactive "e")
  (let* ((ticket-id (jira-link-selected-ticket-id event))
         (action (car (x-popup-menu event jira-link-open-menu))))
    (message "chose action %s" action)
    (funcall action ticket-id)))

;;;###autoload
(define-minor-mode global-jira-link-mode
  "Make your jira ticket ids clickable"
  :lighter " JL"
  :global :true
  (progn
    (global-button-lock-mode 1)
    (button-lock-register-global-button
     "[A-Z][A-Z]+-[0-9]+"
     'jira-link-handle-mouse-1
     :face 'link
     :face-policy 'prepend
     :additional-property 'jira-link)))

(provide 'jira-link)
