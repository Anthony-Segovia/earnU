(impl-trait .nft-trait.nft-trait)

;; Define complete_certificate
(define-non-fungible-token completion_certificate uint)

;; Define constants
(define-constant contract-owner tx-sender)
(define-constant err-not-token-owner (err u100))
(define-constant err-owner-only (err u101))
;; Store the last issues token ID
(define-data-var last-id uint u0)


;; SIP009: Transfer token to a specified principal
(define-public (transfer (token-id uint) (sender principal) (recipient principal))
  (begin
     (asserts! (is-eq tx-sender sender) err-not-token-owner)
     (nft-transfer? completion_certificate token-id sender recipient)))

;; SIP009: Get the owner of the specified token ID
(define-read-only (get-owner (token-id uint))
  (ok (nft-get-owner? completion_certificate token-id)))

;; SIP009: Get the last token ID
(define-read-only (get-last-token-id)
  (ok (var-get last-id)))

;; SIP009: Get the token URI. You can set it to any other URI
(define-read-only (get-token-uri (token-id uint))
		(ok none)
)

;; Internal - Mint new NFT
(define-public (mint (recipient principal))
    (let ((token-id (+ u1 (var-get last-id) u1)))
      (asserts! (is-eq tx-sender contract-owner) err-owner-only)
      (try! (nft-mint? completion_certificate token-id recipient))
      (var-set last-id token-id)
      (ok token-id)
      ))