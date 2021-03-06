
;; U <- DepC -> C <- DepA -> A <-
;;                                DepD -> D
;;                <- DepB -> B <-

;; (retract! DepA)
;; (assert! A)

(setq *ltms* (create-ltms "Rifleman Example" :complete t))
(setq
 u (tms-create-node *ltms* "u" :ASSUMPTIONP t)
 depC (tms-create-node *ltms* "DepC" :ASSUMPTIONP t)
 c (tms-create-node *ltms* "c" :ASSUMPTIONP t)
 depA (tms-create-node *ltms* "DepA" :ASSUMPTIONP t)
 a (tms-create-node *ltms* "a" :ASSUMPTIONP t)
 depB (tms-create-node *ltms* "DepB" :ASSUMPTIONP t)
 b (tms-create-node *ltms* "b" :ASSUMPTIONP t)
 depD (tms-create-node *ltms* "DepD" :ASSUMPTIONP t)
 d (tms-create-node *ltms* "d" :ASSUMPTIONP t)
 )
(compile-formula *ltms* `(:IMPLIES "DepC" (:AND (:IMPLIES "u" "c")
                                                (:IMPLIES "c" "u"))))
(compile-formula *ltms* `(:IMPLIES "DepA" (:AND (:IMPLIES "c" "a")
                                                (:IMPLIES "a" "c"))))
(compile-formula *ltms* `(:IMPLIES "DepB" (:AND (:IMPLIES "c" "b")
                                                (:IMPLIES "b" "c"))))
(compile-formula *ltms* `(:IMPLIES "DepD" (:AND (:IMPLIES "d" (:OR "a" "b"))
                                                (:IMPLIES (:OR "a" "b") "d"))))
(enable-assumption depC :TRUE)
(enable-assumption depA :TRUE)
(enable-assumption depB :TRUE)
(enable-assumption depD :TRUE)

;; The court U made the order.
;; The prisoder dies.
(enable-assumption u :TRUE)
(explain-node d)

(retract-assumption u)

;; The court does not make the order.
;; The prisoner does not die.
(enable-assumption u :FALSE)
(explain-node d)

;; The prisoner dies.
;; So the court U made the order.
(retract-assumption u)
(enable-assumption d :TRUE)
(explain-node u)

(retract-assumption d)

;; The court U made the order, but rifleman A refuse to fires.
;; The prisoner still dies.
(enable-assumption u :TRUE)
(retract-assumption depA)
(enable-assumption a :FALSE)
(explain-node d)

;; The court U does not make the order, but rifleman A shoot anyways.
;; The prisoner dies.
(retract-assumption u)
(retract-assumption a)
(enable-assumption u :FALSE)
(enable-assumption a :TRUE)
(explain-node d)

(setq *ltms* (create-ltms "Rifleman Example" :complete t))
(setq
 u (tms-create-node *ltms* "u" :ASSUMPTIONP t)
 depC (tms-create-node *ltms* "DepC" :ASSUMPTIONP t)
 c (tms-create-node *ltms* "c" :ASSUMPTIONP t)
 depA (tms-create-node *ltms* "DepA" :ASSUMPTIONP t)
 a (tms-create-node *ltms* "a" :ASSUMPTIONP t)
 depB (tms-create-node *ltms* "DepB" :ASSUMPTIONP t)
 b (tms-create-node *ltms* "b" :ASSUMPTIONP t)
 depD (tms-create-node *ltms* "DepD" :ASSUMPTIONP t)
 d (tms-create-node *ltms* "d" :ASSUMPTIONP t)
 depC* (tms-create-node *ltms* "DepC*" :ASSUMPTIONP t)
 c* (tms-create-node *ltms* "c*" :ASSUMPTIONP t)
 depA* (tms-create-node *ltms* "DepA*" :ASSUMPTIONP t)
 a* (tms-create-node *ltms* "a*" :ASSUMPTIONP t)
 depB* (tms-create-node *ltms* "DepB*" :ASSUMPTIONP t)
 b* (tms-create-node *ltms* "b*" :ASSUMPTIONP t)
 depD* (tms-create-node *ltms* "DepD*" :ASSUMPTIONP t)
 d* (tms-create-node *ltms* "d*" :ASSUMPTIONP t)
 )
(compile-formula *ltms* `(:IMPLIES "DepC" (:IMPLIES "u" "c")))
(compile-formula *ltms* `(:IMPLIES "DepC" (:IMPLIES "c" "u")))
(compile-formula *ltms* `(:IMPLIES "DepA" (:IMPLIES "c" "a")))
(compile-formula *ltms* `(:IMPLIES "DepA" (:IMPLIES "a" "c")))
(compile-formula *ltms* `(:IMPLIES "DepB" (:IMPLIES "c" "b")))
(compile-formula *ltms* `(:IMPLIES "DepB" (:IMPLIES "b" "c")))
(compile-formula *ltms* `(:IMPLIES "DepD" (:IMPLIES "d" (:OR "a" "b"))))
(compile-formula *ltms* `(:IMPLIES "DepD" (:IMPLIES (:OR "a" "b") "d")))

(compile-formula *ltms* `(:IMPLIES "DepC*" (:IMPLIES "u" "c*")))
(compile-formula *ltms* `(:IMPLIES "DepC*" (:IMPLIES "c*" "u")))
(compile-formula *ltms* `(:IMPLIES "DepA*" (:IMPLIES "c*" "a*")))
(compile-formula *ltms* `(:IMPLIES "DepA*" (:IMPLIES "a*" "c*")))
(compile-formula *ltms* `(:IMPLIES "DepB*" (:IMPLIES "c*" "b*")))
(compile-formula *ltms* `(:IMPLIES "DepB*" (:IMPLIES "b*" "c*")))
(compile-formula *ltms* `(:IMPLIES "DepD*" (:IMPLIES "d*" (:OR "a*" "b*"))))
(compile-formula *ltms* `(:IMPLIES "DepD*" (:IMPLIES (:OR "a*" "b*") "d*")))

(enable-assumption depC :TRUE)
(enable-assumption depA :TRUE)
(enable-assumption depB :TRUE)
(enable-assumption depD :TRUE)

(enable-assumption depC* :TRUE)
(enable-assumption depA* :TRUE)
(enable-assumption depB* :TRUE)
(enable-assumption depD* :TRUE)

;; Counterfactual.
;; Had the rifleman A not shooted, would it matter?
(retract-assumption depA*)
(enable-assumption a* :FALSE)
(enable-assumption d :TRUE)
(explain-node d*)
