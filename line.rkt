#lang racket/base
(require "struct.rkt")
(provide b-line)

(require (for-syntax syntax/parse)
         (for-syntax racket/base)
         (for-syntax racket/syntax))

(define-syntax (b-line stx)
  (syntax-parse stx
    [(_ NUM STATEMENT ...)
     (with-syntax ([LINE-NUM (datum->syntax stx 
                                            (string->symbol (format "line-~a" (syntax-e #'NUM))) 
                                            #'NUM)])
       (syntax/loc stx
         (define (LINE-NUM)
           (void) 
           STATEMENT ...)))]))