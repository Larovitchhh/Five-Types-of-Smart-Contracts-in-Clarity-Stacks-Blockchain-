
(define-data-var proposal-count uint 0)
(define-map proposals uint { description: (string-ascii 100), votes-for: uint, votes-against: uint })
(define-map voted { voter: principal, proposal-id: uint } bool)

(define-public (create-proposal (desc (string-ascii 100)))
  (let (
        (id (+ (var-get proposal-count) u1))
       )
    (begin
      (var-set proposal-count id)
      (map-set proposals id { description: desc, votes-for: u0, votes-against: u0 })
      (ok id)
    )
  )
)

(define-public (vote (proposal-id uint) (support bool))
  (begin
    (asserts! (not (default-to false (map-get? voted { voter: tx-sender, proposal-id: proposal-id }))) "Already voted")
    (map-set voted { voter: tx-sender, proposal-id: proposal-id } true)
    (let (
          (p (map-get proposals proposal-id))
         )
      (if support
          (map-set proposals proposal-id { description: (get description p), votes-for: (+ (get votes-for p) u1), votes-against: (get votes-against p) })
          (map-set proposals proposal-id { description: (get description p), votes-for: (get votes-for p), votes-against: (+ (get votes-against p) u1) })
      )
    )
    (ok true)
  )
)

(define-read-only (get-proposal (id uint))
  (ok (map-get proposals id))
)
