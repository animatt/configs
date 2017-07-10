;; init.el --- Emacs configuration
;; INSTALL PACKAGES
;; --------------------------------------

; start package.el with emacs
(require 'package)

; add MELPA to repository list
(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

; initialize package.el
(package-initialize)
; start auto-complete with emacs
(require 'auto-complete)
; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)
; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)

(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../include/c++/v1")
  (add-to-list 'achead:include-directories '"//Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/8.1.0/include")
  (add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include")	       
)

(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

(define-key global-map (kbd "C-c ;") 'iedit-mode)

(defun my:flymake-google-init ()
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
  (flymake-google-cpplint-load)
)
(add-hook 'c-mode-hook 'my:flymake-google-init)
(add-hook 'c++-mode-hook 'my:flymake-google-init)

(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
	  
(semantic-mode 1)

(defun my:add-semantic-to-autocomplete ()
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
(global-ede-mode 1)

(global-semantic-idle-scheduler-mode 1)

(when (not package-archive-contents)
  (package-refresh-contents))


(defvar myPackages
  '(better-defaults
    elpy
    flycheck
    py-autopep8
    php-mode
    web-mode))


(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)


;; BASIC CUSTOMIZATION
;; --------------------------------------


(elpy-enable)


(setq python-shell-interpreter "python3")
(setq elpy-rpc-python-command "python3")


(setq linum-format "%d ")
(global-linum-mode t) ;; enable line numbers globally


(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))


(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-google-cpplint-command "/usr/local/bin/cpplint")
 '(package-selected-packages
   (quote
    (google-c-style flymake-cursor flymake-google-cpplint iedit auto-complete-c-headers web-mode py-autopep8 material-theme flycheck elpy better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
