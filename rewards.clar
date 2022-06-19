(impl-trait 'SP466FNC0P7JWTNM2R9T199QRZN1MYEDTAR0KP27.citycoin-token-trait.citycoin-token)
(use-trait coreTrait 'SP466FNC0P7JWTNM2R9T199QRZN1MYEDTAR0KP27.citycoin-core-trait.citycoin-core)

; Transfers tokens to a specified principal.
(define-constant contract-owner tx-sender)
(define-constant err-unauthorized-sender (err u100))

((define-public (transfer (amount uint) (from principal) (to principal)))
  (begin
    (asserts! (is-eq contr tx-sender) err-unauthorized-sender))
    (ft-transfer? miamicoin amount from to))
)


