#lang racket

(require "defs.rkt")
(require "operations.rkt")

(provide eval-prog)

(define (eval-prog prog)
  (define blank_tape (tape empty 0 empty ""))
  (define blank_prog_response (tape '(4) 0 '(4) "Program not found"))

  (cond
    [(empty? prog)  blank_prog_response]
    [else           (foldl eval-instruction blank_tape prog)]
    )
  )

(define (eval-loop body t)
  (cond
    [(zero? (tape-curr t)) t] ;; If current is 0, end the loop
    [else   (eval-loop body (foldl eval-instruction t body))] ;; The Foldl runs all the instructions, then eval-loop re-evals
    )
  )

(define (eval-instruction instr t)
  (cond
    [(not (string=? (tape-err_str t) "")) t] ;; There was an error thrown, just pass up the tape
    [else ;; Otherwise, run the instruction
      (match instr
        [(op-inc)   (tape-inc t)]
        [(op-dec)   (tape-dec t)]
        [(op-left)  (tape-left t)]
        [(op-right) (tape-right t)]
        [(op-print) (tape-print t)]
        [(op-input) (tape-input t)]

        [(op-loop body)  (eval-loop body t)]
        )
      ]
    )
  )
