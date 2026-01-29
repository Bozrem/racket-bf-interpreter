#lang racket

(provide (all-defined-out))

(require "defs.rkt")

(define (tape-inc t)
  (define tl (tape-l t))
  (define tc (tape-curr t))
  (define tr (tape-r t))

  (tape tl (+ tc 1) tr "")
  )


(define (tape-dec t)
  (define tl (tape-l t))
  (define tc (tape-curr t))
  (define tr (tape-r t))

  (tape tl (- tc 1) tr "")
  )

(define (tape-left t)
  (define tl (tape-l t))
  (define tc (tape-curr t))
  (define tr (tape-r t))

  (cond
    [(empty? tl)  (tape tl tc tr "Out-of-bounds error on <")]     ;; Empty left, error  TODO: Improve error message to indicate where
    [else         (tape (rest tl) (first tl) (cons tc tr) "")]  ;; Left exists, move
    )
  )

(define (tape-right t)
  (define tl (tape-l t))
  (define tc (tape-curr t))
  (define tr (tape-r t))

  (cond
    [(empty? tr)  (tape (cons tc tl) 0 empty "")] ;; Ran out of infinite tape, init a 0 value
    [else         (tape (cons tc tl) (first tr) (rest tr) "")] ;; Right exists, move
    )
  )

(define (tape-print t)
  (define tl (tape-l t))
  (define tc (tape-curr t))
  (define tr (tape-r t))

  (write-byte tc)
  (flush-output)

  t
  )

(define (tape-input t)
  (define tl (tape-l t))
  (define tc (tape-curr t))
  (define tr (tape-r t))

  (define in (read-byte))

  (cond
    [(eof-object? in)   (tape tl tc tr "Expected input character, got EOF")]
    [else               (tape tl in tr "")]
    )
  )
