;;; esearch-interfaces.el --- interface to search engines -*- lexical-binding: t; -*-

;; Copyright (C) 2014 Emmanuele Somma

;; Author: Emmanuele Somma <emmanuele@exedre.org>
;; Keywords: lisp
;; Version: 0.0.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; simple interface to search engines

;;; Code:

(defgroup esearch nil
  "Interface to search engines"
  :prefix "esearch-"
  :group 'applications)

(defcustom esearch-browser 'eww
  "Web Browser to use"
  :group 'esearch)

(defmacro esearch-make-search-engine (name prompt search-engine-url)
  `(defun ,name (&optional arg)
     "Search into the given search engine."
    (interactive "P")
    (esearch-browser
     (concat
      ,search-engine-url
      (url-hexify-string
       (if arg
           (if mark-active
               (buffer-substring (region-beginning) (region-end))
             (read-string (concat "Search " ,prompt ": ")))
         (progn (let ((word-regexp "\\sw"))
                  (when (or (looking-at word-regexp)
                            (looking-back word-regexp (line-beginning-position)))
                    (skip-syntax-forward "w")
                    (set-mark (point))
                    (skip-syntax-backward "w")))
                (buffer-substring (region-beginning) (region-end)))))))))

(esearch-make-search-engine esearch-google
                            "Google"
                            "http://www.google.com/search?ie=utf-8&oe=utf-8&q=")
(global-set-key (kbd  "C-c C-= g") 'exe-search-google)

(esearch-make-search-engine esearch-OAL
                            "Oxford Advanced Learner's Dictionary"
                            "http://www.oxfordlearnersdictionaries.com/definition/english/" )
(global-set-key (kbd  "C-c C-= o") 'esearch-OAL)

(esearch-make-search-engine esearch-youtube
                            "Youtube"
                            "http://www.youtube.com/results?search_query=")
(global-set-key (kbd  "C-c C-= y") 'esearch-youtube)

(esearch-make-search-engine esearch-treccani
                            "Vocabolario Treccani"
                            "http://www.treccani.it/vocabolario/")
(global-set-key (kbd  "C-c C-= v") 'esearch-treccani)

(esearch-make-search-engine esearch-enciclopedia-treccani
                            "Enciclopedia Treccani"
                            "http://www.treccani.it/enciclopedia/ricerca/")
(global-set-key (kbd  "C-c C-= e") 'esearch-enciclopedia-treccani)

(provide 'esearch-interfaces)
;;; esearch-interfaces.el ends here
