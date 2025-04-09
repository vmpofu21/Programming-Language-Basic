#lang racket/base
(require "parser.rkt" "tokenizer.rkt" syntax/strip-context)

(define (read-syntax path port)
  (define parse-tree (parse path (make-tokenizer port path)))
  (strip-context
   #`(module basic-mod basic-vm/expander
       #,parse-tree)))



(module+ reader
  (provide read-syntax))