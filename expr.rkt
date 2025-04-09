#lang racket/base
(provide b-expr b-sum b-product b-neg b-expt)
(require (for-syntax syntax/parse)
         (for-syntax racket/base))

(define (b-expr expr)
  (if (integer? expr) (inexact->exact expr) expr))

(define-syntax (b-sum stx)
  (syntax-parse stx
    [(_ VAL) #'VAL]
    [(_ LEFT "+" RIGHT) #'(+ LEFT RIGHT)]
    [(_ LEFT "-" RIGHT) #'(- LEFT RIGHT)]))
    

(define-syntax (b-product stx2)
  (syntax-parse stx2
    [(_ VAL) #'VAL]
    [(_ LEFT "*" RIGHT) #'(* LEFT RIGHT)]
    [(_ LEFT "/" RIGHT) #'(/ LEFT RIGHT 1.0)]
    [(_ LEFT "mod" RIGHT) #'(modulo LEFT RIGHT)]))


(define-syntax (b-neg stx3)
  (syntax-parse stx3
    [(_ VAL) #'VAL]
    [(_ "-" VAL) #'(- VAL)]))

(define-syntax (b-expt stx4)
  (syntax-parse stx4
    [(_ VAL) #'VAL]
    [(_ LEFT "^" RIGHT) #'(expt LEFT RIGHT)]))


