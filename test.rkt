#lang racket

(require "defs.rkt")
(require "eval.rkt")

;; Simple math

(define test-math
  (list (op-inc)
        (op-inc)
        (op-dec)))
;; brainfuck: "++-"

"Expect: (tape '() 1 '() empty_string)"
(eval-prog test-math)
""


(define test-move
  (list (op-right)
        (op-inc)
        (op-left)))
;; brainfuck: ">+<"

"Expect: (tape '() 0 '(1) empty_string)"
(eval-prog test-move)


(define test-loop 
  (list (op-inc)
        (op-inc)
        (op-loop (list (op-dec)))))
;; brainfuck "++[-]"

"Expect: (tape '() 0 '() empty_string)"
(eval-prog test-loop)
""


;; (define test-io 
;;  (list (op-inc)
;;        (op-print)))
;; brainfuck "+."

;;"Expect: . then "
;;(eval-prog test-io)
