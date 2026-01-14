
(define-non-fungible-token art-token uint)
(define-data-var last-id uint 0)

(define-public (mint)
  (let (
        (next-id (+ (var-get last-id) u1))
       )
    (begin
      (var-set last-id next-id)
      (nft-mint? art-token next-id tx-sender)
    )
  )
)

(define-public (transfer (id uint) (recipient principal))
  (nft-transfer? art-token id tx-sender recipient)
)

(define-read-only (get-owner (id uint))
  (ok (nft-get-owner? art-token id))
)
