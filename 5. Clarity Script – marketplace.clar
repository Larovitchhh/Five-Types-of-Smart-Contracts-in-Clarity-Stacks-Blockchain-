
(define-trait nft-trait
  (
    (transfer (uint principal principal) (response bool uint))
    (get-owner (uint) (response (optional principal) uint))
  )
)

(define-map listings uint { nft: principal, seller: principal, price: uint })

(define-public (list-nft (id uint) (nft principal) (price uint))
  (begin
    (asserts! (> price u0) "Invalid price")
    (map-set listings id { nft: nft, seller: tx-sender, price: price })
    (ok true)
  )
)

(define-public (buy (id uint))
  (let ((l (map-get listings id)))
    (asserts! (is-some l) "Not listed")
    (let (
          (nft (get nft (unwrap! l "Err")))
          (seller (get seller (unwrap! l "Err")))
          (price (get price (unwrap! l "Err")))
         )
      (stx-transfer? price tx-sender seller)
      (contract-call? nft transfer id seller tx-sender)
      (ok true)
    )
  )
)
