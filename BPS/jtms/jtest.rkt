#lang racket

(require "jtre.rkt")
(provide (all-defined-out))

(in-jtre (create-jtre "Test One" #:debugging #t))
(referent '(foo 1) #t)
(fetch '(foo 1))
(in? '(foo a))
(run-rules)
(uassume! '(foo a) ':user)
(in? '(foo a))

(define-namespace-anchor anc)
(define ns (namespace-anchor->namespace anc))

(define r
  (rule ((:intern (foo ?x) :var ?f :test (number? ?x))
         (:intern (bar ?y) :var ?g :test (number? ?y)))
        (rassert! (mumble ?x ?y) (test-intern ?f ?g))))
(pretty-print r)
(eval r ns)