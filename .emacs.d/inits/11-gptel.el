;;; 11-gptel.el --- Configuration for GPT/LLM interaction via gptel

;; Sets up gptel for interacting with Claude AI model from Anthropic
;; Uses auth-source for secure API key management
;; Add your API key to ~/.authinfo like the following:
;;   machine api.anthropic.com login apikey password sk-ant-api03-key

(require 'auth-source)

(defvar chiro-anthropic-api-key
  (auth-info-password (nth 0 (auth-source-search :host "api.anthropic.com" :max 1)))
  "API key for Claude")

(use-package gptel
  :ensure t
  :defer 2
  :config
  (setq gptel-backend
        (gptel-make-anthropic "Claude-thinking" ;Any name you want
          :key chiro-anthropic-api-key
          :stream t
          :models '(claude-3-7-sonnet-20250219)
          :header (lambda () (when-let* ((key (gptel--get-api-key)))
                               `(("x-api-key" . ,key)
                                 ("anthropic-version" . "2023-06-01")
                                 ("anthropic-beta" . "pdfs-2024-09-25")
                                 ("anthropic-beta" . "output-128k-2025-02-19")
                                 ("anthropic-beta" . "prompt-caching-2024-07-31"))))
          :request-params '(:thinking (:type "enabled" :budget_tokens 2048)
                                      :max_tokens 4096)))
  (setq gptel-model 'claude-3-7-sonnet-20250219))

(use-package gptel-aibo
  :ensure t
  :after gptel)
