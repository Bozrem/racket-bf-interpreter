#lang racket

(provide parse-file)
(require "defs.rkt")

;; The let values work sort of like a define, but helps grab two things from within a function

(define (file-to-chars filename)
  (string->list (file->string filename))
  )

(define (parse-file filename)
  (let-values ([(ops remainder) (parse-tokens (file-to-chars filename))])
    ops)
  )

;; Main recursive worker
(define (parse-tokens chars)
  (match chars
    ['() (values empty empty)] ;; EOF

    [(cons #\] rest) (values empty rest)] ;; Finished a loop

    [(cons #\[ rest) ;; Starting a loop
     (let-values ([(loop-body remaining-after-loop) (parse-tokens rest)]) ;; Parses within that loop (hits the finished a loop case)
       (let-values ([(program-tail final-remainder) (parse-tokens remaining-after-loop)]) ;; Parses the outside
         (values (cons (op-loop loop-body) program-tail) final-remainder)))] ;; Combine the two

    [(cons char rest) ;; Standard operation
     (let-values ([(tail-ops final-remainder) (parse-tokens rest)])
       (match char
         [#\+ (values (cons (op-inc)   tail-ops) final-remainder)]
         [#\- (values (cons (op-dec)   tail-ops) final-remainder)]
         [#\< (values (cons (op-left)  tail-ops) final-remainder)]
         [#\> (values (cons (op-right) tail-ops) final-remainder)]
         [#\. (values (cons (op-print) tail-ops) final-remainder)]
         [#\, (values (cons (op-input) tail-ops) final-remainder)]

         [_   (values tail-ops final-remainder)]))] ;; Ignore everything else
    ))
