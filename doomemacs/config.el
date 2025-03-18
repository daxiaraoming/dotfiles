;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "l"
      user-mail-address "l@ff.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
;; 字体
(setq doom-font (font-spec :family "Source Code Pro for Powerline" :size 16)
        doom-big-font (font-spec :family "Source Code Pro for Powerline" :size 20)
        doom-modeline-height 32)
(setq doom-unicode-font (font-spec :family "苹方-简" :size 16))

;; 设置pyim,中文输入法,双拼
;;(setq default-input-method "pyim")
;;(pyim-default-scheme 'xiaohe-shuangpin)

;; 自适应切换输入法,emacs-smart-input-source(aka:sis)
;;(sis-ism-lazyman-config
 ;;"com.apple.keylayout.ABC"
 ;;"com.sogou.inputmethod.sogou.pinyin")


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; 主题(doom-gruvbox-light doom-monokai-machine doom-solarized-light)
;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-solarized-light)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;; 开启相对行号
(setq display-line-numbers-type 'relative)
;; (setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; 按键绑定
(global-set-key (kbd "<f5>") 'shell-command)
(global-set-key (kbd "<f6>") 'shell-command)
(global-set-key (kbd "<f7>") 'consult-bookmark)
;; (global-set-key (kbd "C-s") '+default/search-buffer)

(map! "C-s" #'+default/search-buffer)
(map! :leader :desc "M-x" "<SPC>" #'execute-extended-command)

(map! :leader :desc "shell-command" "ls" #'shell-command)
(map! :leader :desc "ranger" "lr" #'ranger)
(map! :leader :desc "undo-tree-visualize" "lu" #'undo-tree-visualize)
(map! :leader :desc "run-python" "lp" #'run-python)

;; 窗口切换
(map! :leader
      "0" 'treemacs-select-window
      "1" 'winum-select-window-1
      "2" 'winum-select-window-2
      "3" 'winum-select-window-3
      "4" 'winum-select-window-4
      "8" 'split-window-below
      "9" 'split-window-right)
(map! "C-1" #'winum-select-window-1)


;;; 以下是我的自定义配置

;; 补全延迟
(setq company-idle-delay 0.1)
;; 按键提示延迟
(setq which-key-idle-delay 0.3)


;; 似乎没用
(setq system-time-locale 'zh_CN.UTF-8)
(setq org-time-stamp-formats '("<%Y-%m-%d %A>"))

;; 不换行
(add-hook! 'org-mode-hook (setq-local truncate-lines 't))
(add-hook! 'org-mode-hook (setq-local visual-line-mode nil))
(setq-default fill-column 2000)

;; ipython
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt"
      )

;; 全屏启动
;; (add-to-list 'initial-frame-alist '(fullscreen . maximized))
;; (add-hook 'org-mode-hook 'turn-on-auto-fill)
;; 半屏启动
(pushnew! initial-frame-alist '(width . 94) '(height . 52))
;; frame初始位置
(set-frame-position (selected-frame) 960 0)


;; python自动格式化black,禁用双引号转换( -S, --skip-string-normalization )
(set-formatter! 'black "black -q -S -")


;; org美化
(use-package! org-link-beautify
  :config (add-hook! 'org-mode-hook 'org-link-beautify-mode))

;; winum
;; (use-package! winum
;;   :init
;;   (setq-default
;;    winum-scope 'frame-local)
;;   :config
;;   (load! "bindings/+winum"))
;; (winum-mode)

;; org TODO keywords
;;(with-eval-after-load 'org
(after! org
  (setq org-todo-keywords '((sequence "TODO(t)" "WORKING(w)" "|" "DONE(d)" "CANCEL(c)"))))


;; org代码块支持LSP
(cl-defmacro lsp-org-babel-enable (lang)
  "Support LANG in org source code block."
  (setq centaur-lsp 'lsp-mode)
  (cl-check-type lang stringp)
  (let* ((edit-pre (intern (format "org-babel-edit-prep:%s" lang)))
         (intern-pre (intern (format "lsp--%s" (symbol-name edit-pre)))))
    `(progn
       (defun ,intern-pre (info)
         (let ((file-name (->> info caddr (alist-get :file))))
           (unless file-name
             (setq file-name (make-temp-file "babel-lsp-")))
           (setq buffer-file-name file-name)
           (lsp-deferred)))
       (put ',intern-pre 'function-documentation
            (format "Enable lsp-mode in the buffer of org source block (%s)."
                    (upcase ,lang)))
       (if (fboundp ',edit-pre)
           (advice-add ',edit-pre :after ',intern-pre)
         (progn
           (defun ,edit-pre (info)
             (,intern-pre info))
           (put ',edit-pre 'function-documentation
                (format "Prepare local buffer environment for org source block (%s)."
                        (upcase ,lang))))))))
(defvar org-babel-lang-list
  '("go" "python" "ipython" "bash" "sh" "js" "typescript" "css"))
(dolist (lang org-babel-lang-list)
  (eval `(lsp-org-babel-enable ,lang)))

;; 代码助手copilot
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
         ("<tab>" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion)
         ("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)))

;; run-geiser自动启动
(setq geiser-mode-start-repl-p t)

;;; 以上是我的自定义配置
