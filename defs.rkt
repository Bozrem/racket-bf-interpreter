#lang racket

(provide (all-defined-out))

(struct op-inc ()) ;; + (increment)
(struct op-dec ()) ;; - (decrement)
(struct op-left ()) ;; < (left)
(struct op-right ()) ;; > (right)
(struct op-print ()) ;; . (print)
(struct op-input ()) ;; , (take input)

(struct op-loop (body)) ;; [] (Defines a loop block)

(struct tape (l curr r err_str) #:transparent) ;; Leftward side of the tape, current data, rightward side
