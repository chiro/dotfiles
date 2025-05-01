;;; 11-gptel.el --- Configuration for GPT/LLM interaction via gptel

;; Sets up gptel for interacting with Claude and Gemini AI models
;; Uses auth-source for secure API key management
;; Add your API keys to ~/.authinfo like the following:
;;   machine api.anthropic.com login apikey password sk-ant-api03-key...
;;   machine generativelanguage.googleapis.com login user password AIza...

(require 'auth-source)

(defvar chiro-anthropic-api-key
  (auth-info-password (nth 0 (auth-source-search :host "api.anthropic.com" :max 1)))
  "API key for Claude.")

(defvar chiro-gemini-api-key
  (auth-info-password (nth 0 (auth-source-search :host "generativelanguage.googleapis.com" :max 1)))
  "API key for Gemini.")

(use-package gptel
  :ensure t
  :defer t
  :config
  ;; Centralize model name
  (let ((claude-model "claude-3-7-sonnet-20250219")
        (gemini-model "gemini-2.5-pro-exp-03-25"))
    (gptel-make-anthropic "Claude-thinking"
      :key chiro-anthropic-api-key ; gptel handles x-api-key with this
      :stream t
      :models (list claude-model)
      :header (lambda () ; Use :header only for ADDITIONAL headers
                '(("anthropic-version" . "2023-06-01")
                  ;; Combine beta headers
                  ("anthropic-beta" . "pdfs-2024-09-25,output-128k-2025-02-19,prompt-caching-2024-07-31")))
      :request-params '(:thinking (:type "enabled" :budget_tokens 2048)
                                  :max_tokens 4096))

    (gptel-make-gemini "Gemini"
      :key chiro-gemini-api-key
      :stream t)

    ;; Set default model using the variable
    (setq gptel-model gemini-model)))

(use-package gptel-aibo
  :ensure t
  :after (gptel flycheck))
