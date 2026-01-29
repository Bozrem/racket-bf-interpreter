#lang racket

(require "parser.rkt")
(require "eval.rkt")

(define args (vector->list (current-command-line-arguments)))

(define (main)
  (cond
    [(empty? args)  (print "Requires a .bf file as an argument")]
    [else           (eval-prog (parse-file (first args)))]
    )
  )

(main)
