#lang racket/base


(require (for-syntax syntax/parse)
         (for-syntax racket/base)
         racket/string
         racket/format
         "struct.rkt")


(provide b-rem b-print b-let b-input)


(define (b-rem val) (void))


(define (b-print . vals)
  (displayln (apply string-append (map ~a vals))))


(define-syntax (b-let stx)
  (syntax-parse stx
    [(_ ID VAL)
     #'(set! ID VAL)]))


(define-syntax (b-input stx)
  (syntax-parse stx
    [(_ ID)
     #'(b-let ID (let* ([str (read-line)]
                     [num (string->number (string-trim str))])
                (or num str)))]))
 

