#lang racket/base
(require "go.rkt")
(provide b-if b-or-expr b-and-expr b-not-expr b-comp-expr)
(require (for-syntax syntax/parse)
         (for-syntax racket/base))


(define (bool->int val) (if val 1 0))
(define nonzero? (compose1 not zero?))


(define-syntax ( b-or-expr stx)
  (syntax-parse stx
    [(_ VAL) #'VAL]
    [(_ LEFT "or" RIGHT)
     #'(bool->int (or (nonzero? LEFT) (nonzero? RIGHT)))]))


(define-syntax (b-and-expr stx)
  (syntax-parse stx
    [(_ VAL) #'VAL]
    [(_ LEFT "and" RIGHT)
     #'(bool->int (and (nonzero? LEFT) (nonzero? RIGHT)))]))


(define-syntax (b-not-expr stx)
  (syntax-parse stx
    [(_ VAL) #'VAL]
    [(_ "not" VAL) #'(if (nonzero? VAL) 0 1)]))


(define b= (compose1 bool->int =))
(define b< (compose1 bool->int <))
(define b> (compose1 bool->int >))
(define b<> (compose1 bool->int not =))


(define-syntax (b-comp-expr stx)
  (syntax-parse stx
    [(_ VAL) #'VAL]
    [(_ LEFT "=" RIGHT) #'(b= LEFT RIGHT)]
    [(_ LEFT "<" RIGHT) #'(b< LEFT RIGHT)]
    [(_ LEFT ">" RIGHT) #'(b> LEFT RIGHT)]
    [(_ LEFT "<>" RIGHT) #'(b<> LEFT RIGHT)]))


(define-syntax (b-if stx)
  (syntax-parse stx
    [(_ COND-EXPR THEN-EXPR) #'(b-if COND-EXPR THEN-EXPR (void))]
    [(_ COND-EXPR THEN-EXPR ELSE-EXPR)
     #'(let ([result (if (nonzero? COND-EXPR)
                         THEN-EXPR
                         ELSE-EXPR)])
         (when (exact-positive-integer? result)
           (b-goto result)))]))
