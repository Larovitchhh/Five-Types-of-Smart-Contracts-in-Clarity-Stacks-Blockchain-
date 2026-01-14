
(impl-trait 'SP3FBR2AGK1K3Q5M0J7QEBE5R4V0J0N6P8XH.token-trait.sip010)

(define-fungible-token my-token)
(define-data-var total-supply uint 0)

(define-public (mint (amount uint) (recipient principal))
  (begin
    (ft-mint? my-token amount recipient)
    (var-set total-supply (+ (var-get total-supply) amount))
    (ok true)
  )
)

(define-public (transfer (amount uint) (recipient principal))
  (ft-transfer? my-token amount tx-sender recipient)
)

(define-read-only (get-balance (owner principal))
  (ok (ft-get-balance my-token owner))
)

(define-read-only (get-total-supply)
  (ok (var-get total-supply))
)
