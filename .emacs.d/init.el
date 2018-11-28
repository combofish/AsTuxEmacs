;;--------------源
(package-initialize)
  (setq package-archives
      '(("melpa-cn" . "http://elpa.emacs-china.org/melpa/")
        ("org-cn"   . "http://elpa.emacs-china.org/org/")
        ("gnu-cn"   . "http://elpa.emacs-china.org/gnu/")))

;;显示加载时间
(defvar mage-init-time 'nil) (defun mage-display-benchmark()
  (message "Mage loaded %s packages in %.03fs"
           (length package-activated-list)
           (or mage-init-time
               (setq mage-init-time
                     (float-time (time-subtract (current-time) before-init-time)))))) (add-hook 'emacs-startup-hook #'mage-display-benchmark)

;;company补全
(global-company-mode t)
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'org-mode-hook 'company-mode)
(add-hook 'elisp-mode-hook 'company-mode)
(add-hook 'css-mode-hook 'company-mode)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'c-mode-hook 'company-mode)
(add-hook 'c++-mode-hook 'company-mode)

;;----------------------autopair括号
(require 'autopair)
(autopair-global-mode) ;; 自动补全括号
(show-paren-mode t) ;; 匹配括号高亮
;;------------Fonts
(set-default-font "Monaco-11")
;;------------------Python补全
(package-initialize)
(elpy-enable)
(setq elpy-rpc-backend "jedi")
;;-------------------------------Org

(require 'org) ;;启动 Org-mode 文本内语法高亮
(setq org-src-fontify-natively t)

;;--------------------------Themes
(load-theme ' gruvbox-dark-medium  t) ;;夜间
;;(load-theme ' gruvbox-dark-hard t)
;;(load-theme 'solarized-dark  t)
;;(load-theme 'gruvbox-light-mediun t)
;;------------------------mode-line
(require 'doom-modeline)
(doom-modeline-init)
(setq doom-modeline-buffer-file-name-style 'file-name)
;;----------Fonts
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(require 'all-the-icons)
;(setq all-the-icons-color-icons nil)
;(setq inhibit-compacting-font-caches t)
(setq neo-theme 'icons)
(add-to-list 'load-path "/home/w/.emacs.d/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;;-----------------------Gui
(setq frame-title-format '("AsTux@Emacs" buffer-file-name))
(setq-default c-basic-offset 4)
(setq initial-scratch-message  "Hack World")
(tool-bar-mode 0) ;;关闭工具栏
;;设置窗口位置为屏库左上角(0,0)
(set-frame-position (selected-frame) 0 0)
;;设置宽和高,我的十寸小本是110,33,大家可以调整这个参数来适应自己屏幕大小
(set-frame-width (selected-frame) 120)
(set-frame-height (selected-frame) 30)
;;(set-frame-parameter nil 'alpha 90) ;透明
(set-language-environment "UTF-8") ;;UTF-8
(set-language-environment 'Chinese-GB)
(setenv "LC_ALL" "en_US.UTF-8")
(setq make-backup-files nil) ;;关闭备份
(scroll-bar-mode 0) ;;关闭文件滑动控件
(global-linum-mode 1) ;;显示行号
(setq ring-bell-function 'ignore) ;;关闭哔哔的警告提示音
(fset 'yes-or-no-p 'y-or-n-p) ;; （Y or N）
(setq inhibit-splash-screen 1) ;; 关闭启动帮助画面
(defun open-init-file()
  (interactive)
  (find-file "/home/w/.emacs.d/init.el")) ;; 快速打开配置文件
(global-set-key (kbd "<f2>") 'open-init-file) ;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上

;;--------------------------Company补全&美化
(require 'company-box)
(add-hook 'company-mode-hook 'company-box-mode)
(add-to-list 'load-path "～/.emacs.d/company-mode")
(autoload 'company-mode "company" nil t)
(setq company-idle-delay 0.2;菜单延迟
      company-minimum-prefix-length 1; 开始补全字数0
      company-require-match nil
      company-dabbrev-ignore-case nil
      company-dabbrev-downcase nil
      company-show-numbers t; 显示序号
      company-transformers '(company-sort-by-backend-importance)
      company-continue-commands '(not helm-dabbrev)
      )

;;Helm
(require 'helm-config)
(global-set-key (kbd "C-x r b") #'helm-file-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)
(helm-mode 1)
;;TabBar and Gui
(require 'tabbar)  
(tabbar-mode 1)  
(global-set-key [(meta j)] 'tabbar-backward)  
(global-set-key [(meta k)] 'tabbar-forward)  
;;Go-mode
(add-to-list 'load-path "/home/w/.emacs.d/elpa/go-mode-20181012.329/")
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
(add-hook 'go-mode-hook
      (lambda ()
        (set (make-local-variable 'company-backends) '(company-go))
        (company-mode)))
;;MDwenjian
(add-to-list 'load-path "/home/w/.emacs.d/markdown-mode/repository")
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
;;Common Lisp
(require 'cl)
;;Mode-Line
(setq-default mode-line-format
              (list '(:propertize " %l " face (:weight bold))
                    'mode-line-mule-info
                    'mode-line-modified
                    'mode-line-remote " "
                    '(:eval (propertize " %b " 'face (if (buffer-modified-p) '(:background "#d33682" :foreground "#fdf6e3" :weight bold)
                                                       '(:background "#268bd2" :foreground "#fdf6e3" :weight normal))))
                    '(:propertize " %p/%I " face (:background "gray60" :foreground "#fdf6e3"))
                    '(:eval (propertize (concat " " (eyebrowse-mode-line-indicator) " ")))
                    '(:eval (propertize (format-time-string "%p·%H:%M ") 'help-echo (format-time-string "%F %a") 'face '(:inherit 'font-lock-doc-face)))
                    '(:propertize vc-mode face (:inherit font-lock-keyword-face :weight bold))
                    " %m " ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (tabbar-ruler solarized-theme helm gruvbox-theme go-mode elpy doom-modeline company-box autopair all-the-icons-dired 2048-game))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
